class Product < ApplicationRecord
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
