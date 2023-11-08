insert into query_performance
select stats.Query_ID, 
	Coalesce(stats.Step_ID, "All Steps") as Step_ID,
	Coalesce(
		stats.Operator_type, 
		CONCAT("All Operators (for step" , Coalesce(stats.Step_ID, "All Steps"),")")
	) as Operator_type,
	sum(stats.EXECUTION_TIME_BREAKDOWN:initialization) as init_time,
	sum(stats.EXECUTION_TIME_BREAKDOWN:processing) as cpu_time,
	sum(stats.EXECUTION_TIME_BREAKDOWN:synchronization) as sync_time,
	sum(stats.EXECUTION_TIME_BREAKDOWN:local_disk_io) as local_io_time,
	sum(stats.EXECUTION_TIME_BREAKDOWN:remote_disk_io) as remote_io_time,
	sum(stats.EXECUTION_TIME_BREAKDOWN:network_communication) as network_wait_time,
from table(get_query_operator_stats(last_query_id())) as stats
group by Stats.Query_Id, Rollup(Stats.Step_ID, Stats.Operator_Type)

