from pyspark.sql import SparkSession

import os
os.environ['PYSPARK_PYTHON'] = 'C:\\Users\\progr\\AppData\\Local\\Microsoft\\WindowsApps\\python.exe'

# Create a Spark Session
spark = SparkSession.builder \
    .appName("PySparkTest") \
    .getOrCreate()

# Test the Spark context
data = [("James", "Smith"), ("Anna", "Rose"), ("Robert", "Williams")]
columns = ["firstname", "lastname"]

# Create a DataFrame
df = spark.createDataFrame(data, columns)
df.show()

# Stop the Spark session
spark.stop()