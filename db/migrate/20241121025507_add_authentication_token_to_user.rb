class AddAuthenticationTokenToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :authentication_token, :string
  end
end
