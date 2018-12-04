class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :open_email
      t.string :blog_url
      t.string :group
      t.string :city
      t.string :introduce

      t.string :facebook_url
      t.string :linkedin_url
      t.string :google_url

      t.references :user

      t.timestamps
    end
  end
end
