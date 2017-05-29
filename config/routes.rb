Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'products#index'
  get '/customers/:customer_id/category_count/:category_id', to: 'customers#get_customer_category_count'
  get '/products/sold_by_date/:start_date/:end_date/:range', to: 'products#get_products_sold_breakdown'
  get 'customers/:customer_id/orders', to: 'customers#get_customer_orders'
  
  resources :orders

  resources :categories do
    resources :products
  end

  resources :customers do
    resources :orders do
      resources :products
    end
  end
end

#                  Prefix Verb   URI Pattern                                                     Controller#Action
#                         GET    /                                                               products#index
#                         GET    /customers/:customer_id/category_count/:category_id(.:format)   customers#get_customer_category_count
#                         GET    /products/sold_by_date/:start_date/:end_date/:range(.:format)   products#get_products_sold_breakdown
#                         GET    /customers/:customer_id/orders(.:format)                        customers#get_customer_orders
#                  orders GET    /orders(.:format)                                               orders#index
#                         POST   /orders(.:format)                                               orders#create
#                   order GET    /orders/:id(.:format)                                           orders#show
#                         PATCH  /orders/:id(.:format)                                           orders#update
#                         PUT    /orders/:id(.:format)                                           orders#update
#                         DELETE /orders/:id(.:format)                                           orders#destroy
#       category_products GET    /categories/:category_id/products(.:format)                     products#index
#                         POST   /categories/:category_id/products(.:format)                     products#create
#        category_product GET    /categories/:category_id/products/:id(.:format)                 products#show
#                         PATCH  /categories/:category_id/products/:id(.:format)                 products#update
#                         PUT    /categories/:category_id/products/:id(.:format)                 products#update
#                         DELETE /categories/:category_id/products/:id(.:format)                 products#destroy
#              categories GET    /categories(.:format)                                           categories#index
#                         POST   /categories(.:format)                                           categories#create
#                category GET    /categories/:id(.:format)                                       categories#show
#                         PATCH  /categories/:id(.:format)                                       categories#update
#                         PUT    /categories/:id(.:format)                                       categories#update
#                         DELETE /categories/:id(.:format)                                       categories#destroy
# customer_order_products GET    /customers/:customer_id/orders/:order_id/products(.:format)     products#index
#                         POST   /customers/:customer_id/orders/:order_id/products(.:format)     products#create
#  customer_order_product GET    /customers/:customer_id/orders/:order_id/products/:id(.:format) products#show
#                         PATCH  /customers/:customer_id/orders/:order_id/products/:id(.:format) products#update
#                         PUT    /customers/:customer_id/orders/:order_id/products/:id(.:format) products#update
#                         DELETE /customers/:customer_id/orders/:order_id/products/:id(.:format) products#destroy
#         customer_orders GET    /customers/:customer_id/orders(.:format)                        orders#index
#                         POST   /customers/:customer_id/orders(.:format)                        orders#create
#          customer_order GET    /customers/:customer_id/orders/:id(.:format)                    orders#show
#                         PATCH  /customers/:customer_id/orders/:id(.:format)                    orders#update
#                         PUT    /customers/:customer_id/orders/:id(.:format)                    orders#update
#                         DELETE /customers/:customer_id/orders/:id(.:format)                    orders#destroy
#               customers GET    /customers(.:format)                                            customers#index
#                         POST   /customers(.:format)                                            customers#create
#                customer GET    /customers/:id(.:format)                                        customers#show
#                         PATCH  /customers/:id(.:format)                                        customers#update
#                         PUT    /customers/:id(.:format)                                        customers#update
#                         DELETE /customers/:id(.:format)                                        customers#destroy