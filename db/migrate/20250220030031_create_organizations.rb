class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.jsonb :configuration, :json, default: {}

      t.timestamps
    end
  end
end
