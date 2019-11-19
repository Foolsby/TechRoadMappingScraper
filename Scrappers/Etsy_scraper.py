from selectorlib import Extractor
import requests
from Data.EtsyProducts import URLs as EtsyURLs
import pandas as pd

i = 1
my_json_data = []
for url in EtsyURLs:
    # Create an Extractor by reading from the YAML file
    e = Extractor.from_yaml_file('Etsy.txt')
    i = i + 1
    j = divmod(i, 3)
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36"
    header = {'User-Agent': user_agent}

    # Download the page using requests\
    r = requests.get(url, headers=header)
    data = e.extract(r.text)
    # Print the data
    my_json_data.append(data)
    # print(json.dumps(data, indent=True))

final_df = pd.DataFrame(my_json_data,
                        columns=["Product", "Price", "Ratings", "Score", "Response_Rate","Related_Topic"
                                 "Seller"])
final_df.to_csv("EtsyProducts.csv")
