# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jretlang}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gareth Reeves"]
  s.date = %q{2009-09-18}
  s.description = %q{A JRuby package of jretlang}
  s.email = %q{reevesg@pobox.com}
  s.files = [
    ".gitignore",
     "Rakefile",
     "VERSION",
     "changelog",
     "lib/jretlang.rb",
     "lib/jretlang/channel.rb",
     "readme",
     "test/unit/test_channel.rb",
     "test/unit/unit_test_helper.rb",
     "vendor/jetlang-0.2.0.jar",
     "vendor/jetlang-0.2.0/jetlang-0.2.0-sources.jar",
     "vendor/jetlang-0.2.0/site/apidocs/allclasses-frame.html",
     "vendor/jetlang-0.2.0/site/apidocs/allclasses-noframe.html",
     "vendor/jetlang-0.2.0/site/apidocs/constant-values.html",
     "vendor/jetlang-0.2.0/site/apidocs/deprecated-list.html",
     "vendor/jetlang-0.2.0/site/apidocs/help-doc.html",
     "vendor/jetlang-0.2.0/site/apidocs/index-all.html",
     "vendor/jetlang-0.2.0/site/apidocs/index.html",
     "vendor/jetlang-0.2.0/site/apidocs/options",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/AsyncRequest.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/BaseSubscription.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/BatchSubscriber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/Channel.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/ChannelSubscription.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/Converter.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/KeyedBatchSubscriber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/LastSubscriber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/MemoryChannel.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/MemoryRequestChannel.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/Publisher.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/Request.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/RequestChannel.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/Session.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/SessionClosed.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/Subscribable.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/Subscriber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/SubscriberList.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/AsyncRequest.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/BaseSubscription.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/BatchSubscriber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/Channel.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/ChannelSubscription.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/Converter.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/KeyedBatchSubscriber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/LastSubscriber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/MemoryChannel.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/MemoryRequestChannel.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/Publisher.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/Request.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/RequestChannel.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/Session.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/SessionClosed.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/Subscribable.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/Subscriber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/class-use/SubscriberList.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/package-frame.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/package-summary.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/package-tree.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/channels/package-use.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/BatchExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/BatchExecutorImpl.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/Callback.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/Disposable.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/DisposingExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/EventBuffer.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/EventReader.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/Filter.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/RunnableBlockingQueue.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/RunnableExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/RunnableExecutorImpl.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/Scheduler.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/SchedulerImpl.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/SynchronousDisposingExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/SynchronousExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/BatchExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/BatchExecutorImpl.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/Callback.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/Disposable.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/DisposingExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/EventBuffer.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/EventReader.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/Filter.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/RunnableBlockingQueue.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/RunnableExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/RunnableExecutorImpl.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/Scheduler.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/SchedulerImpl.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/SynchronousDisposingExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/class-use/SynchronousExecutor.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/package-frame.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/package-summary.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/package-tree.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/core/package-use.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/Fiber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/FiberStub.ScheduledEvent.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/FiberStub.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/PoolFiberFactory.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/ThreadFiber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/class-use/Fiber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/class-use/FiberStub.ScheduledEvent.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/class-use/FiberStub.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/class-use/PoolFiberFactory.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/class-use/ThreadFiber.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/package-frame.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/package-summary.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/package-tree.html",
     "vendor/jetlang-0.2.0/site/apidocs/org/jetlang/fibers/package-use.html",
     "vendor/jetlang-0.2.0/site/apidocs/overview-frame.html",
     "vendor/jetlang-0.2.0/site/apidocs/overview-summary.html",
     "vendor/jetlang-0.2.0/site/apidocs/overview-tree.html",
     "vendor/jetlang-0.2.0/site/apidocs/package-list",
     "vendor/jetlang-0.2.0/site/apidocs/packages",
     "vendor/jetlang-0.2.0/site/apidocs/resources/inherit.gif",
     "vendor/jetlang-0.2.0/site/apidocs/stylesheet.css"
  ]
  s.homepage = %q{http://github.com/reevesg/jretlang}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A JRuby package of jretlang}
  s.test_files = [
    "test/unit/test_channel.rb",
     "test/unit/unit_test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
