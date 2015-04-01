class CreatePosts < ActiveRecord::Migration
  def change
  	create_table :posts do |u|
  		u.string :title
  		u.string :text
  		u.string :url
  		u.integer :user_id
  		u.timestamps null:false
  	end
  end
end
