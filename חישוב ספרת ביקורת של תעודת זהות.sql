--Cal Tz
-- check on two IDS :   31511047-8
-- the algorithm is described in Vikipedia under the Luhn algorithm

select 'Full ID Number is 31511047-8'
declare @idStr  varchar (10)=  '31511047'-- the variable is written without the required digit since we want the CTE to calc the digit'

;with cte (num,pos,mul,sumOfDigits) 
	as  (
		 select 1 num,
			substring(@idStr , 1 , 1 ) ,
			cast(substring(@idStr , 1 , 1 ) as int) * 1 , 
			cast(substring(@idStr , 1 , 1 ) as int) * 1 

		 union all 
		 select num +1,  -- iteration number
				substring(@idStr , num+1 , 1 ) pos , -- the digit in the Nth place
				cast(substring(@idStr , num+1 , 1 ) as int)* ((num%2)+1) mul , -- the digit in the Nth place multiplied by 1 or 2
				case when cast(substring(@idStr , num+1 , 1 ) as int)* ((num%2)+1) < 10
				then
					sumOfDigits + cast(substring(@idStr , num+1 , 1 ) as int)* ((num%2)+1) -- the sum of all the multiplations 
				else
					sumOfDigits + cast(substring(@idStr , num+1 , 1 ) as int)* ((num%2)+1) - 9  -- the sum of all the multiplations 
				end
		 from cte  
				where num +1 < 9 -- assumption that the format of the string is valid
		 )
--	select * from cte  
	select top 1 10 - (sumOfDigits % 10)  from cte  order by sumOfDigits desc



	go

	