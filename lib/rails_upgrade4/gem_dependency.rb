module RailsUpgrade4
  class GemDependency
    RAILS_GEMS = Set.new(
      %w(actionmailer actionpack activemodel activerecord activesupport
         railties activeresource)
    )

    def initialize(dependency)
      @dependency = dependency
    end

    def name
      @dependency.name
    end

    def satisfied_by?(version)
      @dependency.requirement.satisfied_by?(version)
    end

    def is_rails?
      RAILS_GEMS.include?(name)
    end

    def satisfied_by_rails4?
      satisfied_by?(::Gem::Version.new("4.0.0"))
    end
  end
end
