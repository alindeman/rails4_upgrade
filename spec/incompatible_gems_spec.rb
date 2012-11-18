require "spec_helper"

module Rails4Upgrade
  describe IncompatibleGems do
    context "with Devise, a gem that depends on Rails ~> 3.2" do
      let(:gemfile_path) { File.join(File.dirname(__FILE__), "fixtures", "gemfiles", "Gemfile_with_devise.lock") }
      let(:gemfile) { Rails4Upgrade::Gemfile.new(File.open(gemfile_path)) }
      subject(:incompatible_gems) { IncompatibleGems.new(gemfile) }

      it "lists incompatibilities" do
        incompatibilities = incompatible_gems.incompatibilities

        expect(incompatibilities.size).to eq(1)
        expect(incompatibilities[0].dependency).to eq(GemDependency.new("railties", "~> 3.1"))

        expect(incompatibilities[0].path.size).to eq(1)
        expect(incompatibilities[0].path[0].name).to eq("devise")
      end
    end

    context "with Ransack, a gem with multi-level dependencies on Rails ~> 3.0" do
      let(:gemfile_path) { File.join(File.dirname(__FILE__), "fixtures", "gemfiles", "Gemfile_with_ransack.lock") }
      let(:gemfile) { Rails4Upgrade::Gemfile.new(File.open(gemfile_path)) }
      subject(:incompatible_gems) { IncompatibleGems.new(gemfile) }

      it "lists incompatibilities" do
        incompatibilities = incompatible_gems.incompatibilities

        expect(incompatibilities.size).to eq(3)
        expect(incompatibilities[2].dependency).to eq(GemDependency.new("activerecord", "~> 3.0"))
      end

      it "list incompatibilies from ransack itself" do
        incompatibilities = incompatible_gems.incompatibilities

        expect(incompatibilities[0].dependency).to eq(GemDependency.new("actionpack", "~> 3.0"))
        expect(incompatibilities[0].path.size).to eq(1)
        expect(incompatibilities[0].path[0].name).to eq("ransack")

        expect(incompatibilities[1].dependency).to eq(GemDependency.new("activerecord", "~> 3.0"))
        expect(incompatibilities[1].path.size).to eq(1)
        expect(incompatibilities[1].path[0].name).to eq("ransack")
      end

      it "lists incompatibilities from polyamorous, which ransack depends on" do
        incompatibilities = incompatible_gems.incompatibilities

        expect(incompatibilities[2].dependency).to eq(GemDependency.new("activerecord", "~> 3.0"))
        expect(incompatibilities[2].path.size).to eq(2)
        expect(incompatibilities[2].path[0].name).to eq("ransack")
        expect(incompatibilities[2].path[1].name).to eq("polyamorous")
      end
    end
  end
end
