--Cal Tz
-- check on two IDS : 20377121-7
-- the algorithm is described in Vikipedia under the Luhn algorithm


declare @idStr  varchar (10)=  '20377121'-- the variable is written without the required digit since we want the CTE to calc the digit'
select @idStr

;with cte (num,pos,mul,sumOfDigits) 
	as  (
		 select 1 num,
			substring(@idStr , 1 , 1 ) ,
			cast(substring(@idStr , 1 , 1 ) as int) * ((1%2)+1) , 
			cast(substring(@idStr , 1 , 1 ) as int) * ((1%2)+1) 

		 union all 
		 select num +1,  -- iteration number
				substring(@idStr , num+1 , 1 ) pos , -- the digit in the Nth place
				cast(substring(@idStr , num+1 , 1 ) as int)* (((num+1)%2)+1) mul , -- the digit in the Nth place multiplied by 1 or 2
				sumOfDigits + cast(substring(@idStr , num+1 , 1 ) as int)* (((num+1)%2)+1) -- the sum of all the multiplations 
		 from cte  
				where num +1 < 9 -- assumption that the format of the string is valid
		 )
	--select * from cte  
	select top 1 sumOfDigits % 10  from cte  order by sumOfDigits desc



	go

	