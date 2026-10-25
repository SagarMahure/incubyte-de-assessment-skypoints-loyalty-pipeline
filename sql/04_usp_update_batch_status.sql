CREATE OR ALTER PROCEDURE dbo.usp_update_batch_status
    @batch_id       VARCHAR(20),
    @feed_type      VARCHAR(50),
    @status         VARCHAR(10),
    @pipeline_name  VARCHAR(255)  = NULL,
    @run_id         VARCHAR(100)  = NULL,
    @rows_read      BIGINT        = NULL,
    @rows_valid     BIGINT        = NULL,
    @rows_rejected  BIGINT        = NULL,
    @error_message  VARCHAR(2000) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @status NOT IN ('STARTED', 'SUCCESS', 'FAILED')
        THROW 50003, 'status must be STARTED, SUCCESS or FAILED', 1;

    UPDATE dbo.ctl_batch_log
    SET status                = @status,
        started_at            = CASE WHEN @status = 'STARTED' THEN SYSUTCDATETIME() ELSE started_at END,
        finished_at           = CASE WHEN @status IN ('SUCCESS', 'FAILED') THEN SYSUTCDATETIME() ELSE finished_at END,
        processed_by_pipeline = COALESCE(@pipeline_name, processed_by_pipeline),
        processed_run_id      = COALESCE(@run_id, processed_run_id),
        rows_read             = COALESCE(@rows_read, rows_read),
        rows_valid            = COALESCE(@rows_valid, rows_valid),
        rows_rejected         = COALESCE(@rows_rejected, rows_rejected),
        error_message         = CASE WHEN @status = 'FAILED' THEN @error_message ELSE NULL END
    WHERE batch_id = @batch_id AND feed_type = @feed_type;

    IF @@ROWCOUNT = 0
        THROW 50004, 'batch not found in ctl_batch_log', 1;
END;