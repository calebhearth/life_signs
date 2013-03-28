require 'spec_helper'

db = "#{Rails.root}/db/test.sqlite3"
`rm #{db}`
ActiveRecord::Migrator.migrate "spec/dummy/db/migrate"
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: db,
)

describe LifeSigns::Activity do
  include Shoulda::Matchers::ActiveRecord
  subject { Activity.new }

  it { should belong_to(:content) }
  it { should belong_to(:actor) }

  describe '.actors' do
    it 'filters by actor type and id' do
      activity = Activity.create(actor_type: 'User', actor_id: 1)

      expect(Activity.actors(User: [1])).to eq [activity]
    end
  end
end
