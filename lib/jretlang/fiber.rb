class JRL::Fiber < SimpleDelegator
  def initialize
    @f = JRL::Fibers::ThreadFiber.new 
    super( @f )
  end

  def schedule( time, time_unit=JRL::Concurrent::TimeUnit::SECONDS, &block )
    @f.schedule( block, time, time_unit )
  end

  def schedule_with_delay( delay, time, time_unit=JRL::Concurrent::TimeUnit::SECONDS, &block )
    @f.schedule_with_fixed_delay( block, delay, time, time_unit )
  end
end

