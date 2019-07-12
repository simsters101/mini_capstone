class Product < ApplicationRecord
  belongs_to :supplier, optional: true
  has_many :images
  has_many :orders

  # validates :name, presence: true
  # validates :name, uniqueness: true
  # validates :price, presence: true
  # validates :price, numericality: { greater_than: 0 }
  # validates :description, presence: true
  # validates :description, length: { in: 10..500 }

  def supplier
    Supplier.find_by(id: supplier_id)
  end

  def is_discounted?
    price < 10
  end

  def tax
    tax_rate = 0.09
    price * tax_rate
  end

  def full_price
    price + tax
  end
end
