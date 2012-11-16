require "spec_helper"

describe RailsUpgrade4::Gemfile do
  context "with Devise, a gem that depends on Rails ~> 3.2" do
    let(:gemfile_path) { File.join(File.dirname(__FILE__), "fixtures", "gemfiles", "Gemfile_with_devise.lock") }
    let(:gemfile) { RailsUpgrade4::Gemfile.new(File.open(gemfile_path)) }

    it "lists the direct dependencies" do
      expect(gemfile.direct_dependencies.map(&:name)).to match_array(["devise"])
    end

    it "lists incompatible gems" do
      expect(gemfile.incompatible_dependencies.map(&:name)).to match_array(["devise"])
    end
  end
end
