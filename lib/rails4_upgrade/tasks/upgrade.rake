namespace :upgrade do
  desc "Check for gem incompatibilities with Rails 4"
  task :check_gems do
    gemfile_path = File.join(".", "Gemfile.lock")
    gemfile = Rails4Upgrade::Gemfile.new(File.open(gemfile_path))

    terminal = Rails4Upgrade::Output::Terminal.new(gemfile)
    terminal.output
  end
end
