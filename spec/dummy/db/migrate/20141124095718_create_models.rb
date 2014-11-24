class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :url

      t.timestamps
    end
  end
end
