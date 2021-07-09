select books.RETAIL, category from books where CATEGORY = 'COMPUTER';

select books.RETAIL 
from books
where books.RETAIL =
     (select min(books.RETAIL) from books where books.CATEGORY = 'COMPUTER')
or books.RETAIL =
     (select max(books.RETAIL) from books where books.CATEGORY = 'COMPUTER');



SELECT Category, min(Retail), max(Retail)
FROM Books
GROUP BY Category;

SELECT Category, min(Retail), max(Retail)
FROM Books
GROUP BY Category
HAVING min(Retail) > 10;

select max(retail)
from BOOKS join BOOKAUTHOR using(isbn)
join author using(AUTHORID)
where author.lname = 'WHITE'
and author.fname = 'LISA';

SELECT name, category, AVG(retail), stddev(retail)
FROM books JOIN publisher USING(pubid)
WHERE category IN('COMPUTER', 'CHILDREN')
GROUP BY name, category;