--
-- qualifications
--

--
-- from clauses
--

--
-- retrieve
--

--
-- btree index
-- awk '{if($1<10){print;}else{next;}}' onek.data | sort +0n -1
--
SELECT onek.* WHERE onek.unique1 < 10;

--
-- awk '{if($1<20){print $1,$14;}else{next;}}' onek.data | sort +0nr -1
--
SELECT onek.unique1, onek.stringu1
   WHERE onek.unique1 < 20 
   ORDER BY unique1 using >;

--
-- awk '{if($1>980){print $1,$14;}else{next;}}' onek.data | sort +1d -2
--
SELECT onek.unique1, onek.stringu1
   WHERE onek.unique1 > 980 
   ORDER BY stringu1 using <;
	
--
-- awk '{if($1>980){print $1,$16;}else{next;}}' onek.data |
-- sort +1d -2 +0nr -1
--
SELECT onek.unique1, onek.string4
   WHERE onek.unique1 > 980 
   ORDER BY string4 using <, unique1 using >;
	
--
-- awk '{if($1>980){print $1,$16;}else{next;}}' onek.data |
-- sort +1dr -2 +0n -1
--
SELECT onek.unique1, onek.string4
   WHERE onek.unique1 > 980
   ORDER BY string4 using >, unique1 using <;
	
--
-- awk '{if($1<20){print $1,$16;}else{next;}}' onek.data |
-- sort +0nr -1 +1d -2
--
SELECT onek.unique1, onek.string4
   WHERE onek.unique1 < 20
   ORDER BY unique1 using >, string4 using <;

--
-- awk '{if($1<20){print $1,$16;}else{next;}}' onek.data |
-- sort +0n -1 +1dr -2
--
SELECT onek.unique1, onek.string4
   WHERE onek.unique1 < 20 
   ORDER BY unique1 using <, string4 using >;

--
-- partial btree index
-- awk '{if($1<10){print $0;}else{next;}}' onek.data | sort +0n -1
--
--SELECT onek2.* WHERE onek2.unique1 < 10;

--
-- partial btree index
-- awk '{if($1<20){print $1,$14;}else{next;}}' onek.data | sort +0nr -1
--
--SELECT onek2.unique1, onek2.stringu1
--    WHERE onek2.unique1 < 20 
--    ORDER BY unique1 using >;

--
-- awk '{if($1>980){print $1,$14;}else{next;}}' onek.data | sort +1d -2
--
--SELECT onek2.unique1, onek2.stringu1
--   WHERE onek2.unique1 > 980
--   ORDER BY stringu1 using <;
	
SELECT two, stringu1, ten, string4
   INTO TABLE temp
   FROM onek;

--
-- awk '{print $3;}' onek.data | sort -n | uniq
--
SELECT DISTINCT two FROM temp;

--
-- awk '{print $5;}' onek.data | sort -n | uniq
--
SELECT DISTINCT ten FROM temp;

--
-- awk '{print $16;}' onek.data | sort -d | uniq
--
SELECT DISTINCT string4 FROM temp;

--
-- awk '{print $3,$16,$5;}' onek.data | sort -d | uniq |
-- sort +0n -1 +1d -2 +2n -3
--
SELECT DISTINCT two, string4, ten
   FROM temp
   ORDER BY two using <, string4 using <, ten using <;


--
-- test select distinct on
--
SELECT DISTINCT ON string4 two, string4, ten
	   FROM temp
   ORDER BY two using <, string4 using <, ten using <;


SELECT *
   INTO TABLE temp1
   FROM temp
   WHERE onek.unique1 < 2;

DROP TABLE temp1;

SELECT *
   INTO TABLE temp1
   FROM temp
   WHERE onek2.unique1 < 2;

DROP TABLE temp1;

--
-- awk '{print $1,$2;}' person.data |
-- awk '{if(NF!=2){print $3,$2;}else{print;}}' - emp.data |
-- awk '{if(NF!=2){print $3,$2;}else{print;}}' - student.data |
-- awk 'BEGIN{FS="	";}{if(NF!=2){print $4,$5;}else{print;}}' - stud_emp.data
--
-- SELECT name, age FROM person*; ??? check if different
SELECT p.name, p.age FROM person* p;

