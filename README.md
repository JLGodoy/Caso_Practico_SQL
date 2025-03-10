# Caso_Practico_SQL
Repositorio creado para la entrega del caso práctico de SQL del diplomado en ciencia de datos de la U de Colima.

## Introducción

Las siglas SQL significa *Structured Query Language*; es un lenguaje de programación que se utiliza para la manipulación de datos almacenados en *bases de datos relacionales*. Es una herramienta fundamental para la administración de sistemas de bases de datos estructuradas, que son los más utilizados para aplicaciones de negocios en empresas de tecnología y economía, lo cual nos da una idea de la importancia de la necesidad de aprender este lenguaje. 

## Caso Práctico

Para el desarrollo del ejercicio presente se nos ha solicitado el análisis de las ventas de una cafetería, con un menú extenso dividio en diferentes secciones. EL objetivo del análisis es encontrar información que sea relevante para los propietarios del establecimiento. Los datos están divididos en dos tablas, la primera contiene los productos disponibles en el menú de la cafetería, con detalles tales como el nombre del producto, el precio y la categoría en la que puede clasificarse el platillo. La segunda es un conjuto de pedidos, que se distribuyen de manera similar a como se reportaría la compra en un ticket de venta. En esta segunda tabala podemos apreciar detalles como la fecha de compra, la hora de la compra, el id del producto, con la característica de que cada producto se agrega en una fila por separado. 

### Primera actividad

