USE Finalproject;


SELECT * 
FROM amazon

ALTER TABLE amazon
ADD Store TEXT "Amazon";

ALTER TABLE amazon
DROP COLUMN Store;

SELECT *
FROM facebook

SELECT Date,
	  (CASE WHEN High = (SELECT MAX(High) FROM amazon) THEN High END) AS Amazon
FROM amazon




-- Q1

WITH highinfo AS 
(
SELECT 
	  'AMZN' id,
	  Date,
	  High
FROM amazon
WHERE High = (SELECT MAX(High) FROM amazon)
UNION
SELECT 
	  'FB' id,
	  Date,
	  High
FROM facebook
WHERE High = (SELECT MAX(High) FROM facebook)
),
lowinfo AS
(
SELECT 
	  'AMZN' id,
	  Date,
	  Low
FROM amazon
WHERE Low = (SELECT MIN(Low) FROM amazon)
UNION
SELECT 
	  'FB' id,
	  Date,
	  Low
FROM facebook
WHERE Low = (SELECT MIN(Low) FROM facebook)
)
SELECT h.id, CAST(h.Date as DATE) AS Date, CAST(h.High as decimal(10,2)) AS High, CAST(l.Date AS DATE) AS Date, CAST(l.Low as decimal(10,2)) AS Low
FROM highinfo h
JOIN lowinfo l ON h.id = l.id


-- Q2


SELECT 
	  'AMZN' ID,
	  SUM(Volume) AS 'Total Volume (2015)'
FROM amazon
WHERE YEAR(Date) = 2015
UNION
SELECT 
	  'FB' ID,
	  SUM(Volume) AS 'Total Volume (2015)'
from facebook
WHERE YEAR(Date) = 2015



-- Q3
SELECT 
	  DATENAME(dw, a.Date) AS DOW, 
	  FORMAT(MAX(a.Volume), '0,,,.00B') AS 'AMZN Volume (Billions)',
	  FORMAT(MAX(f.Volume), '0,,,.00B') AS 'FB Volume (Billions)'
FROM amazon a 
JOIN facebook f ON a.Date = f.Date
WHERE YEAR(a.Date) BETWEEN 2012 AND 2015
GROUP BY DATENAME(dw, a.Date)





/*
(5 Marks) For the data provided for both stocks AMZN and FB provide an analysis that includes as a
minimum the elements below.
- Introduction: Write an introductory paragraph that describes the nature of the data provided, and
any relevant exploratory comment about the data (1-2 paragraphs)
- Body of the analysis: Provide any SQL query, tables, graphs etc. (Analysis and exploration must be
different from the requested in Part 1, further analysis must be provided)
- Conclusion: Deliver analytical insights (not only descriptive comments) that you found while
analyzing the data (1-2 paragraphs)
*/


SELECT * 
FROM amazon


SELECT *
FROM facebook



/* AMAZON Range average by day of the week*/
SELECT 
	   DATENAME(dw, Date) AS DOW,
	   AVG(High - Low) AS 'AmazonRange'
FROM amazon
GROUP BY DATENAME(dw, Date) 

/* Amazon Range average by day of the month*/
SELECT 
	   DAY(Date) AS DOM,
	   AVG(High - Low) AS 'AmazonRange'
FROM amazon
GROUP BY DAY(Date)
ORDER BY DAY(Date)


/* FB Range average by day of the week*/
SELECT 
	   DATENAME(dw, Date) AS DOW,
	   AVG(High - Low) AS 'FBRange'
FROM facebook
GROUP BY DATENAME(dw, Date) 


/* FB Range average by day of the month*/
SELECT 
	   DAY(Date) AS DOM,
	   AVG(High - Low) AS 'FBRange'
FROM facebook
GROUP BY DAY(Date)
ORDER BY DAY(Date)








