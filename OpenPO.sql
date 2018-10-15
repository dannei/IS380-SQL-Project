set feedback on;
set echo off;
set verify off;
set heading on;
spool e:OpenPO.txt
prompt  ****** OPEN ORDER ******
prompt
select 'Today''s Date: ', sysdate from dual;
prompt
accept vPID prompt 'Enter the Item Number: ';
select 'Item Description: ', PDesc from Products where PID='&vPID';
select 'Current Inventory Level: ', Inventory from Products where PID='&vPID';
prompt
prompt Please select from one of the following Authorized Suppliers: 
select Suppliers.SID,Suppliers.SName,Suppliers.City,Suppliers.State,Price.UnitPrice 
	from Suppliers,Price,Products where Suppliers.SID=Price.SID and Products.PID='&vPID' and Products.PID=Price.PID;
column UnitPrice heading "UnitPrice" format $9,999.99
column OrderAmount heading "OrderAmount" format $9,999.99
prompt
accept vSID prompt 'Enter the Supplier Name: ';
select 'Supplier Name: ', SName from Suppliers where SID='&vSID';
select 'Address: ', Address from Suppliers where SID='&vSID';
select 'City and State: ', City||','||State from Suppliers where SID='&vSID';
select 'Phone: ', Phone from Suppliers where SID='&vSID';
prompt
accept vOrderQty prompt 'Enter Order Quantity: ';
select 'Unit Price: ', UnitPrice from Price where SID='&vSID';
select 'Amount Ordered: ', '&vOrderQty'*UnitPrice OrderAmount from Price where SID='&vSID';
prompt
insert into PurchaseOrders (
	POID,
	PODate,
	PID,
	SID,
	UnitPrice,
	OrderQty,
	OrderAmount,
	Status)
values (P_Counter.nextval,
	sysdate,
	'&vPID',
	'&vSID',
	(select UnitPrice from Price where SID='&vSID'),
	'&vOrderQty',
	(select '&vOrderQty'*UnitPrice from Price where SID='&vSID'),
	'O');	
prompt ***** Order Status: Open
select '***** Purchase Order Number is -----> ', P_Counter.currval from dual;
commit;
spool off
