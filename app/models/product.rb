class Product < ApplicationRecord
  validates :image_links, length: { maximum: 8 }
end
