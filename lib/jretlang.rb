require 'rubygems'
require 'delegate'

require File.join( File.dirname(__FILE__), "..", "vendor", "jetlang-0.2.5.jar" )

module JRL
  include_package 'org.jetlang.core'

  module Channels
    include_package 'org.jetlang.channels'
  end
  module Fibers
    include_package 'org.jetlang.fibers'
  end
  module Concurrent
    include_package 'java.util.concurrent' 
  end
end

require 'jretlang/latch'
require 'jretlang/channel'
require 'jretlang/fiber'
