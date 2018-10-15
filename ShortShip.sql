set echo off
set heading on
set verify off

/* ShortShip.sql */
spool e:shortship.txt
prompt ****** SHORT SHIP REPORT ******
prompt
select 'Today''s Date: ', sysdate from dual;

column sq heading 'ShortQty' format '999,999' 
column ShipQty heading 'RecieveQty'
select POID, Status, to_char(PODate, 'mm/dd/yyyy') DateOpen, Products.PID, PDesc, OrderQty, ShipQty, OrderQty-ShipQty sq, Suppliers.SID, SName
	from Suppliers, Products, PurchaseOrders
	where PurchaseOrders.PID=Products.PID and PurchaseOrders.SID=Suppliers.SID and OrderQty!=ShipQty
	order by POID;
spool off