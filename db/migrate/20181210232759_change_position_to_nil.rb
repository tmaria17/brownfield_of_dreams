class ChangePositionToNil < ActiveRecord::Migration[5.2]
  def change
    Video.update_all(position: nil)
  end
end
