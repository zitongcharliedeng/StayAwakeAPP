class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.int :id
      t.string :session_token
      t.string :refresh_token
      t.timestamp :session_token_expiry

      t.timestamps
    end
  end
end
