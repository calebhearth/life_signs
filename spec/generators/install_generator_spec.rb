require 'spec_helper'
require 'generators/install_generator'

describe LifeSigns::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../../tmp', __FILE__)

  specify do
    prepare_destination
    run_generator

    expect(destination_root).to have_structure do
      directory 'app/models' do
        file 'activity.rb'
      end
      directory 'db/migrate' do
        migration 'create_activities' do
          contains 'content'
          contains 'actor'
        end
      end
    end
  end
end
