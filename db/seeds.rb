# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dairy = Category.create(name: 'Dairy')
meat = Category.create(name: 'Meat')
veggies = Category.create(name: 'Vegetables')
bouquets = Category.create(name: 'Bouquets')

butter = Product.create(name: 'Butter', price: 1.39)
butter.category << dairy
milk = Product.create(name: 'Milk', price: 2.89)
milk.category << dairy
chicken = Product.create(name: 'Chicken thighs', price: 8.68)
chicken.category << meat
beef = Product.create(name: 'Ground beef', price: 4.96)
beef.category << meat
veg1 = Product.create(name: 'Broccoli', price: 3.69)
veg1.category << veggies
veg2 = Product.create(name: 'Bok Choy', price: 3.54)
veg2.category << veggies
rose = Product.create(name: 'Roses', price: 15.99)
rose.category << bouquets

calvin = Customer.create(name: 'Calvin')
lena = Customer.create(name: 'Lena')

order1 = Order.create(status: 'Awaiting delivery', customer_id: calvin.id)
order2 = Order.create(status: 'Delivered', customer_id: calvin.id)
order3 = Order.create(status: 'In transit', customer_id: lena.id)

order1.products << butter
order1.products << milk
order1.products << chicken

order2.products << chicken
order2.products << beef
order2.products << veg1
order2.products << rose

order3.products << veg1
order3.products << veg2

calvin.orders << order1
calvin.orders << order2
lena.orders << order3