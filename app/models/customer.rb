class Customer < ApplicationRecord
  has_many :orders

  def self.category_count params
    product_ids = []
    Customer.find(params[:customer_id]).orders.each do |order|
       product_ids << order.products.ids
    end
    product_ids.flatten.count params[:category_id].to_i
  end
end
