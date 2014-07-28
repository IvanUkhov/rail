desc 'Precompile assets'
task :assets do
  Rail.applications.map(&:new).each(&:precompile)
end
