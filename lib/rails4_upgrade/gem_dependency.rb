module Rails4Upgrade
  class GemDependency < Struct.new(:name, :requirement)
    RAILS_GEMS = Set.new(
      %w(actionmailer actionpack activemodel activerecord activesupport railties rails)
    ).freeze

    def initialize(name, requirement)
      requirement = requirement.is_a?(::Gem::Requirement) ? requirement : ::Gem::Requirement.new(requirement)
      super
    end

    def rails?
      RAILS_GEMS.include?(name)
    end

    def satisfied_by_rails4?
      requirement.satisfied_by?(::Gem::Version.new("4.0.0"))
    end
  end
end
