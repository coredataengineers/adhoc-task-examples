## OVERVIEW
The `basic_write_to_s3.py` script simply write 10 randomly generated profiles from the Faker package to s3, on the fly the scripts 
register the objects written to s3 in Glue Data Catalog, this will enable anyone to use athena as a query engine on top
to query  the objects directly in s3.


### OVERVIEW

- Launch VSCode or any similar Text Editor/IDE/Code Editor
- Create a virtual environment by running `python3 -m venv venv` on your editor command line.
  - Ensure virtual environment is installed on your machine.
- Activate the virtual environment by running `source venv/bin/activate` on your editor command line.
- Time to install the below packages by running
  - `pip install awswrangler` ( This will also install pandas and boto3 behind the scene )
  - `pip install faker`
 

### NOTE
- Your aws credentials will need to be substituted on line 8 and 9 in the python script file.
- **PLEASE DO NOT PUSH YOUR CREDENTIAL TO GITHUB**
  - This is only an example to demonstrate the usage of Aws wrangler.
