class AddUserColumn < ActiveRecord::Migration
    def change
        add_column :opponents, :user_id, :integer
    end
end