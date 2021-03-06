require 'pry'

class Cart < ActiveRecord::Base
  belongs_to(:customer)

  define_method(:check_for_product) do |id|
    self.product_id == id
  end

  define_singleton_method(:product_ids) do |customer_id|
    product_id_array = []
    customer = Customer.find(customer_id)
    customer.carts.each do |item|
      product_id_array.push(item.product_id)
    end
    product_id_array
  end

  define_singleton_method(:total_price) do |customer_id|
    customer = Customer.find(customer_id)
    total_price = 0.00
    customer.carts.each do |cart|
      total_price += cart.price().to_f
    end
    total_price.round(2)
  end
end