--
-- awk '{print $1,$2;}' person.data |
-- awk '{if(NF!=2){print $3,$2;}else{print;}}' - emp.data |
-- awk '{if(NF!=2){print $3,$2;}else{print;}}' - student.data |
-- awk 'BEGIN{FS="	";}{if(NF!=1){print $4,$5;}else{print;}}' - stud_emp.data |
-- sort +1nr -2
--
SELECT p.name, p.age FROM person* p ORDER BY age using >;

--
-- awk '{print $2;}' person.data |
-- awk '{if(NF!=1){print $2;}else{print;}}' - emp.data |
-- awk '{if(NF!=1){print $2;}else{print;}}' - student.data |
-- awk 'BEGIN{FS="	";}{if(NF!=1){print $5;}else{print;}}' - stud_emp.data |
-- sort -n -r | uniq
--
SELECT DISTINCT p.age FROM person* p ORDER BY age using >;

--
-- hash index
-- grep 843938989 hash.data
--
SELECT hash_i4_heap.* 
   WHERE hash_i4_heap.random = 843938989;

--
-- hash index
-- grep 66766766 hash.data
--
SELECT hash_i4_heap.*
   WHERE hash_i4_heap.random = 66766766;

--
-- hash index
-- grep 1505703298 hash.data
--
SELECT hash_c16_heap.*
   WHERE hash_c16_heap.random = '1505703298'::char16;

--
-- hash index
-- grep 7777777 hash.data
--
SELECT hash_c16_heap.*
   WHERE hash_c16_heap.random = '7777777'::char16;

--
-- hash index
-- grep 1351610853 hash.data
--
SELECT hash_txt_heap.*
   WHERE hash_txt_heap.random = '1351610853'::text;

--
-- hash index
-- grep 111111112222222233333333 hash.data
--
SELECT hash_txt_heap.*
   WHERE hash_txt_heap.random = '111111112222222233333333'::text;

--
-- hash index
-- grep 444705537 hash.data
--
SELECT hash_f8_heap.*
   WHERE hash_f8_heap.random = '444705537'::float8;

--
-- hash index
-- grep 88888888 hash.data
--
SELECT hash_f8_heap.*
   WHERE hash_f8_heap.random = '88888888'::float8;

--
-- hash index
-- grep '^90[^0-9]' hashovfl.data
--
-- SELECT count(*) AS i988 FROM hash_ovfl_heap
--    WHERE x = 90;

--
-- hash index
-- grep '^1000[^0-9]' hashovfl.data
--
-- SELECT count(*) AS i0 FROM hash_ovfl_heap
--    WHERE x = 1000;


--
-- btree index
-- test retrieval of min/max keys for each
--

SELECT b.*
   FROM bt_i4_heap b
   WHERE b.seqno < 1;

SELECT b.*
   FROM bt_i4_heap b
   WHERE b.seqno >= 9999;

SELECT b.*
   FROM bt_i4_heap b
   WHERE b.seqno = 4500;

SELECT b.*
   FROM bt_c16_heap b
   WHERE b.seqno < '1'::char16;

SELECT b.*
   FROM bt_c16_heap b
   WHERE b.seqno >= '9999'::char16;

SELECT b.*
   FROM bt_c16_heap b
   WHERE b.seqno = '4500'::char16;

SELECT b.*
   FROM bt_txt_heap b
   WHERE b.seqno < '1'::text;

SELECT b.*
   FROM bt_txt_heap b
   WHERE b.seqno >= '9999'::text;

SELECT b.*
   FROM bt_txt_heap b
   WHERE b.seqno = '4500'::text;

SELECT b.*
   FROM bt_f8_heap b
   WHERE b.seqno < '1'::float8;

SELECT b.*
   FROM bt_f8_heap b
   WHERE b.seqno >= '9999'::float8;

SELECT b.*
   FROM bt_f8_heap b
   WHERE b.seqno = '4500'::float8;



--
-- replace
--
--
-- BTREE
--
UPDATE onek
   SET unique1 = onek.unique1 + 1;

UPDATE onek
   SET unique1 = onek.unique1 - 1;

--
-- BTREE partial
--
-- UPDATE onek2
--   SET unique1 = onek2.unique1 + 1;

--UPDATE onek2 
--   SET unique1 = onek2.unique1 - 1;

--
-- BTREE shutting out non-functional updates
--
-- the following two tests seem to take a long time on some 
-- systems.    This non-func update stuff needs to be examined
-- more closely.  			- jolly (2/22/96)
-- 
UPDATE temp
   SET stringu1 = reverse_c16(onek.stringu1)
   WHERE onek.stringu1 = 'JBAAAA' and
	  onek.stringu1 = temp.stringu1;

