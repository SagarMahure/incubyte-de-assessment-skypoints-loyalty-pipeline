CREATE TABLE audit_dq_summary (
    batch_id   VARCHAR(8)   NOT NULL,
    feed_type  VARCHAR(20)  NOT NULL,
    rule_code  VARCHAR(40)  NOT NULL,   
    severity   VARCHAR(10)  NOT NULL,   -- ERROR | WARN
    rows_hit   BIGINT       NOT NULL,
    logged_at  DATETIME2    NOT NULL
);