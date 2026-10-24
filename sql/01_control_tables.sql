CREATE TABLE ctl_batch_log (
    batch_id               VARCHAR(8)    NOT NULL,   -- YYYYMMDD
    feed_type              VARCHAR(20)   NOT NULL,   -- members | redemptions
    file_name              VARCHAR(200)  NOT NULL,
    source_path            VARCHAR(500)  NULL,
    file_size_bytes        BIGINT        NULL,
    status                 VARCHAR(10)   NOT NULL,   -- PENDING | STARTED | SUCCESS | FAILED
    registered_by_pipeline VARCHAR(100)  NULL,
    registered_run_id      VARCHAR(100)  NULL,
    received_at            DATETIME2     NOT NULL,
    started_at             DATETIME2     NULL,
    finished_at            DATETIME2     NULL,
    processed_by_pipeline  VARCHAR(100)  NULL,
    processed_run_id       VARCHAR(100)  NULL,
    rows_read              BIGINT        NULL,
    rows_valid             BIGINT        NULL,
    rows_rejected          BIGINT        NULL,
    error_message          VARCHAR(2000) NULL,
    CONSTRAINT pk_ctl_batch_log PRIMARY KEY (batch_id, feed_type)
);