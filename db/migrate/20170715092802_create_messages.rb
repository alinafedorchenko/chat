class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.datetime :created_at
      t.string :topic
      t.text :content

      t.references :sender
      t.references :recipient
    end
  end
end
