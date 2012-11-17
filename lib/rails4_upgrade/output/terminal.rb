module Rails4Upgrade
  module Output
    class Terminal
      def initialize(gemfile)
        @gemfile = gemfile
      end

      def output(stream = STDOUT)
        @gemfile.direct_dependencies.each do |dependency|
          incompatibilities = dependency.incompatibilities
          if incompatibilities.empty?
            success_color(stream, dependency.name + "\n")
          else
            failure_color(stream, dependency.name + "\n")

            incompatibilities.each do |incompatibility|
              failure_color(stream, "  " + human_readable_incompatibility(incompatibility) + "\n")
            end
          end
        end
      end

      def success_color(stream, text)
        stream.write("\e[34m#{text}\e[0m")
      end

      def failure_color(stream, text)
        stream.write("\e[31m#{text}\e[0m")
      end

      def human_readable_incompatibility(incompatibility)
        dependency_chain = incompatibility.dependency_chain[1..-1]

        output = ""
        unless dependency_chain.empty?
          output << "depends on #{human_readable_dependency_chain(dependency_chain)} which "
        end

        output <<  "depends on #{incompatibility.dependency.name} #{incompatibility.dependency.requirement}"
      end

      def human_readable_dependency_chain(dependency_chain)
        dependency_chain.map { |dependency| "#{dependency.name} #{dependency.version}" }.
                         join(" which depends on ")
      end
    end
  end
end
