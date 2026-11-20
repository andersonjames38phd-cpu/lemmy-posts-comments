"""Lemmy Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Comments mentioning your product this week
run = client.actor("Turboextract/lemmy-posts-comments").call(run_input={
    "searchQueries": [
        "your product"
    ],
    "contentType": "comments",
    "postedWithinDays": 7
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("score"), item.get("community"), item.get("title"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
