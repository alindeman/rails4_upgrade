require "set"
require "rails_upgrade4/gem_dependency"
require "rails_upgrade4/gem"

module RailsUpgrade4
  class Gemfile
    RAILS_GEMS = Set.new(
      %w(actionmailer actionpack activemodel activerecord activesupport
         railties activeresource rails)
    )

    def initialize(lockfile_io)
      @lockfile = Bundler::LockfileParser.new(lockfile_io.read)

      @specs = Hash[@lockfile.specs.map { |spec|
        [
          spec.name,
          spec.dependencies.map { |dependency| GemDependency.new(dependency) }
        ]
      }]

      @gems = Hash[@lockfile.specs.map { |dependency|
        [dependency.name, Gem.new(self, dependency)]
      }]

      # Rails gems themselves are not considered
      @dependencies = @lockfile.dependencies.reject { |dependency|
        RAILS_GEMS.include?(dependency.name)
      }.inject([]) { |dependencies, dependency|
        dependencies << @gems[dependency.name]
        dependencies
      }
    end

    def direct_dependencies
      @dependencies
    end

    def dependencies_for(gem_name)
      @specs[gem_name]
    end

    def incompatible_dependencies
      @dependencies.reject { |dependency| dependency.incompatibilities.empty? }
    end
  end
end
