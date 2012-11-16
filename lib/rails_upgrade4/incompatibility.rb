module RailsUpgrade4
  class Incompatibility
    def initialize(gem, dependency_chain)
      @gem              = gem
      @dependency_chain = dependency_chain
    end
  end
end
