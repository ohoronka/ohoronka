namespace :db do
  desc 'This task recreates DB and seeds all data'
  task :recreate => [:drop, :create, :migrate, :seed]
end