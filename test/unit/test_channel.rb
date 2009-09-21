require File.dirname(__FILE__) + '/unit_test_helper'

class TestChannel < Test::Unit::TestCase
  def setup
    @fiber = JRL::Fiber.new
    @channel = JRL::Channel.new 
    @fiber.start
  end

  def latch( count ) 
    JRL::Concurrent::Latch.new( count )
  end

  def teardown 
    @fiber.dispose
  end

  def test_pub_sub
    l = latch( 1 )

    result = nil
    @channel.subscribe_on_fiber( @fiber ) { |msg| result = msg; l.count_down }
    @channel.publish "Hello"

    assert l.await( 1 )
    assert_equal "Hello", result
  end

  def test_pub_sub_with_thread_pool
    service = JRL::Concurrent::Executors.newCachedThreadPool();
    fact = JRL::Fibers::PoolFiberFactory.new(service);
    fiber_from_fact = fact.create
    fiber_from_fact.start
    l = latch( 1 )

    result = nil
    @channel.subscribe_on_fiber( fiber_from_fact ) { |msg| result = msg; l.count_down }
    @channel.publish "Hello"

    l.await( 1.5 )
    assert_equal "Hello", result

    fact.dispose
    fiber_from_fact.dispose
    service.shutdown
  end

  def test_fiber_schedule
    l = latch( 1 )
    @fiber.schedule( 0.01 ) { l.count_down }
    assert l.await( 1 )
  end

  def test_fiber_schedule_recurring
    l = latch( 5 )
    @fiber.schedule_with_delay( 1, 2, JRL::Concurrent::TimeUnit::MILLISECONDS ) { l.count_down }
    assert l.await( 1 )
  end

  def test_unsubscribe
    l1 = latch( 1 )
    l2 = latch( 2 )
    unsub = @channel.subscribe_on_fiber( @fiber ) { |msg| l1.count_down; l2.count_down }

    @channel.publish( "one" )
    assert l1.await( 5 )
    unsub.dispose
    @channel.publish( "two" )
    assert !l2.await( 0.01 )
  end

  def test_pub_sub_with_filter
    l = latch( 2 )
    results = []
    filter = lambda { |msg| msg % 2 == 0 }

    @channel.subscribe_on_fiber_with_filter( @fiber, filter ) { |msg| results << msg; l.count_down }
    4.times{ |i| @channel.publish( i ) }

    assert l.await( 1 )
    assert_equal [0,2], results
  end

  def test_batching
    l = latch( 10 )
    total_msgs = 0
    batches = []
    @channel.subscribe_on_fiber_with_batch( @fiber, 0 ) do |msg| 
      batches << msg
      total_msgs += msg.size
      msg.size.times{ l.count_down } 
    end

    10.times{ |i| @channel.publish( i ) }

    assert l.await( 1 )
    assert 10 > batches.size
    assert_equal 10, total_msgs
  end

  def test_batching_with_key
    l = latch( 9 )
    total_msgs = 0
    batches = []
    key_resolver = lambda { |msg| msg.to_s }
    @channel.subscribe_on_fiber_with_batch_and_key( @fiber, key_resolver, 0 ) do |msg| 
      batches << msg
      total_msgs += msg.size
      msg.size.times{ l.count_down }
    end

    [0,1,2,3,4,5,6,7,8,8].each{ |i| @channel.publish( i ) }

    assert 9 > batches.size
    assert l.await( 1 )
    assert_equal 9, total_msgs
  end

  def test_simple_request_response
    reply_fiber = JRL::Fibers::ThreadFiber.new
    reply_fiber.start
    request_channel = JRL::Channels::MemoryRequestChannel.new
    l = latch( 1 )

    request_channel.subscribe( reply_fiber ) { |msg| assert_equal 'hello', msg.get_request; msg.reply( 1 ) }

    response_callback = lambda { |msg| assert_equal 1, msg; l.count_down }

    JRL::Channels::AsyncRequest.with_one_reply( @fiber.__getobj__, request_channel, 'hello', response_callback )
    assert l.await( 1 )

    reply_fiber.dispose
  end

  def test_request_reply_blocking
    reply_queue = JRL::Concurrent::ArrayBlockingQueue.new( 1 )
    @channel.subscribe_on_fiber( @fiber ) { |queue| queue.put( 'hello' ) }
    @channel.publish( reply_queue )

    assert_equal "hello", reply_queue.poll( 1, JRL::Concurrent::TimeUnit::SECONDS )
  end
end
