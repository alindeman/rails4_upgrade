namespace :upgrade do
  desc "Check for gem incompatibilities with Rails 4"
  task :check_gems do
    gemfile_path = File.join(".", "Gemfile.lock")
    gemfile = Rails4Upgrade::Gemfile.new(File.open(gemfile_path))
    incompatibile_gems = Rails4Upgrade::IncompatibleGems.new(gemfile)

    formatter = Rails4Upgrade::Formatters::IncompatibleGemsFormatter.new(incompatibile_gems)
    formatter.output
  end
end