UPDATE temp
   SET stringu1 = reverse_c16(onek2.stringu1)
   WHERE onek2.stringu1 = 'JCAAAA' and
	  onek2.stringu1 = temp.stringu1;

DROP TABLE temp;

--UPDATE person*
--   SET age = age + 1;

--UPDATE person*
--   SET age = age + 3
--   WHERE name = 'linda';


--
-- HASH
--
UPDATE hash_i4_heap
   SET random = 1
   WHERE hash_i4_heap.seqno = 1492;

SELECT h.seqno AS i1492, h.random AS i1
   FROM hash_i4_heap h
   WHERE h.random = 1;

UPDATE hash_i4_heap 
   SET seqno = 20000 
   WHERE hash_i4_heap.random = 1492795354;

SELECT h.seqno AS i20000 
   FROM hash_i4_heap h
   WHERE h.random = 1492795354;

UPDATE hash_c16_heap 
   SET random = '0123456789abcdef'::char16
   WHERE hash_c16_heap.seqno = 6543;

SELECT h.seqno AS i6543, h.random AS c0_to_f
   FROM hash_c16_heap h
   WHERE h.random = '0123456789abcdef'::char16;

UPDATE hash_c16_heap
   SET seqno = 20000
   WHERE hash_c16_heap.random = '76652222'::char16;

--
-- this is the row we just replaced; index scan should return zero rows 
--
SELECT h.seqno AS emptyset
   FROM hash_c16_heap h
   WHERE h.random = '76652222'::char16;

UPDATE hash_txt_heap 
   SET random = '0123456789abcdefghijklmnop'::text
   WHERE hash_txt_heap.seqno = 4002;

SELECT h.seqno AS i4002, h.random AS c0_to_p
   FROM hash_txt_heap h
   WHERE h.random = '0123456789abcdefghijklmnop'::text;

UPDATE hash_txt_heap
   SET seqno = 20000
   WHERE hash_txt_heap.random = '959363399'::text;

SELECT h.seqno AS t20000
   FROM hash_txt_heap h
   WHERE h.random = '959363399'::text;

UPDATE hash_f8_heap
   SET random = '-1234.1234'::float8
   WHERE hash_f8_heap.seqno = 8906;

SELECT h.seqno AS i8096, h.random AS f1234_1234 
   FROM hash_f8_heap h
   WHERE h.random = '-1234.1234'::float8;

UPDATE hash_f8_heap 
   SET seqno = 20000
   WHERE hash_f8_heap.random = '488912369'::float8;

SELECT h.seqno AS f20000
   FROM hash_f8_heap h
   WHERE h.random = '488912369'::float8;

-- UPDATE hash_ovfl_heap
--    SET x = 1000
--   WHERE x = 90;

-- this vacuums the index as well
-- VACUUM hash_ovfl_heap;

-- SELECT count(*) AS i0 FROM hash_ovfl_heap
--   WHERE x = 90;

-- SELECT count(*) AS i988 FROM hash_ovfl_heap
--  WHERE x = 1000;

--
-- append
-- 	(is tested in create.source)
--

--
-- queries to plan and execute each plannode and execnode we have
--

--
-- builtin functions
--

--
-- copy
--
COPY onek TO '_OBJWD_/onek.data';

DELETE FROM onek;

COPY onek FROM '_OBJWD_/onek.data';

SELECT unique1 FROM onek WHERE unique1 < 2;

DELETE FROM onek2;

COPY onek2 FROM '_OBJWD_/onek.data';

SELECT unique1 FROM onek2 WHERE unique1 < 2;

COPY BINARY stud_emp TO '_OBJWD_/stud_emp.data';

DELETE FROM stud_emp;

COPY BINARY stud_emp FROM '_OBJWD_/stud_emp.data';

SELECT * FROM stud_emp;

-- COPY aggtest FROM stdin;
-- 56	7.8
-- 100	99.097
-- 0	0.09561
-- 42	324.78
-- .
-- COPY aggtest TO stdout;


--
-- test the random function
--
-- count the number of tuples originally
SELECT count(*) FROM onek;

-- select roughly 1/10 of the tuples
SELECT count(*) FROM onek where oidrand(onek.oid, 10);

