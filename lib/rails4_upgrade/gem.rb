require "set"
require "rails4_upgrade/incompatibility"

module Rails4Upgrade
  class Gem < Struct.new(:name, :version, :dependencies)
    RAILS_GEMS = Set.new(
      %w(actionmailer actionpack activemodel activerecord activesupport railties rails coffee-rails sass-rails)
    ).freeze

    def initialize(name, version, dependencies)
      version = version.is_a?(::Gem::Version) ? version : ::Gem::Version.new(version)
      super
    end

    def rails?
      RAILS_GEMS.include?(name)
    end
  end
end
