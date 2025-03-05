SELECT * FROM public.menu_items

--Encontrar el número de artículos en el menú.
SELECT COUNT(DISTINCT menu_item_id) as Total_Productos_menu from menu_items 

Select COUNT(DISTINCT menu_item_id) as Total_Productos_menu, category from menu_items group by category 

--¿Cuál es el artículo menos caro y el más caro en el menú?
select * from menu_items
where
price = (
select MAX(price)
from menu_items) 
or 
price = (
select MIN(price)
from menu_items)

Select * from menu_items order by price desc limit 1


--¿Cuántos platos americanos hay en el menú?
select count(DISTINCT menu_item_id)
from menu_items
where category = 'American'

Select COUNT(DISTINCT menu_item_id) as Total_Productos_menu, category from menu_items group by category
--¿Cuál es el precio promedio de los platos? 
select AVG(price) as Precio_Promedio
from menu_items


select * from order_details where order_id = 443


--¿Cuántos pedidos únicos se realizaron en total?
select COUNT(DISTINCT order_id) AS Total_Ordenes
from order_details

--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
Select Order_ID, count(order_id) as Products 
from Order_details 
group by order_id  
having  count(order_id) > 1 
order by Products desc
limit 5

--¿Cuándo se realizó el primer pedido y el último pedido?
Select Max(order_date) as LastDate, Min(order_date) as FirstDate from order_details

--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
Select COUNT(Order_ID) from Order_details where order_date between '2023-01-01' and '2023-01-05'

--Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
Create Temp Table Orders as (
Select OD.Order_Id, OD.Order_date, OD.item_id,MI.Item_Name, MI.Category, MI.Price
from Order_Details  OD
left join menu_items  MI
on OD.item_id = MI.menu_item_id
order by OD.order_date)

select * from orders limit 5
Select DISTINCT category, count(category) as total from orders group by category
