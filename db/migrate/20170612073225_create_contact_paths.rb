class CreateContactPaths < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_paths do |t|
      t.belongs_to :contact, foreign_key: true
      t.string :tracker_id
      t.string :domain
      t.string :url
      t.string :path
      t.datetime :visited_at

      t.timestamps
    end
  end
end
