require "terminal-table"

module Rails4Upgrade
  module Formatters
    class IncompatibleGemsFormatter
      def initialize(incompatible_gems)
        @incompatible_gems = incompatible_gems
      end

      def output(stream = STDOUT)
        incompatibilities = @incompatible_gems.incompatibilities
        if incompatibilities.empty?
          stream.puts "No gem incompatibilities found"
        else
          rows = []
          incompatibilities.each do |incompatibility|
            rows << [
              human_readable_dependency_path(incompatibility.path),
              human_readable_dependency(incompatibility.dependency)
            ]
          end

          stream.puts Terminal::Table.new(
            headings: ["Dependency Path", "Rails Requirement"],
            rows:     rows
          )
        end
      end

      private

      def human_readable_dependency_path(path)
        path.map { |dependency| "#{dependency.name} #{dependency.version}" }.join(" -> ")
      end

      def human_readable_dependency(dependency)
        "#{dependency.name} #{dependency.requirement}"
      end
    end
  end
end
