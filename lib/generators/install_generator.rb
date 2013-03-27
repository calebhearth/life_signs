require 'rails/generators'
require 'rails/generators/base'
require 'rails/generators/active_record'

module LifeSigns
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../install/templates', __FILE__)

      def create_activities_model
        copy_file 'activity.rb', 'app/models/activity.rb'
      end

      def create_activities_migration
        create_migration('create_activities.rb')
      end

      private

      def create_migration(migration_name)
        migration_template(
          "db/migration/#{migration_name}",
          "db/migration/#{migration_name}",
        )
      end

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end
    end
  end
end
