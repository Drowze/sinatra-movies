require 'sequel'

db_hash = YAML.load_file(File.join(settings.root, 'config', 'database.yml'))
DB = Sequel.connect(db_hash.fetch(ENV['RACK_ENV'] || 'development')
                           .transform_keys(&:to_sym))
