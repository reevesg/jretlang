class JRL::Concurrent::Latch < SimpleDelegator
  def initialize( count )
    @l = JRL::Concurrent::CountDownLatch.new( count )
    super( @l )
  end

  def await( time, time_unit = JRL::Concurrent::TimeUnit::SECONDS )
    @l.await( time, time_unit )
  end
end
