require 'spec_helper'
require 'bundler'

require 'rails4_upgrade/lockfile'

module Rails4Upgrade
  describe Lockfile do
    let(:gemfile_path) { File.join(File.dirname(__FILE__), "fixtures", "gemfiles", "Gemfile_with_devise.lock") }
    let(:gemfile_content) { File.open(gemfile_path).read }

    let(:bundler_lockfile) { Bundler::LockfileParser.new(gemfile_content) }

    let(:lockfile) { Lockfile.new(gemfile_content) }

    it "returns the same specs as the bundler lockfile" do
      expect(lockfile.specs).to eq(bundler_lockfile.specs)
    end

    context "when using bundler >= 1.15.0" do
      let(:lockfile_dependencies) { double('lockfile_dependencies') }

      before(:each) {
        lockfile.stub(:bundler_version => ::Gem::Version.create('1.15.0'))
        lockfile.stub(:lockfile_dependencies => lockfile_dependencies)
      }

      it "returns the same dependencies as the bundler lockfile dependencies.values" do
        lockfile_dependencies.should_receive(:values)
        lockfile.dependencies
      end
    end

    context "when using bundler < 1.15.0" do
      let(:lockfile_dependencies) { double('lockfile_dependencies') }

      before(:each) {
        lockfile.stub(:bundler_version => ::Gem::Version.create('1.14.6'))
        lockfile.stub(:lockfile_dependencies => lockfile_dependencies)
      }

      it "returns the same dependencies as the bundler lockfile dependencies" do
        lockfile_dependencies.should_not_receive(:values)
        lockfile.dependencies
      end
    end
  end
end
