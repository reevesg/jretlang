require File.dirname(__FILE__) + '/unit_test_helper'

class TestChannel < Test::Unit::TestCase
  include JRL::Concurrent

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

    assert latch.await( 1, TimeUnit::SECONDS )
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

    latch.await( 1.5, TimeUnit::SECONDS )
    assert_equal "Hello", result

    fact.dispose
    fiber_from_fact.dispose
    service.shutdown
  end

  def test_fiber_schedule
    latch = JRL::Concurrent::CountDownLatch.new( 1 )
    runnable = lambda { |msg| latch.count_down }
    @fiber.schedule( runnable, 0.01, JRL::Concurrent::TimeUnit::SECONDS )
    assert latch.await( 1, JRL::Concurrent::TimeUnit::SECONDS )
  end

#  def test_fiber_schedule_recurring
#    latch = JRL::Concurrent::CountDownLatch.new( 5 )
#    runnable = lambda { |msg| latch.count_down }
#    @fiber.schedule_with_fixed_delay( runnable, 0.001, 0.002, JRL::Concurrent::TimeUnit::SECONDS )
#    assert latch.await( 5, JRL::Concurrent::TimeUnit::SECONDS )
#  end

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

#    @Test
#    public void pubSubWithDedicatedThreadWithFilter() throws InterruptedException {
#        Fiber fiber = new ThreadFiber();
#        fiber.start();
#        Channel<Integer> channel = new MemoryChannel<Integer>();
#
#        final CountDownLatch reset = new CountDownLatch(1);
#        Callback<Integer> onMsg = new Callback<Integer>() {
#            public void onMessage(Integer x) {
#                Assert.assertTrue(x % 2 == 0);
#                if (x == 4) {
#                    reset.countDown();
#                }
#            }
#        };
#        Filter<Integer> filter = new Filter<Integer>() {
#            public boolean passes(Integer msg) {
#                return msg % 2 == 0;
#            }
#        };
#        ChannelSubscription<Integer> sub = new ChannelSubscription<Integer>(fiber, onMsg, filter);
#        channel.subscribe(sub);
#        channel.publish(1);
#        channel.publish(2);
#        channel.publish(3);
#        channel.publish(4);
#
#        Assert.assertTrue(reset.await(5000, TimeUnit.MILLISECONDS));
#        fiber.dispose();
#    }
#
#
#    @Test
#    public void batching() throws InterruptedException {
#        Fiber fiber = new ThreadFiber();
#        fiber.start();
#        MemoryChannel<Integer> counter = new MemoryChannel<Integer>();
#        final CountDownLatch reset = new CountDownLatch(1);
#        Callback<List<Integer>> cb = new Callback<List<Integer>>() {
#            int total = 0;
#
#            public void onMessage(List<Integer> batch) {
#                total += batch.size();
#                if (total == 10) {
#                    reset.countDown();
#                }
#            }
#        };
#
#        BatchSubscriber<Integer> batch = new BatchSubscriber<Integer>(fiber, cb, 0, TimeUnit.MILLISECONDS);
#        counter.subscribe(batch);
#
#        for (int i = 0; i < 10; i++) {
#            counter.publish(i);
#        }
#
#        Assert.assertTrue(reset.await(10000, TimeUnit.MILLISECONDS));
#        fiber.dispose();
#    }
#
#    @Test
#    public void batchingWithKey() throws InterruptedException {
#        Fiber fiber = new ThreadFiber();
#        fiber.start();
#        Channel<Integer> counter = new MemoryChannel<Integer>();
#        final CountDownLatch reset = new CountDownLatch(1);
#        Callback<Map<String, Integer>> cb = new Callback<Map<String, Integer>>() {
#            public void onMessage(Map<String, Integer> batch) {
#                if (batch.containsKey("9")) {
#                    reset.countDown();
#                }
#            }
#        };
#
#        Converter<Integer, String> keyResolver = new Converter<Integer, String>() {
#            public String convert(Integer msg) {
#                return msg.toString();
#            }
#        };
#        KeyedBatchSubscriber<String, Integer> batch = new KeyedBatchSubscriber<String, Integer>(fiber, cb, 0, TimeUnit.MILLISECONDS, keyResolver);
#        counter.subscribe(batch);
#
#
#        for (int i = 0; i < 10; i++) {
#            counter.publish(i);
#        }
#
#        Assert.assertTrue(reset.await(10000, TimeUnit.MILLISECONDS));
#        fiber.dispose();
#    }
#
#
#    @Test
#    // introduced in 1.7
#    public void simpleRequestResponse() throws InterruptedException {
#        Fiber req = new ThreadFiber();
#        Fiber reply = new ThreadFiber();
#        req.start();
#        reply.start();
#        RequestChannel<String, Integer> channel = new MemoryRequestChannel<String, Integer>();
#        Callback<Request<String, Integer>> onReq = new Callback<Request<String, Integer>>() {
#            public void onMessage(Request<String, Integer> message) {
#                assertEquals("hello", message.getRequest());
#                message.reply(1);
#            }
#        };
#        channel.subscribe(reply, onReq);
#
#        final CountDownLatch done = new CountDownLatch(1);
#        Callback<Integer> onReply = new Callback<Integer>() {
#            public void onMessage(Integer message) {
#                assertEquals(1, message.intValue());
#                done.countDown();
#            }
#        };
#        AsyncRequest.withOneReply(req, channel, "hello", onReply);
#        assertTrue(done.await(10, TimeUnit.SECONDS));
#        req.dispose();
#        reply.dispose();
#    }
#
#
#    @Test
#    public void requestReplyWithBlockingQueue() throws InterruptedException {
#        Fiber fiber = new ThreadFiber();
#        fiber.start();
#        BlockingQueue<String> replyQueue = new ArrayBlockingQueue<String>(1);
#        MemoryChannel<BlockingQueue<String>> channel = new MemoryChannel<BlockingQueue<String>>();
#        Callback<BlockingQueue<String>> replyCb = new Callback<BlockingQueue<String>>() {
#            public void onMessage(BlockingQueue<String> message) {
#                try {
#                    message.put("hello");
#                } catch (InterruptedException e) {
#                    throw new RuntimeException(e);
#                }
#            }
#        };
#        channel.subscribe(fiber, replyCb);
#        channel.publish(replyQueue);
#
#        Assert.assertEquals("hello", replyQueue.poll(10, TimeUnit.SECONDS));
#        fiber.dispose();
#    }
#
#
end
