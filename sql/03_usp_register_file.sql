CREATE OR ALTER PROCEDURE dbo.usp_register_file
    @batch_id        VARCHAR(20),
    @feed_type       VARCHAR(50),
    @file_name       VARCHAR(255),
    @source_path     VARCHAR(255),
    @pipeline_name   VARCHAR(255),
    @run_id          VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF @batch_id NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        THROW 50001, 'batch_id must be 8 digits (YYYYMMDD)', 1;

    IF @feed_type NOT IN ('members', 'redemptions')
        THROW 50002, 'feed_type must be members or redemptions', 1;

    IF NOT EXISTS (SELECT 1 FROM dbo.ctl_batch_log WITH (UPDLOCK, HOLDLOCK)
                   WHERE batch_id = @batch_id AND feed_type = @feed_type)
    BEGIN
        INSERT INTO dbo.ctl_batch_log
            (batch_id, feed_type, file_name, source_path, status,
             registered_by_pipeline, registered_run_id, received_at)
        VALUES
            (@batch_id, @feed_type, @file_name, @source_path, 'PENDING',
             @pipeline_name, @run_id, SYSUTCDATETIME());
    END
END;