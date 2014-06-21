namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    Rail.applications.first.precompile
  end
end
