CREATE EXTERNAL SCHEMA s3_spectrum_random_profile
FROM DATA CATALOG 
DATABASE 'cde_glue_database' 
IAM_ROLE 'arn:aws:iam::your-aws-account-id:role/redshift-dedicated-role';