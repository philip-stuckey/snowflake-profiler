Proposal for a PyODBC-inspired profiler.

By Philip Stuckey <pstuc002@fastmail.com>

The following sample code contains a proof of concept for automatically testing any number of SQL queries against a hypothetical snowflake warehouse/database. The Python script demonstrates connecting to a test instance, running a set of queries against the database, and collecting and aggregating some simple performance metrics.  Accompanying this is an  SQL script (`snowflake_profiler.sql`) that describes the actual metrics, which it calculates for the last run query and stores in a table called "query_performance". This approach minimizes the amount of data sent between the client and server. 

There are a few possible improvements that could be made to this program, for instance, the Python script could be made to submit each query asynchronously, and `snowflake_profiler.sql` should ideally be in a stored procedure. However, because I don't have a snowflake instance to test this against, I reasoned that a simpler implementation was probably better as a first pass.

The only module used in this project was the `snowflake-connector-python` package.
