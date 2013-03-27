class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :content_type
      t.belongs_to :content
      t.string :actor_type
      t.belongs_to :actor

      t.timestamps
    end

    add_index :activities, [:content_id, :content_type]
    add_index :activities, :content_type
    add_index :activities, [:actor_id, :actor_type]
    add_index :activities, :actor_type
  end
end
