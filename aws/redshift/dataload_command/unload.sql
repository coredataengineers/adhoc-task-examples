UNLOAD ('SELECT * FROM staging.copy_operation_demo')
TO 's3://cde-redshift-spectrum-demo/unload_ops/' 
IAM_ROLE 'arn:aws:iam::Your-Account-ID:role/redshift-dedicated-role'
PARQUET
PARALLEL FALSE; -- Use this to control number of compute node slice to work.