module DatabaseCleanerConfig
  # Configuration for database cleaner
  require 'database_cleaner'
  seed_tables = %w()
  DatabaseCleaner.clean_with :truncation, except: seed_tables
  DatabaseCleaner.strategy = :transaction

  def self.included(base)
    base.class_eval do
      setup do
        DatabaseCleaner.strategy = :truncation if self[:db_truncate]
        DatabaseCleaner.start
      end

      teardown do
        DatabaseCleaner.clean
        DatabaseCleaner.strategy = :transaction if self[:db_truncate]
      end
    end
  end
end
