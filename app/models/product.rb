class Product < ApplicationRecord
  has_and_belongs_to_many :category
  has_many :order_products
  has_many :orders, through: :order_products

  def self.get_breakdown params
    if params[:start_date] && params[:end_date] && params[:range]
      start_date = get_date(params[:start_date])
      end_date = get_date(params[:end_date])
      range = get_range(params[:range])
    end
    
    # orders = Order.where('created_at >= ? and <= ?', start_date, end_date)
    get_products_by_range(start_date, end_date, range)
  end

  def self.get_date date
    begin
      Date.parse(date)
    rescue ArgumentError
      render json: "Error! Date must be in YYYY-MM-DD format."
    end
  end

  def self.get_range range
    if range.downcase == 'day' || range.downcase == 'week' || range.downcase == 'month'
      range.downcase
    else
      render json: "Error! Range options are 'day', 'week', 'month'."
    end
  end

  def self.get_products_by_range start_date, end_date, range
    @@current_date = start_date
    @@products_by_range = {}
    until @@current_date >= end_date
      get_orders_by_date_range range
      range == 'day' ? @@current_date += 1 : @@current_date += range_number(range)
    end
    @@breakdown = []
    count_products_per_range
    @@breakdown
  end

  def self.range_number range
    if range == 'week'
      7
    elsif range == 'month'
      30
    elsif range == 'day'
      0
    end
  end

  def self.get_orders_by_date_range range
    orders = Order.where(created_at: @@current_date.beginning_of_day..(@@current_date + range_number(range)).end_of_day)
    orders.each do |order|
      product_names = order.products.map {|product| product.name}
      @@products_by_range.include?(@@current_date.to_s) ? 
      @@products_by_range["#{@@current_date.to_s}"] += product_names : 
      @@products_by_range["#{@@current_date}"] = product_names
    end
  end

  def self.count_products_per_range
    @@products_by_range.each do |date,products|
      counts = Hash.new 0
      products.each { |product| counts[product] += 1 }
      @@breakdown << {"#{date}": counts}
    end
  end
end
