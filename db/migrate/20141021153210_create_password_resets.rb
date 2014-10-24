class CreatePasswordResets < ActiveRecord::Migration
  def change
    create_table :password_resets do |t|
      t.references :user, index: true
      t.string :key
      t.boolean :expired, default: false

      t.timestamps
    end
  end
end
