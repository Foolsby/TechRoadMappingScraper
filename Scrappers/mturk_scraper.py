from Data.MtrukURLs import data
import pandas as pd
from datetime import datetime
from datetime import timedelta

i = 1
my_json_data = []
for page in data:
    for i in range(len(page["Requestors"])):
        req = page["Requestors"][i]
        t = page["Titles"][i]
        h = page["HITs"][i]
        rew = page["Reward"][i]
        cr = page["Created"][i]
        if " ago" in cr:
            cr = cr.replace(" ago", "")
            if "m" in cr:
                cr = cr.replace("m", "")
                cr = str(datetime.now() - timedelta(minutes=int(cr)))
            elif "s" in cr:
                cr = cr.replace("s", "")
                cr = str(datetime.now() - timedelta(seconds=int(cr)))
            elif "h" in cr:
                cr = cr.replace("h", "")
                cr = str(datetime.now() - timedelta(hours=int(cr)))
            elif "d" in cr:
                cr = cr.replace("d", "")
                cr = str(datetime.now() - timedelta(days=int(cr)))
        else:
            cr = str(datetime.strptime(cr, '%m/%d/%Y'))


        my_json_data.append([req, t, h, rew, cr])

final_df = pd.DataFrame(my_json_data,
                        columns=["Requestors", "Titles", "HITs", "Reward", "Created"])
final_df.to_csv("MturkServices.csv")
