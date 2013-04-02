module Rails4Upgrade
  GemIncompatibility = Struct.new(:dependency, :path)

  class IncompatibleGems
    def initialize(gemfile)
      @gemfile = gemfile
    end

    def incompatibilities
      @gemfile.dependencies.reject(&:rails?).inject([]) { |incompatibilities, dependency|
        incompatibilities.concat(incompatibilities_for(dependency))
        incompatibilities
      }
    end

    private

    def incompatibilities_for(gem, dependency_path = [])
      dependency_path += [gem]

      gem.dependencies.inject([]) do |incompatibilities, dependency|
        if dependency.rails?
          if !dependency.satisfied_by_rails4?
            incompatibilities << GemIncompatibility.new(dependency, dependency_path)
          end
        elsif gem.name != dependency.name
          if gem_dependency = @gemfile[dependency.name]
            incompatibilities.concat(incompatibilities_for(gem_dependency, dependency_path))
          end
        end

        incompatibilities
      end
    end
  end
end