1.Realizar consultas para contestar las siguientes preguntas:
  - Encontrar el número de artículos en el menú.
    - Para encontrar el número total de productos en el menú, se utiliza el comando **COUNT**, aplicado al identifcador único de cada producto, para evitar productos repetidos se utiliza le comando **DISTINCT**, quedando la consulta de la siguiente forma:
    ```
      --Encontrar el número de artículos en el menú.
        SELECT COUNT(DISTINCT menu_item_id) as Total_Productos_menu from menu_items
    ```
    Tras ejecutar la consulta citada, se obtiene el siguiente resultado
    
    ![image](https://github.com/user-attachments/assets/1574957a-88eb-44a6-ae23-359fdb49bbe9)

  - ¿Cuál es el artículo menos caro y el más caro en el menú?
    - El artículo más caro del menu es el artículo con el precio más alto, por lo cual, si ordenamos de forma ascendente los productos en la lista, tomando como criterio para el acomodo el precio del producto, lo mismo sucede con el prodcuto más caro. La consulta para la solución de este apartado se presenta a continuación.
      ```
        select * from menu_items
        where
        price = (
        select MAX(price)
        from menu_items) 
        or 
        price = (
        select MIN(price)
        from menu_items)
      ```
        Cuando se ejecuta la consulta anterior, se obtiene el siguiente resultado.

      ![image](https://github.com/user-attachments/assets/a8dd46ed-977f-4622-bf91-c02da64cf068)

  - ¿Cuántos platos americanos hay en el menú?
    - De la misma forma que con el total de productos, aquí se debe hacer una cuenta de elementos distintos del menú, agregando la peculiaridad de la categoria.          Con esta modificación, se obtiene la siguiente consulta.
   
      ```
        select count(DISTINCT menu_item_id) as TotalProductosAmericanos
        from menu_items
        where category = 'American'
      ```

      De la ejecución de la consulta anterior se obtiene el siguiente resultado:

      ![image](https://github.com/user-attachments/assets/7ee241b0-3604-4c69-9100-771ba9e5d985)

   
  - ¿Cuál es el precio promedio de los platos?
    - El precio promedio de los platos se obtiene con el comando **AVG**. Aplicando el comando a los precios, de la siguiente forma:
       ```
        --¿Cuál es el precio promedio de los platos? 
         select AVG(price) as Precio_Promedio
         from menu_items
        ```

       ![image](https://github.com/user-attachments/assets/e298cde4-a87a-4f00-b96d-fcdd8bb91fea)

### Segunda Actividad
1. Realizar consultas para contestar las siguientes preguntas:
   
  - ¿Cuántos pedidos únicos se realizaron en total?
      De la misma forma que con el total de productos en el menú, se utiliza el comando **COUNT** con el comando **DISTINCT** para asegurar que no se cuenten valores repetidos. Cada pedido tiene un identificador único, pero este se repite por cada producto que se incluye en el pedido, lo cual hace que el comando **DISTINCT** sea fundamental en esta consulta. 
    ```
    --¿Cuántos pedidos únicos se realizaron en total?
    select COUNT(DISTINCT order_id) AS Total_Ordenes
    from order_details
    ```
    De la ejecución de esta consulta, obtenemos el siguiente resultado:
    
    ![image](https://github.com/user-attachments/assets/10f201a6-8005-41cb-8044-def6f3d73aaa)

  - ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
    Se debe implemetar una consulta que cuente el total de artículos por pedido y nos regrese aquellos que tengan el mayor número de artículos, por lo cual se debe hacer una suma de los artículos por pedido, y ordernarlos por esta suma de forma descendente, limitandolo a los primeros cinco puestos, que deberían ser los que más artículos contienen. 
    ```
    --¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
    Select Order_ID, count(order_id) as Products 
    from Order_details 
    group by order_id  
    having  count(order_id) > 1 
    order by Products desc
    limit 5
    ```
    De esta consulta se obtiene el siguiente resultado.
    
    ![image](https://github.com/user-attachments/assets/8ae7bfde-fe3b-4460-93d2-ade1c028d696)

  - ¿Cuándo se realizó el primer pedido y el último pedido?
      Para obtener las primera y última fecha de los pedidos, se realiza una consulta dónde se solicitan el número mayor y menor dentro de los formatos de fecha. con lo cual se obtiene el siguiente resultado:
    
    ```
    --¿Cuándo se realizó el primer pedido y el último pedido?
    Select Max(order_date) as LastDate, Min(order_date) as FirstDate from order_details
    ```

    ![image](https://github.com/user-attachments/assets/ac646053-d565-4ec0-8815-5b70eff1009f)

  - ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
    Se realiza una cuenta de los pedidos realizados en esas fechas con la siguiente consulta:
    ```
    --¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
    Select COUNT(Order_ID) from Order_details where order_date between '2023-01-01' and '2023-01-05'
    ```
    ![image](https://github.com/user-attachments/assets/0310b4b0-1c32-4805-8584-dff9c70d12ff)

### Tercera actividad 
Usar ambas tablas para conocer la reacción de los clientes respecto al menú.

  1. Realizar un left join entre entre order_details y menu_items con el identificador item_id(tabla order_details) y menu_item_id(tabla menu_items).
     Se utilzó una tabla temporal que contenga la unión de ambas tablas, de tal forma que las consultas realacionadas con esta sección se puedan realizar de forma más sencilla. 
```
--Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
Create Temp Table Orders as (
Select OD.Order_Id, OD.Order_date, OD.item_id,MI.Item_Name, MI.Category, MI.Price
from Order_Details  OD
left join menu_items  MI
on OD.item_id = MI.menu_item_id
order by OD.order_date)
```
Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas. El
objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del
restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas y
utiliza los resultados obtenidos para llegar a estas conclusiones.

1. ¿Cuáles son los cinco platillos más vendidos?
  Conocer los platillos estrellas del restaurante nos da un margen de cuales son las posibilidades de inversión den la mejora de esos productos, además de conocer las posibles acciones para lograr esa mejora. Para la obtención de los platillos estrella del resataurante se desarrolló la siguiente consulta.  
```
    Select  item_name,count(item_id) as TotalVendido 
    from orders group by item_name having Count(item_id) > 1 
    order by TotalVendido desc
    limit 5
```
  
![image](https://github.com/user-attachments/assets/916c618b-912b-4b34-acad-b245e8f427a0)
De la consulta podemos observar que tres de los platillos estrella de nuetro menú son de la categoría *American*. Dos de ellos son similares (Hamburguer y Cheeseburguer), lo cual nos permite saber que los clientes prefieren la comida rápida a los platillos más elaborados. Se sugiere experimentar con la calidad de los ingredientes, ya sea en buscar un proveedor de carnes que nos ofrezca carne de meor calidad a un precio más bajo, para incrementar las ganancias de los mismos. También podemos observar que, el segundo platillo más vendido del menú es una entrada, que se puede considerar de rápida preparación y bajo coste. Se consideran bajas posibilidades para la mejora del producto. 

2. ¿Cuáles son las categorías más vendidas?
Conocer las cantidades vendidas por categorías nos permite conocer las tendencias de preferencias de los clientes, para realizar modificaciones al menú que nos permita incluir poductos de las categorías más populares.  
```
Select DISTINCT category, count(category) as total 
from orders group by category order by total
```
![image](https://github.com/user-attachments/assets/c2a3a306-2223-4791-b6bd-fa1614e2a6bc)

A diferencia de lo mostrado con la consulta anterior, nos encontramos con que la categoría *American* es la menos solicitada, siendo *Asian* la categoría más popular. Podemos enfocarnos en ampliar la variedad de productos de esa categoria y experimentar para la introducción  de forma más segura de productos de este tipo en el menú. 

3. ¿Cuál es el promedio de artículos vendidos por categoría?

  El promedio de artículos vendidos por categortía nos servirá como un parámetro para evaluar la viabilidad de mantener un producto en el menú, ya que si este se encuentra por debajo de la media de las ventas por categoría, sería un artículo que tiene severas dificultades para llamar la atención de los clientes. 
```
Select DISTINCT category, AVG(item_id) as PromedioVentas 
from orders group by category order by PromedioVentas desc
```
  ![image](https://github.com/user-attachments/assets/055aa606-909f-47e5-8ec9-e58a2a2c749c)

4. ¿Cuáles son los productos menos vendidos?

  Conocer los productos menos vendidos nos permite analizar si es viable conservar estos productos en el menú, ya sea realizando una inversión para modificar las recetas o mejorar la calidad de los productos. 
  
   ```
    Select  item_name,count(item_id) as TotalVendido 
    from orders group by item_name having Count(item_id) > 1 
    order by TotalVendido asc
    limit 5
  ```
  ![image](https://github.com/user-attachments/assets/eb039b86-bfec-465e-a186-4fdff97b4f3f) 
  
  
5. ¿Cuál es el producto menos vendido por categoría?

   Con esta consulta podemos observar las tendencias de los productos menos vendidos y hacer una comparación de sus ventas con la media de las ventas por categoría, de tal manera que, si las ventas totales del producto son muy inferiores a la media de la categoría, el producto no tiene mucho éxito entre los clientes y si la distancia es muy alta, se debe considerar si son aptos para conservarse en el menú.
```
Select category, count(item_id) as TotalVendido, item_name as total 
from orders where category = 'American' group by item_name, category 
order by TotalVendido asc limit 5
```
![image](https://github.com/user-attachments/assets/af36d29c-bea5-4ec7-9a5b-bf7c8fd7933e)

Para la categoría *American* la media se encuentra en 103 puntos. Los productos menos populares de esta categoría sobrepasan cuando menos por el doble esa media, por lo cual esta categoría puede ser sometida a un escrutinio más técnico con respecto a las recetas o la calidad de los ingredientes. Se considera que puede tratarse de incrementar la venta de estos productos en lugar de descartarlos directamente del menú. 

```
Select category, count(item_id) as TotalVendido, item_name as total 
from orders where category = 'Mexican' group by item_name, category 
order by TotalVendido asc limit 5
```

![image](https://github.com/user-attachments/assets/f5e4fd8d-c65c-4f84-948a-f406084d8088)

La categoría *Mexican* tiene una media de 119. El producto menos vendido de la categoría está muy ligeramente por encima de ese valor, por lo cual se considera que ese producto  es candidato a ser reemplazado por un platillo nuevo. El segundo producto menos vendido está casi duplicando el valor de la media de ventas de la categoría, por lo cual no se considera candidato a reemplazo directamente, sin embargo, la categoría es la segunda menos vendida, por lo cual se sugiere que estos productos sean valorados más a profundidad para asegurar su permanencia en el menú. 

```
Select category, count(item_id) as TotalVendido, item_name as total 
from orders where category = 'Italian' group by item_name, category 
order by TotalVendido asc limit 5
```

![image](https://github.com/user-attachments/assets/51663830-c9e5-41f2-b7aa-6d8307627f4d)

La categoría *Italian* tiene el promedio más alto de ventas con 127 puntos. Sin embargo se ve que, incluso los productos menos vendidos de la categoría sobrepasan esa media con ampli margen, por lo cual se considera que tiene una buena posibilidad de incrementar las ventas con modificaciones que puedan ser más económicas, com las mencionadas para el caso de la categoría *American*. 
```
Select category, count(item_id) as TotalVendido, item_name as total 
from orders where category = 'Asian' group by item_name, category 
order by TotalVendido asc limit 5
```

![image](https://github.com/user-attachments/assets/274c17d2-b573-4164-a2cd-cd018ce8dcc0)

La categoría *Asian* tiene una media de 110 puntos. Sin embargo, como es el caso de las categorías *American* e *Italian*, los productos menos vendidos de la categoría superan por amplio margen la media, por lo cual no se considera que sus productos sean candidatos directos a una modificación directa en el menú. Se hace la misma sugerencia que las categorías mencionadas para la evaluación más exhaustiva de los platillos. 

   

   
