namespace :upgrade do
  desc "Check for gem incompatibilities with Rails 4"
  task :check_gems do
    gemfile_path = File.join(".", "Gemfile.lock")
    gemfile = RailsUpgrade4::Gemfile.new(File.open(gemfile_path))

    terminal = RailsUpgrade4::Output::Terminal.new(gemfile)
    terminal.output
  end
end
