/* QueryPO */
set echo off
set feedback off
set heading off
spool e:QueryPO.txt
prompt ****** Q U E R Y   O R D E R ****** 
accept vPOID prompt 'Please enter the Purchase Order Number: ';
select 'Purchase Order Number: ', POID from PurchaseOrders where POID='&vPOID';
select 'Item Number: ', PID from PurchaseOrders where POID='&vPOID';
select 'Item Description: ', PDesc from Products,PurchaseOrders where Products.PID=PurchaseOrders.PID and POID='&vPOID';
select 'Current Inventory Level: ', Inventory from Products,PurchaseOrders where Products.PID=PurchaseOrders.PID and POID='&vPOID';
select 'Supplier Number: ', SID from PurchaseOrders where POID='&vPOID';
select 'Supplier Name: ', SName from Suppliers,PurchaseOrders where Suppliers.SID=PurchaseOrders.SID and POID='&vPOID';
prompt
select 'Date Ordered: ', to_char(PODate, 'dd-MON-yyyy') from PurchaseOrders where POID='&vPOID';
select 'Quantity Ordered: ', OrderQTY from PurchaseOrders where POID='&vPOID';
select 'Date Recieved: ', to_char(ShipDate, 'dd-MON-yyyy') from PurchaseOrders where POID='&vPOID';
select 'Quantity Recieved: ', ShipQty from PurchaseOrders where POID='&vPOID';
select 'Unit Price: ', UnitPrice from PurchaseOrders where POID='&vPOID';
select 'Amount Ordered: ', OrderAmount from PurchaseOrders where POID='&vPOID';
column x heading "Amount Due" format $9,999.99
select 'Amount Due: ', OrderAmount-(ShipQty*UnitPrice) x from PurchaseOrders where POID='&vPOID';
prompt
select 'Order Status:', Status from PurchaseOrders where POID='&vPOID';
spool off




