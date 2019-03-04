--1
SELECT COUNT(id)
FROM stops
--2
SELECT id
FROM stops
WHERE name = 'Craiglockhart'
--3
SELECT stops.id, stops.name 
FROM stops
JOIN route ON route.stop = stops.id
WHERE route.num = 4 AND route.company = 'LRT'
--4
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(company) = 2
--5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149
--6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road'
--7
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE a.stop = 115 AND b.stop = 137
GROUP BY a.company, a.num
--8
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross'
GROUP BY a.company, a.num
--9
SELECT DISTINCT stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
--10
   SELECT start.num, start.company, start.name, end.num, end.company
     FROM (SELECT DISTINCT a.num, a.company,stopb.name 
            FROM route a 
             JOIN route b ON (a.company=b.company AND a.num=b.num)
              JOIN stops stopa ON (a.stop=stopa.id)
               JOIN stops stopb ON (b.stop=stopb.id)
                WHERE stopa.name='Craiglockhart') AS start 
      JOIN (SELECT DISTINCT stopa.name, a.num, a.company 
             FROM route a 
              JOIN route b ON (a.company=b.company AND a.num=b.num)
               JOIN stops stopa ON (a.stop=stopa.id)
                JOIN stops stopb ON (b.stop=stopb.id)
                 WHERE stopb.name='Lochend') AS end
      ON end.name = start.name
       ORDER BY start.num, end.num 