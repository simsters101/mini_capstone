class MakeUrlImageAttributeIntoText < ActiveRecord::Migration[6.0]
  def change
    change_column :images, :url, :text
  end
end
