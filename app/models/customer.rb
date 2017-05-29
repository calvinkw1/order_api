class Customer < ApplicationRecord
  has_many :orders

  def self.get_counts params
    customer = Customer.find params[:customer_id]
    category = Category.find params[:category_id]
    category_count = Customer.category_count params

    {
      customer_id: customer.id,
      customer_first_name: customer.name,
      category_id: category.id,
      category_name: category.name,
      number_purchased: category_count
    }
  end

  def self.category_count params
    product_ids = []
    Customer.find(params[:customer_id]).orders.each do |order|
       product_ids << order.products.ids
    end
    product_ids.flatten.count params[:category_id].to_i
  end
end
