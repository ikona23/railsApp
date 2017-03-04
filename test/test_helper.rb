ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module Minitest
  module Reporters
    class AwesomeReporter < DefaultReporter
      GRAY = '0;36'
      GREEN = '1;32'
      RED = '1;31'

      def initialize(options = {})
        super
        @slow_threshold = options.fetch(:slow_threshold, nil)
      end

      def record_pass(test)
        if @slow_threshold.nil? || test.time <= @slow_threshold
          super
        else
          gray('O')
        end
      end

      def color_up(string, color)
        color? ? "\e\[#{ color }m#{ string }#{ ANSI::Code::ENDCODE }" : string
      end

      def red(string)
        color_up(string, RED)
      end

      def green(string)
        color_up(string, GREEN)
      end

      def gray(string)
        color_up(string, GRAY)
      end
    end
  end
end

reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use! [Minitest::Reporters::AwesomeReporter.new(reporter_options)]

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
