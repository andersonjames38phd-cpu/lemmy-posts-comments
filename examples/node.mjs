// Lemmy Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Top posts in two communities
const run = await client.actor('Turboextract/lemmy-posts-comments').call({
    "communities": [
        "technology",
        "selfhosted"
    ],
    "sort": "Top",
    "maxResultsPerQuery": 50
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.score, item.community, item.title);
}
