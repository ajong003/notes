/* List the title of every book where all authors of the book has written
   at least four books.
   i.e. List the title of every book where each author of the book
        has written at least four books.

   This can be rephrased as
    " List the title of every book where the book has at least one author
        and no author of the book has written less than four books"

Output:
    Title
 East of Eden                            
 Of Mice and Men                         
 The Grapes of Wrath                     
 Travels with Charley                    

*/

SELECT b.title
FROM book b, wrote w1
WHERE (b.bookCode = w1.bookCode)
  AND (b.bookcode NOT IN
         (SELECT distinct bookCode -- book codes with authors having written < 4 books
          FROM wrote w2
          WHERE authorNum IN
              (SELECT authorNum -- authors with less than 4 books written
               FROM wrote w3
               GROUP BY authorNum
               HAVING count(*) < 4)
          )
        )
GROUP BY b.title
HAVING (count(*) > 0)
        
--======================================================================
/*  List the branch names that has all the books published by publisher 'LB'

    This can be rephrased as
      List the name of the branch 
             -- condition1
              that holds at least one book from the publisher 'LB'
        and 
	     -- condition2
              there is no book published by publisher 'LB'
                  that is not available in that branch.

Output:
    BranchName
 Henry On The Hill

*/


SELECT branchName
FROM branch b
WHERE
  -- condition1
   branchNum IN
     (SELECT  i.branchNum
      FROM inventory i, book b2, publisher p
      WHERE i.bookCode = b2.bookCode
        AND b2.publisherCode = p.publisherCode
        AND p.publisherCode = 'LB')

AND
   -- condition2
     NOT EXISTS
        (SELECT *
         FROM book
         WHERE publisherCode IN
            (SELECT publisherCode
             FROM publisher
             WHERE publisherCode = 'LB')
           AND 
             bookCode NOT IN
               (SELECT bookCode
                FROM inventory i2
                WHERE i2.branchNum = b.branchNum)) -- note the reference b
                                                   -- refers to the outer query

--======================================================================
