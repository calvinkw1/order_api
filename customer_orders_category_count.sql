SELECT customers.id AS customer_id,
  customers.name AS customer_first_name,
  categories.id AS category_id,
  categories.name AS category_name,
  (SELECT count(category_id)
    FROM order_products
    JOIN categories_products
    ON order_products.product_id = categories_products.product_id
    WHERE category_id=2) AS number_purchased
FROM customers, categories
WHERE customers.id=1
AND categories.id =2;