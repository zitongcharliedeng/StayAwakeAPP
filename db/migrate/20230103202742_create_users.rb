class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :access_token
      t.string :refresh_token
      t.timestamp :access_token_expiry

      t.timestamps
    end
  end
end
