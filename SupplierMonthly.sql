/* SupplierMonthly */

set echo off
set heading on
set feedback off
set verify off
spool e:suppliermonthly.txt
prompt ****** SUPPLIER MONTHLY REPORT ******
column TotalAmount heading "TotalAmount" format $9,999.99
select Suppliers.SID, SName, to_char(PODate, 'mm/yyyy') OrderMonth, count(*) TotalOrders, sum(OrderQty) TotalUnits, sum(OrderAmount) TotalAmount
	from Suppliers, PurchaseOrders
	where Suppliers.SID=PurchaseOrders.SID
	group by Suppliers.SID, SName, to_char(PODate, 'mm/yyyy')
	order by Suppliers.SID, SName, OrderMonth;
spool off