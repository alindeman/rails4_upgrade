module Rails4Upgrade
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), "tasks", "upgrade.rake")
    end
  end
end
