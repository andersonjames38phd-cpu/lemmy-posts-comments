#!/usr/bin/env bash
# Lemmy Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~lemmy-posts-comments"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Comments mentioning your product this week (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "searchQueries": [
      "your product"
    ],
    "contentType": "comments",
    "postedWithinDays": 7
  }'

# 2. Top posts in two communities (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "communities": [
      "technology",
      "selfhosted"
    ],
    "sort": "Top",
    "maxResultsPerQuery": 50
  }'

# 3. Newest posts on another instance (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "instance": "programming.dev",
    "maxResultsPerQuery": 100
  }'