-- select again, the count should be different
SELECT count(*) FROM onek where oidrand(onek.oid, 10);


--
-- transaction blocks
--
BEGIN;

SELECT * 
   INTO TABLE xacttest
   FROM aggtest;

INSERT INTO xacttest (a, b) VALUES (777, 777.777);

END;

-- should retrieve one value--
SELECT a FROM xacttest WHERE a > 100;


BEGIN;

CREATE TABLE disappear (a int4);

DELETE FROM aggtest;

-- should be empty
SELECT * FROM aggtest;

ABORT;

-- should not exist 
SELECT oid FROM pg_class WHERE relname = 'disappear';

-- should have members again 
SELECT * FROM aggtest;


--
-- portal manipulation
--
BEGIN;

DECLARE foo1 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo2 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo3 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo4 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo5 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo6 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo7 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo8 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo9 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo10 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo11 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo12 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo13 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo14 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo15 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo16 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo17 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo18 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo19 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo20 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo21 CURSOR FOR SELECT * FROM tenk1;

DECLARE foo22 CURSOR FOR SELECT * FROM tenk2;

DECLARE foo23 CURSOR FOR SELECT * FROM tenk1;

FETCH 1 in foo1;

FETCH 2 in foo2;

FETCH 3 in foo3;

FETCH 4 in foo4;

FETCH 5 in foo5;

FETCH 6 in foo6;

FETCH 7 in foo7;

FETCH 8 in foo8;

FETCH 9 in foo9;

FETCH 10 in foo10;

FETCH 11 in foo11;

FETCH 12 in foo12;

FETCH 13 in foo13;

FETCH 14 in foo14;

FETCH 15 in foo15;

FETCH 16 in foo16;

FETCH 17 in foo17;

FETCH 18 in foo18;

FETCH 19 in foo19;

FETCH 20 in foo20;

FETCH 21 in foo21;

FETCH 22 in foo22;

FETCH 23 in foo23;

FETCH backward 1 in foo23;

FETCH backward 2 in foo22;

FETCH backward 3 in foo21;

FETCH backward 4 in foo20;

FETCH backward 5 in foo19;

FETCH backward 6 in foo18;

FETCH backward 7 in foo17;

FETCH backward 8 in foo16;

FETCH backward 9 in foo15;

FETCH backward 10 in foo14;

FETCH backward 11 in foo13;

FETCH backward 12 in foo12;

FETCH backward 13 in foo11;

FETCH backward 14 in foo10;

FETCH backward 15 in foo9;

FETCH backward 16 in foo8;

FETCH backward 17 in foo7;

FETCH backward 18 in foo6;

FETCH backward 19 in foo5;

FETCH backward 20 in foo4;

FETCH backward 21 in foo3;

FETCH backward 22 in foo2;

FETCH backward 23 in foo1;

CLOSE foo1;

CLOSE foo2;

CLOSE foo3;

CLOSE foo4;

CLOSE foo5;

CLOSE foo6;

CLOSE foo7;

CLOSE foo8;

CLOSE foo9;

CLOSE foo10;

CLOSE foo11;

CLOSE foo12;

end;

EXTEND INDEX onek2_u1_prtl WHERE onek2.unique1 <= 60;

BEGIN;

DECLARE foo13 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 50;

DECLARE foo14 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 51;

DECLARE foo15 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 52;

DECLARE foo16 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 53;

DECLARE foo17 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 54;

DECLARE foo18 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 55;

DECLARE foo19 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 56;

DECLARE foo20 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 57;

DECLARE foo21 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 58;

DECLARE foo22 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 59;

DECLARE foo23 CURSOR FOR 
   SELECT * FROM onek WHERE unique1 = 60;

DECLARE foo24 CURSOR FOR 
   SELECT * FROM onek2 WHERE unique1 = 50;

DECLARE foo25 CURSOR FOR 
   SELECT * FROM onek2 WHERE unique1 = 60;

FETCH all in foo13;

FETCH all in foo14;

FETCH all in foo15;

FETCH all in foo16;

FETCH all in foo17;

FETCH all in foo18;

FETCH all in foo19;

FETCH all in foo20;

FETCH all in foo21;

FETCH all in foo22;

FETCH all in foo23;

FETCH all in foo24;

FETCH all in foo25;

CLOSE foo13;

CLOSE foo14;

CLOSE foo15;

