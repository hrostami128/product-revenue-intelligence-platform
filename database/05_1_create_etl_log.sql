CREATE TABLE IF NOT EXISTS staging.etl_log (

    log_id BIGSERIAL PRIMARY KEY,

    process_name VARCHAR(100) NOT NULL,

    target_table VARCHAR(100) NOT NULL,

    start_time TIMESTAMP NOT NULL,

    end_time TIMESTAMP NOT NULL,

    rows_loaded INTEGER NOT NULL,

    status VARCHAR(20) NOT NULL,

    error_message TEXT,

    executed_by VARCHAR(100),

    execution_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

INSERT INTO staging.etl_log (

process_name,

target_table,

start_time,

end_time,

rows_loaded,

status,

executed_by

)

VALUES (

'Load Customers',

'staging.customers',

CURRENT_TIMESTAMP,

CURRENT_TIMESTAMP,

(SELECT COUNT(*) FROM staging.customers),

'SUCCESS',

CURRENT_USER

);