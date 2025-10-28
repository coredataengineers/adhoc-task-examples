import pandas as pd
import awswrangler as wr
import boto3
from faker import Faker


session = boto3.Session(
            aws_access_key_id="xxxxxx",
            aws_secret_access_key="xxxxxxxx",
            region_name="eu-north-1"
        )

sample = Faker()

bunch_of_profiles = [sample.profile() for profile in range(10)]
profiles_df = pd.DataFrame(bunch_of_profiles)


# filtering out unproblematic column out for write to the lake
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
        path="s3://cde-demo-wrangler/random_user_profile/",
        boto3_session=session,
        mode="append",
        database="sample",
        table="random_user_profiles",
        dataset=True
    )
