class AddOtherUrlToModel < ActiveRecord::Migration
  def change
    add_column :models, :other_url, :string
  end
end
