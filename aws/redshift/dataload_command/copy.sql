COPY staging.copy_operation_demo 
FROM 's3://cde-redshift-spectrum-demo/random_profile/' 
IAM_ROLE 'arn:aws:iam::Your-Account-ID:role/redshift-dedicated-role'
FORMAT AS PARQUET;