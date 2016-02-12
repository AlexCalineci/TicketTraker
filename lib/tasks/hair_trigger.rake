$VERBOSE = nil
Dir["#{Gem::Specification.find_by_name('hairtrigger').full_gem_path}/lib/tasks/*.rake"].each { |ext| load ext }
