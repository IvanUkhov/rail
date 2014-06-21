desc 'Precompile assets'
task :assets do
  Rail.applications.first.precompile
end
