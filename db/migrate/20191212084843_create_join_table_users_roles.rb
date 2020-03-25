class CreateJoinTableUsersRoles < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :roles do |t|
      t.index %i[user_id role_id], unique: true
    end
  end
end

