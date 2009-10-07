class JRL::Fiber < SimpleDelegator
  def initialize
    @f = JRL::Fibers::ThreadFiber.new 
    super( @f )
  end

  def schedule_one_time( delay, time_unit=JRL::Concurrent::TimeUnit::SECONDS, &block )
    @f.schedule( block, delay, time_unit )
  end

  def schedule_repeating( delay, interval, time_unit=JRL::Concurrent::TimeUnit::SECONDS, &block )
    @f.schedule_with_fixed_delay( block, delay, interval, time_unit )
  end
end

