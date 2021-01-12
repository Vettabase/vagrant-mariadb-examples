# Views to identify problems in the code that deals with MariaDB.
# Sources:
#   - https://federico-razzoli.com/run-less-queries-in-mysql
#   - https://vettabase.com/blog/understanding-tables-usage-with-user-statistics-percona-server-mariadb/


CREATE SCHEMA IF NOT EXISTS _;
USE _;


-- Queries that always return an error
CREATE OR REPLACE VIEW sql_failed AS
    SELECT
            DIGEST_TEXT,
            COUNT_STAR,
            FIRST_SEEN,
            LAST_SEEN
        FROM performance_schema.events_statements_summary_by_digest
        WHERE
            DIGEST_TEXT IS NOT NULL
            AND SUM_ERRORS = COUNT_STAR
            AND COUNT_STAR > 20
            AND LAST_SEEN > (NOW() - INTERVAL 1 MONTH)
        ORDER BY COUNT_STAR
\G

# Queries that always return/affect 0 rows
CREATE OR REPLACE VIEW sql_no_rows AS
    SELECT *
        FROM performance_schema.events_statements_summary_by_digest
        WHERE
            (
                   TRIM(DIGEST_TEXT) LIKE 'SELECT%'
                OR TRIM(DIGEST_TEXT) LIKE 'CREATE%TABLE%SELECT%'
                OR TRIM(DIGEST_TEXT) LIKE 'DELETE%'
                OR TRIM(DIGEST_TEXT) LIKE 'UPDATE%'
                OR TRIM(DIGEST_TEXT) LIKE 'REPLACE%'
            )
            AND SUM_ROWS_SENT = 0
            AND SUM_ROWS_AFFECTED = 0
            AND COUNT_STAR > 20
            AND LAST_SEEN > (NOW() - INTERVAL 1 MONTH)
        ORDER BY SUM_ROWS_EXAMINED
\G

# Unused indexes
CREATE OR REPLACE VIEW index_unused AS
    SELECT st.TABLE_SCHEMA, st.TABLE_NAME, st.INDEX_NAME
        FROM information_schema.STATISTICS st
        LEFT JOIN information_schema.INDEX_STATISTICS idx
            ON  idx.INDEX_NAME    = st.INDEX_NAME
            AND idx.TABLE_NAME    = st.TABLE_NAME
            AND idx.TABLE_SCHEMA  = st.TABLE_SCHEMA
        WHERE
            st.TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')
            AND idx.INDEX_NAME IS NULL
            AND st.NON_UNIQUE = 1
        ORDER BY st.TABLE_SCHEMA, st.TABLE_NAME, st.INDEX_NAME
\G

# Unused tables
CREATE OR REPLACE VIEW tables_unused AS
    SELECT
            t.TABLE_SCHEMA, t.TABLE_NAME, t.ENGINE
        FROM information_schema.TABLES t
        LEFT JOIN information_schema.TABLE_STATISTICS s
            ON t.TABLE_SCHEMA = s.TABLE_SCHEMA AND t.TABLE_NAME = s.TABLE_NAME
        WHERE t.TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')
            AND ROWS_READ IS NULL AND ROWS_CHANGED IS NULL
;

