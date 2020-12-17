class CreateUsers < ActiveRecord::Migration
    def change
        create_table :Users do |x|
            x.string :username
            x.string :password_digest
        end
    end
end