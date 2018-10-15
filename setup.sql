set echo on;
set heading on;
spool e:setup.txt
/* Drop Tables */

drop table price;

drop table purchaseorders;

drop table suppliers;

drop table products;

drop sequence p_counter;

/* Create Tables */

create table Products (PID varchar2(5), PDesc varchar2(15), Inventory number(5), primary key(PID));
create table Suppliers (SID varchar2(5), SName varchar2(15), Address varchar2(20),City varchar2(15), State varchar2(15), Zip number(6), Phone varchar2(20), primary key(SID));
create table PurchaseOrders (POID number(4), PODate date, PID varchar2(5),SID varchar2(5), UnitPrice number(6,2),OrderQTY number(6), OrderAmount number(12,2), ShipDate date,ShipQty number(6), ShipAmount number(12,2), Status varchar2(6), primary key (POID), constraint fk_3 foreign key (PID) references Products(PID),constraint fk_4 foreign key (SID) references Suppliers(SID));
create table Price (PID varchar2(5),SID varchar2(5), UnitPrice number(6,2), primary key(PID,SID), constraint fk_1 foreign key (PID) references Products(PID),constraint fk_2 foreign key (SID) references Suppliers(SID));

/* Insert records into Product table */

insert into Products values ('p1', 'Pencil', '1000');
insert into Products values ('p2', 'Pen', '1000');
insert into Products values ('p3', 'Eraser', '2000');
insert into Products values ('p4', 'Folder', '6000');
insert into Products values ('p5', 'Printer', '8000');

/* Insert records into Suppliers table */

insert into Suppliers values ('s1','Staples','123 Rainbow Street','New York City', 'New York','99999','(117)123-1654');
insert into Suppliers values ('s2', 'Office Depot','123 Little Ave','Long Beach', 'California','88888', '(122)123-1654');
insert into Suppliers values ('s3', 'Target','125 Big Street','Los Angeles','California','77777', '(118)123-1654');
insert into Suppliers values ('s4', 'Costco','111 Fly Blvd', 'Phoenix','Arizona','66666', '(546)123-1654');
insert into Suppliers values ('s5', 'Best Buy','333 King Street', 'Honolulu','Hawaii', '55555','(117)222-1654');

/* Insert recorts into Price Table */

insert into Price values ('p1', 's1', '1.00');
insert into Price values ('p2', 's2', '2.00');
insert into Price values ('p3', 's3', '0.50');
insert into Price values ('p4', 's4', '3.00');
insert into Price values ('p5', 's5', '50.00');

/* Insert records into Orders table */

insert into PurchaseOrders values ('1001','25-August-18','p1', 's1', '1.00', '50','50.00','26-August-18','50','50.00','C');
insert into PurchaseOrders values ('1002','26-August-18','p2', 's2', '2.00', '100','200.00','30-September-18','100','200.00','C');
insert into PurchaseOrders values ('1003','26-August-18','p3', 's3', '0.50', '100','200.00','30-August-18','100','200.00','C');
insert into PurchaseOrders values ('1004','27-August-18','p4', 's4', '3.00', '50','150.00','29-August-18','50','150.00','C');
insert into PurchaseOrders values ('1005','28-August-18','p5', 's5', '50.00', '10','500.00','30-August-18','10','500.00','C');

create sequence P_Counter start with 1006;

commit;
spool off


