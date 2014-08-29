require 'rspec/core/formatters/base_text_formatter'

module RSpec
  module Core
    module Formatters
      class SweetVimRspecFormatter < BaseTextFormatter
        
          ::RSpec::Core::Formatters.register self,
            :example_passed,
            :example_pending,
            :example_failed,
            :dump_summary,
            :dump_failures,
            :dump_pending

        def example_failed(example)
          data = ""
          data << "+-+ "
          data << "[FAIL] #{example.description}\n"

          exception = example.exception
          data << exception.backtrace.find do |frame|
            frame =~ %r{\bspec/.*_spec\.rb:\d+\z}
          end + ": in `#{example.description}'\n" rescue nil

          data << exception.message
          data << "\n+-+ Backtrace\n"
          data << exception.backtrace.join("\n")
          data << "\n-+-\n" * 2
          output.puts data
        end

        def example_pending(example)
          data = ""
          data << "+-+ "
          data << "[PEND] #{example.description}\n"

          pending = example.execution_result[:pending_message]
          data << example.location + ": in `#{example.description}'"
          data << "\n\n-+-\n"
          output.puts data
        end

        def example_passed(notification)
          if ENV['SWEET_VIM_RSPEC_SHOW_PASSING'] == 'true'
            output.puts "[PASS] #{notification.example.full_description}\n"
          end
        end

        def dump_failures *args; end

        def dump_pending *args; end

        def message msg; end

        def dump_summary(*);end

#        def close(notification)
#          super
#          summary = summary_line example_started, failure_count, pending_count
#        end

        private

        def format_message(*); end

      end
    end 
  end 
end 

