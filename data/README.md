# Data ingestion pipeline for almanac

- Download the data dump from [OpenLibrary](https://openlibrary.org/developers/dumps) and extract it to the data directory

```bash
wget https://openlibrary.org/data/ol_dump_works_latest.txt.gz
gzip -d ol_dump_works_latest.txt.gz
```

> The data dump is usually a large file, so it may take a while to download and extract it.

- Open the [ingest.ipynb](ingest.ipynb) notebook and run the cells except the last one to clean and transform the data
- Before running the last cell, make sure you update the following environment variables with your own values. If you leave it as it is, the default values will be used.

```python
os.environ['DB_HOST'] = 'localhost' # Hostname of the database
os.environ['DB_PORT'] = '5432' # Port of the database
os.environ['DB_USER'] = 'postgres' # Username of the database
os.environ['DB_PASSWORD'] = 'password' # Password of the database
os.environ['DB_NAME'] = 'almanac' # Name of the database
```
- Run the last cell to ingest the data into the database