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

    it "lists specific incompatibilities" do
      devise = gemfile.incompatible_dependencies[0]

      expect(devise.incompatibilities).to have(1).incompatibility
      expect(devise.incompatibilities[0].dependency_chain.map(&:name)).to eq(["devise"])
    end
  end

  context "with Ransack, a gem that depends on a gem that depends on ActiveRecord ~> 3.0" do
    let(:gemfile_path) { File.join(File.dirname(__FILE__), "fixtures", "gemfiles", "Gemfile_with_ransack.lock") }
    let(:gemfile) { RailsUpgrade4::Gemfile.new(File.open(gemfile_path)) }

    it "lists incompatible gems" do
      expect(gemfile.incompatible_dependencies.map(&:name)).to match_array(["ransack"])
    end

    it "lists specific incompatibilities" do
      ransack = gemfile.incompatible_dependencies[0]

      expect(ransack.incompatibilities).to have(3).incompatibilities

      expect(ransack.incompatibilities[0].dependency_chain.map(&:name)).to eq(["ransack"])
      expect(ransack.incompatibilities[0].gem.name).to eq("actionpack")

      expect(ransack.incompatibilities[1].dependency_chain.map(&:name)).to eq(["ransack"])
      expect(ransack.incompatibilities[1].gem.name).to eq("activerecord")

      expect(ransack.incompatibilities[2].dependency_chain.map(&:name)).to eq(["ransack", "polyamorous"])
      expect(ransack.incompatibilities[2].gem.name).to eq("activerecord")
    end
  end
end
