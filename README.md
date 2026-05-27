Berlin Airbnb Market Analysis

This project analyzes 14,274 Airbnb listings across Berlin’s 12 districts to understand how pricing, supply concentration, and host behaviour vary across the city — and how Berlin’s short-term-rental regulation appears in the data.

Using a combination of Python, PostgreSQL, and Power BI, the project turns a raw Airbnb listings snapshot into a structured view of the Berlin short-term-rental market, with a focus on pricing geography, commercial hosting activity, and regulatory patterns.

🎯 Business Problem

Short-term rentals sit at the intersection of tourism, housing, and regulation. Berlin in particular enforces strict rules on short-term letting, which significantly shapes how the market behaves.

This project aims to answer:

Where is Airbnb supply concentrated, how does price vary across the city, who controls the listings, and how do regulatory patterns surface in host behaviour?

📊 Dataset

The dataset is an Inside Airbnb summary snapshot of Berlin listings containing 18 original columns and 14,274 rows.

It includes:

Listing and host identifiers
Geographic information (neighbourhood_group, neighbourhood, latitude/longitude)
Listing characteristics (room type, price, minimum nights, availability)
Review activity and recency
Host portfolio size (calculated_host_listings_count)
Registration/licence text
Price Coverage Caveat

Approximately 35% of listings do not contain a listed price.

These rows were retained for supply, geography, room-type, and host analysis, but excluded from price-specific calculations. As a result:

Price metrics use ~9,242 priced listings
Supply and host metrics use the full 14,274 listings

This per-metric filtering preserves analytical accuracy without discarding a large portion of the dataset.

🔧 Tools & Technologies
Python (Pandas) — data cleaning and feature engineering
PostgreSQL — analytical querying
Power BI — interactive dashboard development
GitHub — project structure and version control
🧹 Data Cleaning & Preparation

Key cleaning steps included:

Converting price to numeric format and last_review to a date type
Handling implausible price outliers (e.g. €40,000–€50,000 placeholder values) by setting them to blank while preserving the listings for non-price analysis
Filling reviews_per_month with 0 only where listings genuinely had no reviews
Leaving missing last_review values blank rather than imputing dates
Exporting cleaned data with full quoting to prevent delimiter issues
Engineered Features

Additional analytical fields were created, including:

price_category
price_band
host_type
availability_category
has_reviews
has_license
min_nights_band
💡 Key Insights
Central Berlin commands the highest prices. Mitte has the highest average nightly price (~€156), while outer districts such as Marzahn-Hellersdorf (~€97) sit at the lower end of the market.
The market is dominated by entire homes. Entire homes/apartments account for 67.7% of listings, compared with 30.8% private rooms, indicating that Berlin’s Airbnb supply is primarily whole-unit accommodation rather than spare-room hosting.
Commercial operators hold a meaningful share of supply.
43.4% of listings belong to multi-listing hosts
The top 10 hosts control approximately 6.75% of all listings
The largest operator, Blueground, manages 311 listings
Professional hosts charge higher prices. Multi-listing hosts average roughly €144/night, compared with €119/night for single-listing hosts.
Regulatory patterns appear in minimum-stay behaviour. The largest minimum-stay segment is 31+ nights (~5,480 listings), consistent with hosts shifting toward longer-stay models in response to Berlin’s short-term-let restrictions (Zweckentfremdungsverbot).
Registration visibility is incomplete. Around 65% of listings display registration information, while ~35% do not. “Not shown” does not necessarily imply non-compliance.
Reviews concentrate in central districts. The dataset contains approximately 635K total reviews, with review activity heavily concentrated in Mitte and Friedrichshain-Kreuzberg.
The market has a modest core with a thin luxury tail. Median nightly price is €104, with most listings concentrated in the €50–150 range and relatively few above €300/night.
📈 Dashboard

The Power BI report is structured as a five-page interactive dashboard featuring sidebar navigation and cross-filtering functionality.

Overview
Headline KPIs
Choropleth map of average price by district
Supply vs. average price comparison
Room-type and host-type breakdowns
Neighborhoods
District price heatmap
District comparison table
Most-listed and highest-priced neighbourhood analysis
Listings
Price distribution analysis
Room-type pricing comparison
Minimum-night and availability breakdowns
High-price listing samples
Hosts
Single vs. multi-listing host comparison
Host concentration analysis
Top 10 hosts table
Reviews
Review volume and activity trends
Listings with vs. without reviews
Review distribution by district
📌 Analytical Takeaways
The 31+ night minimum-stay cluster and partial registration visibility are the strongest indicators of how regulation influences market behaviour.
Berlin’s Airbnb market includes a substantial commercial layer, meaning the platform cannot be viewed purely as peer-to-peer accommodation.
Pricing, review activity, and listing density all cluster heavily in central districts.
Analytical caveats are explicitly maintained throughout the project:
Price metrics use only priced listings
Registration status is framed as “shown/not shown”
Estimated revenue calculations were intentionally excluded because the source data does not contain revenue figures
📁 Project Structure
berlin-airbnb-analysis/
│
├── data/
│   ├── raw/
│   └── cleaned/
│       └── airbnb_berlin_cleaned.csv
│
├── python/
│   └── airbnb_berlin.ipynb
│
├── sql/
│   └── airbnb_berlin.sql
│
├── powerbi/
│   └── airbnb_berlin_dashboard.pbix
│
└── assets/
    └── dashboard screenshots
📌 Project Goal

This project demonstrates how a raw listings dataset can be cleaned, queried, and visualized into a clear and transparent view of a regulated short-term-rental market.

It showcases:

Data cleaning and feature engineering
SQL-based analytical workflows
Geographic and segment-level analysis
Interactive dashboard development
Communicating findings with explicit analytical caveats
