import pandas as pd
import awswrangler as wr
import boto3
from faker import Faker


session = boto3.Session(
            aws_access_key_id="xxxx",
            aws_secret_access_key="xxxxx",
            region_name="eu-north-1"
        )

sample = Faker()

bunch_of_profiles = [sample.profile() for profile in range(1000)]
profiles_df = pd.DataFrame(bunch_of_profiles)


profiles_df = profiles_df[[
            "job",
            "company",
            "ssn",
            "residence",
            "blood_group",
            "username",
            "name",
            "sex",
            "address",
            "mail"
        ]]

# Write to s3 in Parquet Format and register in glue data catalog
wr.s3.to_parquet(
        df=profiles_df,
        path="s3://cde-redshift-spectrum-demo/random_profile/",
        boto3_session=session,
        mode="append",
        database="cde_glue_database",
        table="random_user_profiles",
        dataset=True
    )

print("Data Successfully written to s3 and registered in Glue Catalog")
