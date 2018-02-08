module Rails4Upgrade
  # Encapsulates extraction of specs and dependencies from the Gemfile.lock
  #
  # This is because in Bundler v1.15.0 Bundler::LockfileParser#dependencies
  # changed from an instance of Array to an instance of Hash.
  class Lockfile
    def initialize(lockfile_content)
      @lockfile = Bundler::LockfileParser.new(lockfile_content)
    end

    def specs
      @lockfile.specs
    end

    def dependencies
      if bundler_version <= legacy_bundler_version
        lockfile_dependencies
      else
        lockfile_dependencies.values
      end
    end

    private

    def bundler_version
      ::Gem::Version.create(Bundler::VERSION)
    end

    def legacy_bundler_version
      ::Gem::Version.create('1.14.6')
    end

    def lockfile_dependencies
      @lockfile.dependencies
    end
  end
end
