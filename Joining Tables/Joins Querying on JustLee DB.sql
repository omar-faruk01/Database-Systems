SELECT book.title, auth.lname, auth.fname
FROM bookauthor ba,
books book,
author auth
where auth.authorid = ba.authorid
and ba.isbn = book.isbn;


select books.TITLE, publisher.name, publisher.phone
from books join PUBLISHER
using (pubid);


select (NVL(to_char(orders.shipdate) ,'Not Shipped')) as "Shipment Status",
customers.lastname, customers.firstname
from orders join customers
using (customer#)
where orders.shipdate is NULL
order by orders.shipdate;


select books.title, promotion.gift
from books join PROMOTION
on books.retail between PROMOTION.MINRETAIL and PROMOTION.MAXRETAIL
where books.title = 'SHORTEST POEMS';