CLOSE foo16;

CLOSE foo17;

CLOSE foo18;

CLOSE foo19;

CLOSE foo20;

CLOSE foo21;

CLOSE foo22;

CLOSE foo23;

CLOSE foo24;

CLOSE foo25;

END;


--
-- PURGE
--
-- we did two updates on each of these 10K tables up above.  we should
-- therefore go from 10002 tuples (two of which are not visible without
-- using a time qual) to 10000.
--
-- vacuuming here also tests whether or not the hash index compaction
-- code works; this used to be commented out because the hash AM would
-- miss deleting a bunch of index tuples, which caused big problems when
-- you dereferenced the tids and found garbage..
--
-- absolute time
PURGE hash_f8_heap BEFORE 'now';

SELECT count(*) AS has_10002 FROM hash_f8_heap[,] h;

VACUUM hash_f8_heap;

SELECT count(*) AS has_10000 FROM hash_f8_heap[,] h;

-- relative time
PURGE hash_i4_heap AFTER '@ 1 second ago';

SELECT count(*) AS has_10002 FROM hash_i4_heap[,] h;

VACUUM hash_i4_heap;

SELECT count(*) AS has_10000 FROM hash_i4_heap[,] h;


--
-- add attribute
--
CREATE TABLE temp (initial int4);

ALTER TABLE temp ADD COLUMN a int4;

ALTER TABLE temp ADD COLUMN b char16;

ALTER TABLE temp ADD COLUMN c text;

ALTER TABLE temp ADD COLUMN d float8;

ALTER TABLE temp ADD COLUMN e float4;

ALTER TABLE temp ADD COLUMN f int2;

ALTER TABLE temp ADD COLUMN g polygon;

ALTER TABLE temp ADD COLUMN h abstime;

ALTER TABLE temp ADD COLUMN i char;

ALTER TABLE temp ADD COLUMN j abstime[];

ALTER TABLE temp ADD COLUMN k dt;

ALTER TABLE temp ADD COLUMN l tid;

ALTER TABLE temp ADD COLUMN m xid;

ALTER TABLE temp ADD COLUMN n oid8;

--ALTER TABLE temp ADD COLUMN o lock;
ALTER TABLE temp ADD COLUMN p smgr;

ALTER TABLE temp ADD COLUMN q point;

ALTER TABLE temp ADD COLUMN r lseg;

ALTER TABLE temp ADD COLUMN s path;

ALTER TABLE temp ADD COLUMN t box;

ALTER TABLE temp ADD COLUMN u tinterval;

ALTER TABLE temp ADD COLUMN v oidint4;

ALTER TABLE temp ADD COLUMN w oidname;

ALTER TABLE temp ADD COLUMN x float8[];

ALTER TABLE temp ADD COLUMN y float4[];

ALTER TABLE temp ADD COLUMN z int2[];

INSERT INTO temp (a, b, c, d, e, f, g, h, i, j, k, l, m, n, p, q, r, s, t, u,
	v, w, x, y, z)
   VALUES (4, 'char16', 'text', 4.1, 4.1, 2, '(4.1,4.1,3.1,3.1)', 
        'Mon May  1 00:30:30 1995', 'c', '{Mon May  1 00:30:30 1995, Monday Aug 24 14:43:07 1992, epoch}', 
	314159, '(1,1)', 512,
	'1 2 3 4 5 6 7 8', 'magnetic disk', '(1.1,1.1)', '(4.1,4.1,3.1,3.1)',
	'(0,2,4.1,4.1,3.1,3.1)', '(4.1,4.1,3.1,3.1)', '["current" "infinity"]',
	'1/3', '1,char16', '{1.0,2.0,3.0,4.0}', '{1.0,2.0,3.0,4.0}', '{1,2,3,4}');

SELECT * FROM temp;

DROP TABLE temp;

-- the wolf bug - schema mods caused inconsistent row descriptors 
CREATE TABLE temp (
	initial 	int4
) ARCHIVE = light;

ALTER TABLE temp ADD COLUMN a int4;

ALTER TABLE temp ADD COLUMN b char16;

ALTER TABLE temp ADD COLUMN c text;

ALTER TABLE temp ADD COLUMN d float8;

ALTER TABLE temp ADD COLUMN e float4;

ALTER TABLE temp ADD COLUMN f int2;

ALTER TABLE temp ADD COLUMN g polygon;

