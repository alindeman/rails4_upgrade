require "set"
require "rails4_upgrade/gem_dependency"
require "rails4_upgrade/gem"

module Rails4Upgrade
  class Gemfile
    def initialize(lockfile_io)
      @lockfile = Bundler::LockfileParser.new(lockfile_io.read)

      @gems = Hash[@lockfile.specs.map { |spec|
        [
          spec.name,
          Gem.new(
            spec.name,
            spec.version,
            spec.dependencies.map { |dependency| GemDependency.new(dependency.name, dependency.requirement) }
          )
        ]
      }]
    end

    def dependencies
      @dependencies ||= @lockfile.dependencies.map { |dependency|
        self[dependency.name]
      }.compact
    end

    def [](gem_name)
      @gems[gem_name]
    end
  end
end
