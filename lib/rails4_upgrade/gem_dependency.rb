module Rails4Upgrade
  class GemDependency < Struct.new(:name, :requirement)
    def initialize(name, requirement)
      requirement = requirement.is_a?(::Gem::Requirement) ? requirement : ::Gem::Requirement.new(requirement)

      super
    end
  end
end
