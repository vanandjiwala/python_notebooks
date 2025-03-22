-- Databricks notebook source
SHOW DATABASES;

-- COMMAND ----------

USE default;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Creating table and inserting data

-- COMMAND ----------

-- MAGIC %md
-- MAGIC If you are running it for 2nd time, the location may be present which may prevent you from creating the table so the below command is to ensure that the location associated with the table is removed. 

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # dbutils.fs.rm('dbfs:/user/hive/warehouse/point_of_sale/', recurse=True)

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS point_of_sale (
  sale_id INT,
  product STRING,
  quantity INT,
  price DECIMAL(10,2),
  sale_date DATE
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Default is 100

-- COMMAND ----------

ALTER TABLE point_of_sale SET TBLPROPERTIES ('delta.checkpointInterval' = '5');

-- COMMAND ----------

INSERT INTO point_of_sale VALUES 
  (1, 'Apple', 10, 1.50, '2025-03-15'),
  (2, 'Banana', 5, 0.75, '2025-03-15'),
  (3, 'Orange', 20, 0.90, '2025-03-16'),
  (4, 'Milk', 2, 2.50, '2025-03-17'),
  (5, 'Bread', 3, 1.80, '2025-03-17');

-- COMMAND ----------

SELECT * FROM point_of_sale;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Diffence between describe and describe detail

-- COMMAND ----------

DESCRIBE point_of_sale;

-- COMMAND ----------

DESCRIBE DETAIL point_of_sale;

-- COMMAND ----------

-- MAGIC %python
-- MAGIC spark.createDataFrame(dbutils.fs.ls("dbfs:/user/hive/warehouse/point_of_sale/")).show()

-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls("dbfs:/user/hive/warehouse/point_of_sale/"))

-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls("dbfs:/user/hive/warehouse/point_of_sale/_delta_log/"))

-- COMMAND ----------

DESCRIBE HISTORY point_of_sale;

-- COMMAND ----------

INSERT INTO point_of_sale VALUES 
(6, 'Eggs', 12, 0.20, '2025-03-18'),
(7, 'Cheese', 1, 4.50, '2025-03-18'),
(8, 'Tomato', 15, 0.30, '2025-03-19'),
(9, 'Potato', 20, 0.15, '2025-03-19'),
(10, 'Chicken', 2, 7.00, '2025-03-20');

-- COMMAND ----------

DESCRIBE HISTORY point_of_sale;

-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls("dbfs:/user/hive/warehouse/point_of_sale/"))

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Update

-- COMMAND ----------

UPDATE point_of_sale
SET quantity = 25,
    price = 1.00
WHERE sale_id = 3;

-- COMMAND ----------

DESCRIBE HISTORY point_of_sale;

-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls("dbfs:/user/hive/warehouse/point_of_sale/"))

-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls("dbfs:/user/hive/warehouse/point_of_sale/_delta_log/"))

-- COMMAND ----------

INSERT INTO point_of_sale VALUES 
  (11, 'Yogurt', 8, 0.99, '2025-03-21'),
  (12, 'Butter', 4, 2.30, '2025-03-21'),
  (13, 'Cereal', 3, 3.50, '2025-03-22'),
  (14, 'Juice', 6, 1.80, '2025-03-22'),
  (15, 'Coffee', 2, 5.00, '2025-03-22');


-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls('dbfs:/user/hive/warehouse/point_of_sale/'))

-- COMMAND ----------

INSERT INTO point_of_sale VALUES 
  (16, 'Tea', 3, 2.00, '2025-03-23'),
  (17, 'Sugar', 10, 0.40, '2025-03-23'),
  (18, 'Flour', 5, 1.20, '2025-03-24'),
  (19, 'Salt', 7, 0.25, '2025-03-24'),
  (20, 'Pepper', 4, 0.75, '2025-03-24');

-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls('dbfs:/user/hive/warehouse/point_of_sale/'))

-- COMMAND ----------

DESCRIBE HISTORY point_of_sale;

-- COMMAND ----------

DELETE FROM point_of_sale
WHERE sale_id = 15;

-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls('dbfs:/user/hive/warehouse/point_of_sale/'))

-- COMMAND ----------

DESCRIBE HISTORY point_of_sale;

-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls("dbfs:/user/hive/warehouse/point_of_sale/_delta_log/"))

-- COMMAND ----------

INSERT INTO point_of_sale VALUES 
  (21, 'Soda', 6, 1.20, '2025-03-25'),
  (22, 'Chips', 3, 2.50, '2025-03-25'),
  (23, 'Candy', 10, 0.50, '2025-03-25');


INSERT INTO point_of_sale VALUES 
  (24, 'Sandwich', 2, 4.00, '2025-03-26'),
  (25, 'Salad', 1, 3.50, '2025-03-26');

INSERT INTO point_of_sale VALUES 
  (26, 'Soup', 4, 3.00, '2025-03-27'),
  (27, 'Breadsticks', 5, 1.00, '2025-03-27'),
  (28, 'Pasta', 2, 5.50, '2025-03-27'),
  (29, 'Water', 8, 0.90, '2025-03-27');

INSERT INTO point_of_sale VALUES 
  (30, 'Steak', 1, 15.00, '2025-03-28'),
  (31, 'Fish', 2, 12.00, '2025-03-28'),
  (32, 'Rice', 3, 2.20, '2025-03-28'),
  (33, 'Beans', 4, 1.80, '2025-03-28'),
  (34, 'Salsa', 2, 3.00, '2025-03-28');

INSERT INTO point_of_sale VALUES 
  (35, 'Burger', 1, 6.50, '2025-03-29'),
  (36, 'Fries', 2, 2.50, '2025-03-29'),
  (37, 'Shake', 1, 3.50, '2025-03-29');

-- COMMAND ----------

-- MAGIC %python
-- MAGIC display(dbutils.fs.ls("dbfs:/user/hive/warehouse/point_of_sale/_delta_log/"))
