class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :password, :string
    add_column :users, :signup_time, :datetime
    add_column :users, :last_signin_time, :datetime
    add_column :users, :last_signin_ip, :string
    add_column :users, :password_digest, :string    
  end
end
