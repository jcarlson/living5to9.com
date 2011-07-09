# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

## Fixes rake 0.9.2 compatibility
## http://benwoodall.com/2011/06/rails-global-access-to-rake-dsl-methods-is-deprecated/
module ::Living5to9Com
  class Application
    include Rake::DSL
  end
end

module ::RakeFileUtils
  extend Rake::FileUtilsExt
end
## End fix

Living5to9Com::Application.load_tasks
