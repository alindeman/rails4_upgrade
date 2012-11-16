module RailsUpgrade4
  class Incompatibility
    attr_reader :gem, :dependency_chain

    def initialize(gem, dependency_chain)
      @gem              = gem
      @dependency_chain = dependency_chain
    end
  end
end
