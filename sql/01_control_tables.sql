CREATE TABLE ctl_batch_log (
    batch_id        VARCHAR(8)    NOT NULL,   -- YYYYMMDD
    feed_type       VARCHAR(20)   NOT NULL,   -- members | redemptions
    file_name       VARCHAR(200)  NOT NULL,
    status          VARCHAR(10)   NOT NULL,   -- STARTED | SUCCESS | FAILED
    rows_read       BIGINT        NULL,
    rows_valid      BIGINT        NULL,
    rows_rejected   BIGINT        NULL,
    started_at      DATETIME2     NOT NULL,
    finished_at     DATETIME2     NULL,
    error_message   VARCHAR(2000) NULL,
    pipeline_run_id VARCHAR(100)  NULL,
    CONSTRAINT pk_ctl_batch_log PRIMARY KEY (batch_id, feed_type)
);