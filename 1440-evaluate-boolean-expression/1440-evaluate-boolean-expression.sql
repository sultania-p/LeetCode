/* Write your T-SQL query statement below */
select
	E.left_operand,
	E.operator,
	E.right_operand,
	case when operator = '>' and (VL.value > VR.value) then 'true'
		when operator = '<' and (VL.value < VR.value) then 'true'
		when operator = '=' and (VL.value = VR.value) then 'true'
		else 'false' end as value
	--VL.value, VR.value
from Expressions E
left join Variables VL on E.left_operand=VL.name
left join Variables VR on E.right_operand=VR.name