namespace :rails4 do
  desc "Run through each precheck for compatibility with Rails 4"
  task :check do
    puts "** GEM COMPATIBILITY CHECK **"
    Rake::Task["rails4:check_gems"].invoke
  end

  desc "Check for gem incompatibilities with Rails 4"
  task :check_gems do
    gemfile_path = File.join(".", "Gemfile.lock")
    gemfile = Rails4Upgrade::Gemfile.new(File.open(gemfile_path))
    incompatibile_gems = Rails4Upgrade::IncompatibleGems.new(gemfile)

    formatter = Rails4Upgrade::Formatters::IncompatibleGemsFormatter.new(incompatibile_gems)
    formatter.output
  end
end
