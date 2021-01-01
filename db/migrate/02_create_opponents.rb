class CreateOpponents < ActiveRecord::Migration
    def change
        create_table :opponents do |x|
            x.string :gamertag
            x.string :game
            x.string :bracket
            x.string :characters
            x.string :score 
        end
    end
end

