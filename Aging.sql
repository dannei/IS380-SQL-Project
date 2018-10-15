set echo off
set heading on
set feedback off
set verify off
spool e:aging.txt
prompt  ****** PURCHASE ORDER Aging Report ******

select 'Today''s Date: ', sysdate from dual;

accept vDays prompt 'Please enter the number of days to query: ';

column OrderAmount heading "OrderAmount" format 999.99
column UnitPrice heading "UnitPrice" format 999.99
column DaysOpen heading "DaysOpen" format 999 

select POID, Status, to_char(PODate, 'mm/dd/yyyy') DateOpen, Products.PID, PDesc, OrderQty, UnitPrice, OrderAmount, Suppliers.SID, SName, ShipDate-PODate DaysOpen
	from Suppliers, Products, PurchaseOrders
	where PurchaseOrders.PID=Products.PID and PurchaseOrders.SID=Suppliers.SID and ShipDate-PODate>=&vDays
	order by DaysOpen desc;
spool off