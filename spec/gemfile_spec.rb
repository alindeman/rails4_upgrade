require "spec_helper"

module Rails4Upgrade
  describe Gemfile do
    let(:gemfile_path) { File.join(File.dirname(__FILE__), "fixtures", "gemfiles", "Gemfile_with_devise.lock") }
    let(:gemfile) { Rails4Upgrade::Gemfile.new(File.open(gemfile_path)) }

    it "lists the direct dependencies" do
      devise = gemfile.dependencies[0]
      expect(devise.name).to eq("devise")
      expect(devise.version).to eq(::Gem::Version.new("2.1.2"))

      rails = gemfile.dependencies[1]
      expect(rails.name).to eq("rails")
      expect(rails.version).to eq(::Gem::Version.new("3.2.8"))
    end

    it "returns the specific details about a given gem" do
      bcrypt = gemfile["bcrypt-ruby"]
      expect(bcrypt.name).to eq("bcrypt-ruby")
      expect(bcrypt.version).to eq(::Gem::Version.new("3.0.1"))
    end

    it "lists the dependencies of a given gem" do
      devise = gemfile["devise"]
      expect(devise.dependencies).to match_array([
        GemDependency.new("bcrypt-ruby",  "~> 3.0"),
        GemDependency.new("orm_adapter",  "~> 0.1"),
        GemDependency.new("railties",     "~> 3.1"),
        GemDependency.new("warden",       "~> 1.2.1")
      ])
    end
  end
end
