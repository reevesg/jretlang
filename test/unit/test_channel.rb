require File.dirname(__FILE__) + '/unit_test_helper'

class TestChannel < Test::Unit::TestCase
  

  def setup
    @fiber = JRL::Fibers::ThreadFiber.new
    @channel = JRL::Channel.new 
    @fiber.start
  end

  def teardown 
    @fiber.dispose
  end

  def test_pub_sub
    latch = JRL::Concurrent::CountDownLatch.new( 1 )

    result = nil
    @channel.subscribe( @fiber ) { |msg| result = msg; latch.count_down }
    @channel.publish "Hello"

    assert latch.await( 1, JRL::Concurrent::TimeUnit::SECONDS )
    assert_equal "Hello", result
  end

  def test_pub_sub_with_thread_pool
    service = JRL::Concurrent::Executors.newCachedThreadPool();
    fact = JRL::Fibers::PoolFiberFactory.new(service);
    fiber_from_fact = fact.create
    fiber_from_fact.start
    latch = JRL::Concurrent::CountDownLatch.new( 1 )

    result = nil
    @channel.subscribe( fiber_from_fact ) { |msg| result = msg; latch.count_down }
    @channel.publish "Hello"

    latch.await( 1.5, JRL::Concurrent::TimeUnit::SECONDS )
    assert_equal "Hello", result

    fact.dispose
    fiber_from_fact.dispose
    service.shutdown
  end

  def test_fiber_schedule
    latch = JRL::Concurrent::CountDownLatch.new( 1 )
    runnable = lambda { latch.count_down }
    @fiber.schedule( runnable, 0.01, JRL::Concurrent::TimeUnit::SECONDS )
    assert latch.await( 1, JRL::Concurrent::TimeUnit::SECONDS )
  end

  def test_fiber_schedule_recurring
    latch = JRL::Concurrent::CountDownLatch.new( 5 )
    runnable = lambda { latch.count_down }
    @fiber.schedule_with_fixed_delay( runnable, 1, 2, JRL::Concurrent::TimeUnit::MILLISECONDS )
    assert latch.await( 5, JRL::Concurrent::TimeUnit::SECONDS )
  end

  def test_unsubscribe
    latch = JRL::Concurrent::CountDownLatch.new( 1 )
    latch_two = JRL::Concurrent::CountDownLatch.new( 2 )
    unsub = @channel.subscribe( @fiber ) { |msg| latch.count_down; latch_two.count_down }
    @channel.publish( "one" )
    assert latch.await( 5, JRL::Concurrent::TimeUnit::SECONDS )
    unsub.dispose
    @channel.publish( "two" )
    assert !latch_two.await( 0.01, JRL::Concurrent::TimeUnit::SECONDS )
  end

  def test_pub_sub_with_filter
    latch = JRL::Concurrent::CountDownLatch.new( 2 )
    results = []
    runnable = lambda { |msg| results << msg; latch.count_down }
    filter = lambda { |msg| msg % 2 == 0 }

    sub = JRL::Channels::ChannelSubscription.new( @fiber, runnable, filter )
    @channel.subscribe( sub )
    4.times{ |i| @channel.publish( i ) }

    assert latch.await( 1, JRL::Concurrent::TimeUnit::SECONDS )
    assert_equal [0,2], results
  end

  def test_batching
    latch = JRL::Concurrent::CountDownLatch.new( 10 )
    total_msgs = 0
    batches = []
    runnable = lambda { |msg| batches << msg; total_msgs += msg.size; msg.size.times{ latch.count_down } }

    batch = JRL::Channels::BatchSubscriber.new( @fiber, runnable, 0, JRL::Concurrent::TimeUnit::SECONDS)
    @channel.subscribe( batch )
    10.times{ |i| @channel.publish( i ) }

    assert latch.await( 1, JRL::Concurrent::TimeUnit::SECONDS )
    assert 10 > batches.size
    assert_equal 10, total_msgs
  end

  def test_batching_with_key
    latch = JRL::Concurrent::CountDownLatch.new( 9 )
    total_msgs = 0
    batches = []
    runnable = lambda { |msg| batches << msg; total_msgs += msg.size; msg.size.times{ latch.count_down } }
    key_resolver = lambda { |msg| msg.to_s }

    batch = JRL::Channels::KeyedBatchSubscriber.new( @fiber, runnable, 0, JRL::Concurrent::TimeUnit::SECONDS, key_resolver)
    @channel.subscribe( batch )
    [0,1,2,3,4,5,6,7,8,8].each{ |i| @channel.publish( i ) }

    assert 9 > batches.size
    assert latch.await( 1, JRL::Concurrent::TimeUnit::SECONDS ), 'latch await'
    assert_equal 9, total_msgs
  end

  def test_simple_request_response
    reply_fiber = JRL::Fibers::ThreadFiber.new
    reply_fiber.start
    request_channel = JRL::Channels::MemoryRequestChannel.new
    latch = JRL::Concurrent::CountDownLatch.new( 1 )

    reply_callback = lambda { |msg| assert_equal 'hello', msg.get_request; msg.reply( 1 ) }
    request_channel.subscribe( reply_fiber, reply_callback )

    response_callback = lambda { |msg| assert_equal 1, msg; latch.count_down }

    JRL::Channels::AsyncRequest.with_one_reply( @fiber, request_channel, 'hello', response_callback )
    assert latch.await( 1, JRL::Concurrent::TimeUnit::SECONDS ), 'latch await'

    reply_fiber.dispose
  end

  def test_request_reply_blocking
    reply_queue = JRL::Concurrent::ArrayBlockingQueue.new( 1 )
    callback = lambda { |queue| queue.put( 'hello' ) }
    @channel.subscribe( @fiber, callback )
    @channel.publish( reply_queue )

    assert_equal "hello", reply_queue.poll( 1, JRL::Concurrent::TimeUnit::SECONDS )
  end
end
