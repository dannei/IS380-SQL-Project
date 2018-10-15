/* Recieve.SQL */
set echo off 
set heading off
set feedback off
set verify off
spool e:RecievePO.txt
prompt ****** R E C I E V E  O R D E R ******
prompt 
select 'Today''s Date: ', sysdate from dual;
accept vPOID prompt 'Please enter the Purchase Order Number: ';
select 'Purchase Order Number: ', POID from PurchaseOrders where POID='&vPOID';
select 'Item Number: ', PID from PurchaseOrders where POID='&vPOID';
select 'Item Description: ', PDesc from Products,PurchaseOrders where Products.PID=PurchaseOrders.PID and POID='&vPOID';
select 'Supplier Number: ', SID from PurchaseOrders where POID='&vPOID';
select 'Supplier Name: ', SName from Suppliers,PurchaseOrders where Suppliers.SID=PurchaseOrders.SID and POID='&vPOID';
select 'Date Ordered: ', to_char(PODate, 'dd-MON-yyyy') from PurchaseOrders where POID='&vPOID';
select 'Today''s Date: ', to_char(sysdate,'dd-MON-yyyy') from dual;
select 'Quantity Ordered: ', OrderQty from PurchaseOrders where POID='&vPOID';
column UnitPrice heading "UnitPrice" format $9,999.99
column OrderAmount heading "OrderAmount" format $9,999.99
select 'Unit Price: ', UnitPrice from PurchaseOrders where POID='&vPOID';
select 'Amount Ordered: ', OrderAmount from PurchaseOrders where POID='&vPOID';
prompt
accept vShipQty prompt 'Enter quantity recieved:';
column a heading "Amount Due" format $9,999.99
select 'Amount Due:', '&vShipQty'*UnitPrice a from PurchaseOrders where POID='&vPOID';
select 'Inventory Level:', -('&vShipQty')+Inventory from Products,PurchaseOrders where Products.PID=PurchaseOrders.PID and POID='&vPOID';
update PurchaseOrders set ShipDate=sysdate where POID='&vPOID';
update PurchaseOrders set ShipQty='&vShipQty' where POID='&vPOID';
column ShipAmount heading "ShipAmount" format $999.99
update PurchaseOrders set ShipAmount='&vShipQty'*UnitPrice where POID='&vPOID';
update PurchaseOrders set Status='C' where POID='&vPOID';
update Products set Inventory=Inventory-(select ShipQty from PurchaseOrders where POID='&vPOID') where PID=(SELECT PID from PurchaseOrders where POID='&vPOID');
prompt ********************************
select 'Order is now --->' ,Status from PurchaseOrders where POID='&vPOID';
select 'Date Closed: ', to_char(ShipDate, 'dd-MON-yyyy') from PurchaseOrders where POID='&vPOID';
commit;
spool off