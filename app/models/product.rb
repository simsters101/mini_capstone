class Product < ApplicationRecord
  def is_discounted?
    if self.price < 10
      the_boolean = true  
    else
      the_boolean = false
    end
  end

  def tax
    price * 0.09
  end

  def full_price
    price + (price * 0.09)
  end

  def formatted_price
    "$#{price}"
  end

  def formatted_tax
    "$#{tax}"
  end

  def formatted_full_price
    "$#{full_price}"
  end
end
