require "rails4_upgrade/incompatibility"

module Rails4Upgrade
  class Gem < Struct.new(:name, :version, :dependencies)
    def initialize(name, version, dependencies)
      version = version.is_a?(::Gem::Version) ? version : ::Gem::Version.new(version)

      super
    end
  end
end
