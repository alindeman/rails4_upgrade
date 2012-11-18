module Rails4Upgrade
  module Formatters
    class IncompatibleGemsFormatter
      def initialize(incompatible_gems)
        @incompatible_gems = incompatible_gems
      end

      def output(stream = STDOUT)
        incompatibilities = @incompatible_gems.incompatibilities
        if incompatibilities.empty?
          stream.puts colorize(:success, "No gem incompatibilities found")
        else
          incompatibilities.each do |incompatibility|
            stream.puts colorize(:failure, "#{human_readable_dependency_path(incompatibility.path)} depends on #{incompatibility.dependency.name} #{incompatibility.dependency.requirement}")
          end
        end
      end

      private

      def human_readable_dependency_path(path)
        path.map { |dependency| "#{dependency.name} #{dependency.version}" }.join(" -> ")
      end

      def colorize(tag, string)
        case tag
        when :failure
          "\e[31m#{string}\e[0m"
        when :success
          "\e[35m#{string}\e[0m"
        end
      end
    end
  end
end
