class JRL::Channel < SimpleDelegator
  def initialize
    @mc = JRL::Channels::MemoryChannel.new
    super( @mc ) 
  end

  def subscribe_on_fiber( fiber, &block )
    @mc.subscribe( strip_delegate( fiber ), &block )
  end

  def subscribe_on_fiber_with_filter( fiber, filter_lambda, &block )
    subscription = JRL::Channels::ChannelSubscription.new( strip_delegate( fiber ), block, filter_lambda )
    @mc.subscribe( subscription )
  end

  def subscribe_on_fiber_with_batch( fiber, time, time_unit=JRL::Concurrent::TimeUnit::SECONDS, &block )
    batch = JRL::Channels::BatchSubscriber.new( strip_delegate( fiber ), block, time, time_unit )
    @mc.subscribe( batch )
  end

  def subscribe_on_fiber_with_batch_and_key( fiber, key_lambda, time, time_unit=JRL::Concurrent::TimeUnit::SECONDS, &block )
    batch = JRL::Channels::KeyedBatchSubscriber.new( strip_delegate( fiber ), block, time, time_unit, key_lambda )
    @mc.subscribe( batch )
  end

  private 
  def strip_delegate( fiber )
    case fiber
    when JRL::Fiber
      fiber.__getobj__
    else
      fiber
    end
  end
end
