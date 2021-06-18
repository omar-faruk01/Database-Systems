--DDL
create table CUSTOMER
(
    CustomerID number(6) CONSTRAINT customer_pk primary key,
    CustomerName varchar2(20),
    City varchar2(20),
    State char(2),
    PostalCode char(5),
    PhoneNumber char(10),
    Birthday DATE,
    RegistrationDate date
);

create table ORDER_RECORD
(
    OrderID number(10) CONSTRAINT order_record_pk PRIMARY KEY,
    OrderDate date,
    PaymentMethod char(2) CONSTRAINT order_record_chq1 check (PaymentMethod in ('CS','CC','PP')),
    OrderType char(1) CONSTRAINT order_record_chq2 check (OrderType in ('P', 'D')),
    CustomerID number(10) CONSTRAINT order_record_fk references CUSTOMER(CustomerID)

);

create table DIGITAL_ORDER
(
    DOrderID number(10) CONSTRAINT digital_order_pk Primary KEY,
    SubscriptionOption char(1) check (SubscriptionOption in ('M','Y')),
    CONSTRAINT digital_order_fk foreign key (DOrderID) REFERENCES ORDER_RECORD (OrderID)
);

create table PHYSICAL_ORDER
(
    POrderID number(10) CONSTRAINT physical_order_pk Primary KEY,
    DeliveryOption char(1) check (DeliveryOption in ('F','S', 'E')),
    CONSTRAINT physical_order_fk foreign key (POrderID) REFERENCES ORDER_RECORD (OrderID)
);

create table SONG
(
    SongID number(10) CONSTRAINT song_pk primary key,
    SongTitle varchar2(50),
    PlayTime number(3)
);

create table ALBUM
(
    AlbumID number(10) CONSTRAINT album_pk primary key,
    AlbumTitle varchar2(50),
    AlbumPrice Number(3),
    ReleaseDate Date
);

create table GENRE
(
    GenreID number(4) CONSTRAINT genre_pk primary key,
    GenreName varchar2(20)
);

create table ARTIST
(
    ArtistID number(10) CONSTRAINT artist_pk primary key,
    ArtistName varchar2(20),
    DebutDate date
);

create table PLAY_HISTORY
(
    DOrderID number(10),
    SongID number(10),
    PlayDate date,
    PlayCount number(3),
    CONSTRAINT PLAY_HISTORY_pk Primary KEY(DOrderID,SongID),
    CONSTRAINT PLAY_HISTORY_fk1 foreign key (DOrderID) REFERENCES DIGITAL_ORDER (DOrderID),
    CONSTRAINT PLAY_HISTORY_fk2 foreign key (SongID) REFERENCES SONG (SongID)
);

create table ORDER_LINE
(
    POrderID number(10), 
    AlbumID number(10),
    QuantitiesOrdered number(3),
    CONSTRAINT ORDER_LINE_pk Primary key (POrderID, AlbumID),
    CONSTRAINT ORDER_LINE_fk1 foreign key (POrderID) REFERENCES PHYSICAL_ORDER (POrderID),
    CONSTRAINT ORDER_LINE_fk2 foreign key (AlbumID) REFERENCES ALBUM (AlbumID)

);

create table CONTAINS
(
    SongID number(10),
    AlbumID number(10),
    CONSTRAINT contains_pk Primary KEY(SongID, AlbumID),
    CONSTRAINT contains_fk1 foreign key (SongID) REFERENCES SONG (SongID),
    CONSTRAINT contains_fk2 foreign key (AlbumID) REFERENCES ALBUM (AlbumID)
);

create table WRITES
(
    SongID number(10),
    AlbumID number(10),
    CONSTRAINT writes_pk Primary KEY(SongID, AlbumID),
    CONSTRAINT writes_fk1 foreign key (SongID) REFERENCES SONG (SongID),
    CONSTRAINT writes_fk2 foreign key (AlbumID) REFERENCES ALBUM (AlbumID)
);

create table BELONGSTO
(
    SongID number(10),
    AlbumID number(10),
    CONSTRAINT BELONGSTO_pk Primary KEY(SongID, AlbumID),
    CONSTRAINT BELONGSTO_fk1 foreign key (SongID) REFERENCES SONG (SongID),
    CONSTRAINT BELONGSTO_fk2 foreign key (AlbumID) REFERENCES ALBUM (AlbumID)
);


-- DML

-- 5 customers
DESC customer;

insert into customer
values (1, 'Omar Faruk', 'Madison Heights', 'MI', '48071', '3131234567',to_date('01-03-1990', 'MM-DD-YYYY'), sysdate-5);

insert into customer
values (2, 'John Doe', 'Manhattan', 'NY', '23490', '3131234567',to_date('02-03-1995', 'MM-DD-YYYY'), sysdate-3);

insert into customer
values (3, 'Abe Lincoln', 'Akron', 'OH', '78567', '3131234567',to_date('11-13-1999', 'MM-DD-YYYY'), sysdate-2);

insert into customer
values (4, 'Frank Lampard', 'Warren', 'MI', '46041', '3131234567',to_date('09-01-1990', 'MM-DD-YYYY'), sysdate-10);

insert into customer
values (5, 'Christian Pulisic ', 'Detroit', 'MI', '48066', '3131234567',to_date('04-15-1993', 'MM-DD-YYYY'), sysdate-20);

select * from customer;

-- 10 orders
DESC ORDER_RECORD;

insert into ORDER_RECORD
values (1,sysdate-4, 'CS','P', 1);

insert into ORDER_RECORD
values (2,sysdate-3, 'CC','P', 1);

insert into ORDER_RECORD
values (3,sysdate-2, 'PP','D', 2);

insert into ORDER_RECORD
values (4,sysdate-4, 'CS','D', 3);

insert into ORDER_RECORD
values (5,sysdate-3, 'CC','P', 3);

insert into ORDER_RECORD
values (6,sysdate-2, 'PP','D', 3);

insert into ORDER_RECORD
values (7,sysdate-4, 'CS','P', 4);

insert into ORDER_RECORD
values (8,sysdate-3, 'CC','P', 4);

insert into ORDER_RECORD
values (9,sysdate-2, 'PP','D', 5);

insert into ORDER_RECORD
values (10,sysdate-4, 'CS','P', 5);

select * from order_record;

-- 20 songs
insert into song
values (1, '4 Da Gangg', 4);

insert into song
values (2, 'Rain Down On me', 5);

insert into song
values (3, 'Love', 2);

insert into song
values (4, 'Noya Daman', 3);

insert into song
values (5, 'Daman', 3);

insert into song
values (6, 'Noya', 3);

insert into song
values (7, 'Rain', 4);

insert into song
values (8, 'Down', 6);

insert into song
values (9, 'On me', 3);

insert into song
values (10, 'me', 5);

insert into song
values (11, 'Live Happily After', 2);

insert into song
values (12, 'Happily', 2);

insert into song
values (13, 'Live Happily', 8);

insert into song
values (14, 'Live After', 2);

insert into song
values (15, 'Happily After', 1);

insert into song
values (15, 'I Want Pizza', 6);

insert into song
values (16, 'I Want ', 6);

insert into song
values (17, 'Want Pizza', 4);

insert into song
values (18, 'I Pizza', 6);

insert into song
values (19, 'Hello Its Me', 6);

insert into song
values (20, 'Its Me', 3);

select * from song;


-- 3 albums

desc album;

insert into album
values (1, 'Love', 5, sysdate-10);

insert into album
values (2, 'Culture', 7, sysdate-5);

insert into album
values (3, 'Bodak', 8, sysdate-2);

select * from album;