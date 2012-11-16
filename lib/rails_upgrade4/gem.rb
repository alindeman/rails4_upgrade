require "rails_upgrade4/incompatibility"

module RailsUpgrade4
  class Gem
    def initialize(gemfile, dependency)
      @gemfile      = gemfile
      @dependency   = dependency
    end

    def name
      @dependency.name
    end

    def dependencies
      @gemfile.dependencies_for(name)
    end

    def incompatibilities(chain = [])
      chain = chain + [self]

      incompatibilities = []
      dependencies.each { |dependency|
        if dependency.is_rails? && !dependency.satisfied_by_rails4?
          incompatibilities << Incompatibility.new(dependency, chain)
        end
      }

      incompatibilities
    end
  end
end
