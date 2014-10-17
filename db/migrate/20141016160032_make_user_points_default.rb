class MakeUserPointsDefault < ActiveRecord::Migration
  def change
    change_column :users, :score, :integer, default: 1
  end
end