ALTER TABLE temp ADD COLUMN h abstime;

ALTER TABLE temp ADD COLUMN i char;

ALTER TABLE temp ADD COLUMN j abstime[];

ALTER TABLE temp ADD COLUMN k dt;

ALTER TABLE temp ADD COLUMN l tid;

ALTER TABLE temp ADD COLUMN m xid;

ALTER TABLE temp ADD COLUMN n oid8;

--ALTER TABLE temp ADD COLUMN o lock;
ALTER TABLE temp ADD COLUMN p smgr;

ALTER TABLE temp ADD COLUMN q point;

ALTER TABLE temp ADD COLUMN r lseg;

ALTER TABLE temp ADD COLUMN s path;

ALTER TABLE temp ADD COLUMN t box;

ALTER TABLE temp ADD COLUMN u tinterval;

ALTER TABLE temp ADD COLUMN v oidint4;

ALTER TABLE temp ADD COLUMN w oidname;

ALTER TABLE temp ADD COLUMN x float8[];

ALTER TABLE temp ADD COLUMN y float4[];

ALTER TABLE temp ADD COLUMN z int2[];

INSERT INTO temp (a, b, c, d, e, f, g, h, i, j, k, l, m, n, p, q, r, s, t, u,
	v, w, x, y, z)
   VALUES (4, 'char16', 'text', 4.1, 4.1, 2, '(4.1,4.1,3.1,3.1)', 
	'Mon May  1 00:30:30 1995', 'c', '{Mon May  1 00:30:30 1995, Monday Aug 24 14:43:07 1992, epoch}',
	 314159, '(1,1)', 512,
	'1 2 3 4 5 6 7 8', 'magnetic disk', '(1.1,1.1)', '(4.1,4.1,3.1,3.1)',
	'(0,2,4.1,4.1,3.1,3.1)', '(4.1,4.1,3.1,3.1)', '["current" "infinity"]',
	'1/3', '1,char16', '{1.0,2.0,3.0,4.0}', '{1.0,2.0,3.0,4.0}', '{1,2,3,4}');

SELECT * FROM temp[,];

DROP TABLE temp;


--
-- rename -
--   should preserve indices
--
ALTER TABLE tenk1 RENAME TO ten_k;

-- 20 values, sorted 
SELECT unique1 FROM ten_k WHERE unique1 < 20;

-- 20 values, sorted 
SELECT unique2 FROM ten_k WHERE unique2 < 20;

-- 100 values, sorted 
SELECT hundred FROM ten_k WHERE hundred = 50;

ALTER TABLE ten_k RENAME TO tenk1;

-- 5 values, sorted 
SELECT unique1 FROM tenk1 WHERE unique1 < 5;


--
-- VIEW queries
--
-- test the views defined in create.source
--
SELECT * from street;

SELECT * from iexit;

SELECT * from toyemp where name='sharon';




--
-- AGGREGATES
--
SELECT avg(four) AS avg_1 FROM onek;

SELECT avg(a) AS avg_49 FROM aggtest WHERE a < 100;

SELECT avg(b) AS avg_107_943 FROM aggtest;

SELECT avg(gpa) AS avg_3_4 FROM student;


SELECT sum(four) AS sum_1500 FROM onek;

SELECT sum(a) AS sum_198 FROM aggtest;

SELECT sum(b) AS avg_431_773 FROM aggtest;

SELECT sum(gpa) AS avg_6_8 FROM student;


SELECT max(four) AS max_3 FROM onek;

SELECT max(a) AS max_100 FROM aggtest;

SELECT max(aggtest.b) AS max_324_78 FROM aggtest;

SELECT max(student.gpa) AS max_3_7 FROM student;


SELECT count(four) AS cnt_1000 FROM onek;


SELECT newavg(four) AS avg_1 FROM onek;

SELECT newsum(four) AS sum_1500 FROM onek;

SELECT newcnt(four) AS cnt_1000 FROM onek;


--
-- inheritance stress test
--
SELECT * FROM a_star*;

SELECT * 
   FROM b_star* x
   WHERE x.b = 'bumble'::text or x.a < 3;

SELECT class, a 
   FROM c_star* x 
   WHERE x.c ~ 'hi'::text;

SELECT class, b, c
   FROM d_star* x
   WHERE x.a < 100;

SELECT class, c FROM e_star* x WHERE x.c NOTNULL;

