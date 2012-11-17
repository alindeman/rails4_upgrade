module RailsUpgrade4
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), "tasks", "upgrade.rake")
    end
  end
end
