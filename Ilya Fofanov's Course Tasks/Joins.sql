/* 1. Найти заказчиков и обслуживающих их заказы сотрудников таких, что и заказчики и сотрудники из города London,
а доставка идёт компанией Speedy Express. Вывести компанию заказчика и ФИО сотрудника.*/
SELECT customers.company_name, (employees.first_name || ' ' || employees.last_name) AS employee
FROM orders
JOIN employees USING(employee_id) -- instead of "ON orders.employee_id = employees.employee_id"
JOIN shippers ON orders.ship_via = shippers.shipper_id
JOIN customers USING (customer_id)
WHERE customers.city = 'London' AND employees.city = 'London' AND shippers.company_name = 'Speedy Express'
	
/* 2. Найти активные (см. поле discontinued) продукты из категории Beverages и Seafood, которых в продаже менее 20 единиц.
Вывести наименование продуктов, кол-во единиц в продаже, имя контакта поставщика и его телефонный номер.*/
SELECT product_name, units_in_stock, contact_name, phone
FROM products
JOIN suppliers USING(supplier_id)
JOIN categories USING(category_id)
WHERE discontinued = 0 AND category_name IN ('Beverages', 'Seafood') AND units_in_stock < 20
ORDER BY units_in_stock

-- 3. Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.
SELECT contact_name, COUNT(order_id) -- just to make sure it's NULL
FROM customers
LEFT JOIN orders USING(customer_id)
GROUP BY contact_name
HAVING SUM(order_id) IS NULL

-- 4. Переписать предыдущий запрос, использовав симметричный вид джойна (подсказка: речь о LEFT и RIGHT).
SELECT contact_name, COUNT(order_id)
FROM orders
RIGHT JOIN customers USING(customer_id)
GROUP BY contact_name
HAVING SUM(order_id) IS NULL
