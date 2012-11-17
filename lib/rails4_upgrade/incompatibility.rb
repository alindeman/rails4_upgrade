module Rails4Upgrade
  class Incompatibility
    attr_reader :dependency, :dependency_chain

    def initialize(dependency, dependency_chain)
      @dependency       = dependency
      @dependency_chain = dependency_chain
    end
  end
end
