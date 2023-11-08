import snowflake.connector
from pathlib import Path

def test_queries(conn, queries, *, performance_query='snowflake_profiler.sql'):

    performance_sql = Path(performance_query).read_text()

    with conn.cursor() as cur:
        for query in queries:
            cur.execute(queries) # TODO make this async
            cur.execute(performance_query) # performance data is now in the `query_performance` table


def main(query_paths):
    queries = (Path(query_path).read_text() for query_path in query_paths)
    with snowflake.connector.connect(connection_name="test") as conn:
        test_queries(conn, queries)


if __name__ == '__main__':
     import argparse
     parser = argparse.ArgumentParser()
     parser.add_argument('queries', nargs='+', type=Path)
     args = parser.parse_args()
     main(query_paths=args.queries)

