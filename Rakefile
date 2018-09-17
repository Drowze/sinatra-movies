namespace :db do
  require 'sequel'
  require 'yaml'
  require 'pry'

  ENVIRONMENTS = [:test, :development]
  MIGRATIONS_FOLDER = 'db/migrations'

  def connection(environment)
    db_hash = YAML.load_file(File.join(__dir__, 'config', 'database.yml'))
    Sequel.connect(db_hash.fetch(environment.to_s).transform_keys(&:to_sym))
  end

  task :migrate do
    ENVIRONMENTS.each do |environment|
      Sequel.extension :migration
      Sequel::Migrator.apply(connection(environment), MIGRATIONS_FOLDER)
    end
  end

  task :rollback do
    ENVIRONMENTS.each do |environment|
      Sequel.extension :migration
      conn = connection(environment)
      Sequel::Migrator.apply(conn,
                             MIGRATIONS_FOLDER, 
                             conn[:schema_info].first[:version] - 1)
    end
  end
end
