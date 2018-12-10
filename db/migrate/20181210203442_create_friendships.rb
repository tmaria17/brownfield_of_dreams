class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :frienships do |t|
      t.references :user, foreign_key: true
      t.references :friend_id
      
      t.timestamps
    end
  end
end