SELECT * FROM f_star* x WHERE x.c ISNULL;

ALTER TABLE f_star RENAME COLUMN f TO ff;

ALTER TABLE e_star* RENAME COLUMN e TO ee;

ALTER TABLE d_star* RENAME COLUMN d TO dd;

ALTER TABLE c_star* RENAME COLUMN c TO cc;

ALTER TABLE b_star* RENAME COLUMN b TO bb;

ALTER TABLE a_star* RENAME COLUMN a TO aa;

SELECT class, aa
   FROM a_star* x
   WHERE aa ISNULL;

ALTER TABLE a_star RENAME COLUMN aa TO foo;

SELECT class, foo
   FROM a_star x
   WHERE x.foo >= 2;

ALTER TABLE a_star RENAME COLUMN foo TO aa;

SELECT * 
   from a_star*
   WHERE aa < 1000;

ALTER TABLE f_star ADD COLUMN f int4;

UPDATE f_star SET f = 10;

ALTER TABLE e_star* ADD COLUMN e int4;

--UPDATE e_star* SET e = 42;

SELECT * FROM e_star*;

ALTER TABLE a_star* ADD COLUMN a text;

--UPDATE b_star*
--   SET a = 'gazpacho'::text
--   WHERE aa > 4;

SELECT class, aa, a FROM a_star*;


--
-- versions
--

--
-- postquel functions
--
--
-- mike does post_hacking,
-- joe and sally play basketball, and
-- everyone else does nothing.
--
SELECT p.name, p.hobbies.name FROM person p;

--
-- as above, but jeff also does post_hacking.
--
SELECT p.name, p.hobbies.name FROM person* p;

--
-- the next two queries demonstrate how functions generate bogus duplicates.
-- this is a "feature" ..
--
SELECT DISTINCT hobbies_r.name, hobbies_r.equipment.name FROM hobbies_r;

SELECT hobbies_r.name, hobbies_r.equipment.name FROM hobbies_r;

--
-- mike needs advil and peet's coffee,
-- joe and sally need hightops, and
-- everyone else is fine.
--
SELECT p.name, p.hobbies.name, p.hobbies.equipment.name FROM person p;

--
-- as above, but jeff needs advil and peet's coffee as well.
--
SELECT p.name, p.hobbies.name, p.hobbies.equipment.name FROM person* p;

--
-- just like the last two, but make sure that the target list fixup and
-- unflattening is being done correctly.
--
SELECT p.hobbies.equipment.name, p.name, p.hobbies.name FROM person p;

SELECT p.hobbies.equipment.name, p.name, p.hobbies.name FROM person* p;

SELECT p.hobbies.equipment.name, p.hobbies.name, p.name FROM person p;

SELECT p.hobbies.equipment.name, p.hobbies.name, p.name FROM person* p;

SELECT user_relns() AS user_relns
   ORDER BY user_relns;

--SELECT name(equipment(hobby_construct('skywalking'::text, 'mer'::text))) AS equip_name;


--
-- functional joins
--

--
-- instance rules
--

--
-- rewrite rules
--

--
-- ARRAYS
--
SELECT * FROM arrtest;

SELECT arrtest.a[1],
          arrtest.b[1][1][1],
          arrtest.c[1],
          arrtest.d[1][1], 
          arrtest.e[0]
   FROM arrtest;
-- ??? what about
-- SELECT a[1], b[1][1][1], c[1], d[1][1], e[0]
--    FROM arrtest;

SELECT arrtest.a[1:3],
          arrtest.b[1:1][1:2][1:2],
          arrtest.c[1:2], 
          arrtest.d[1:1][1:2]
   FROM arrtest;

-- returns three different results--
SELECT array_dims(arrtest.b) AS x;

-- returns nothing 
SELECT *
   FROM arrtest
   WHERE arrtest.a[1] < 5 and 
         arrtest.c = '{"foobar"}'::_char16;

-- updating array subranges seems to be broken
-- 
-- UPDATE arrtest
--   SET a[1:2] = '{16,25}',
--       b[1:1][1:1][1:2] = '{113, 117}', 
--       c[1:1] = '{"new_word"}';

SELECT arrtest.a[1:3],
          arrtest.b[1:1][1:2][1:2],
          arrtest.c[1:2], 
          arrtest.d[1:1][1:2]
   FROM arrtest;


--
-- expensive functions
--


