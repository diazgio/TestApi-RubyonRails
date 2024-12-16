class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""
      t.string :size, null: false, default: ""
      t.string :price, null: false, default: ""
      t.string :discounted_price, null: false, default: ""
      t.string :discount, null: false, default: ""
      t.string :raitings_reviews, null: false, default: ""
      t.float :raitings_average, null: false, default: 0.0
      t.string :image_links, null:false, array: true, default: []

      t.timestamps
    end
  end
end
