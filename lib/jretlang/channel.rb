class JRL::Channel < SimpleDelegator
  def initialize
    mc = JRL::Channels::MemoryChannel.new
    super( mc ) 
  end
end
