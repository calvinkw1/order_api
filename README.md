## Technical screen for Shipt

### Assumptions
1. Product and Category `has_and_belongs_to_many` relationship assumes there will **never** be any need to add additional columns to this table, as the only references needed will be each others' IDs.
2. Orders and Products `has_many, through` relationship was set up to allow for flexibility in usage of the `orders_products` model, allowing the addition of other columns such as `quantity`.

### Features
1. The SQL file for the following output format is contained in `/customer_orders_category_count.sql`. The ORM usage is in the Customers Controller under `get_customer_category_count` and can be hit via the `/customers/:customer_id/category_count/:category_id` route.

	`customer_id | customer_first_name | category_id | category_name | number_purchased`

2. API endpoint for date range breakdown by day/week/month is `'/products/sold_by_date/:start_date/:end_date/:range'` and hits the the Products Controller `get_products_sold_breakdown` action.

3. API endpoint to return customer's orders is `/customers/:customer_id/orders` and hits the Customers Controller `get_customer_orders` action.

### One click bulk ordering
A customer can have many lists. A list can have many products and a product can have many lists.

I'd add `Lists` and `ListItems` models and set up the relationship as:

	:list has_many :products, through: :list_items
	:product has_many :lists, through: :list_items
	:list_item belongs_to :list
	:list_item belongs_to :product

The `lists_items` table would allow me to also add columns like `quantity`, `purchase_count`, or `favorite_list`. There wouldn't really be any performance implications and in general makes it easy to query via ActiveRecord. Only con I can think of is that it's a bit more time consuming than a `HABTM` relationship to set up because of the need to generate a model for the join table.

### High traffic inventory management
Assuming these are highly coveted items (like a new release of Addidas UltraBoosts or tickets to Hamilton), I believe the best implementation of management of high traffic and limited inventory would be something akin to Ticketmaster's timed system.

This sets users up with a reasonable amount of time to complete their checkout, giving users with slower connections a chance to snag the item.

There may also be an inventory threshold minimum that's set to trigger a purchase limit based on demand, limiting a user to a quantity of `n` of the particular item for a 24 hour period.

### If I had more time...
1. Implement a test suite with RSpec.
2. Clean up unused routes and controller methods generated from Rails scaffolding.
3. Proper database seeding for a wider variety of database relationships to test on.
4. Refactor Product model methods for the products sold breakdown.