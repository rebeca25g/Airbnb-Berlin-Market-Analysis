# Berlin Airbnb Market Analysis

This project analyzes **14,274 Airbnb listings across Berlin's 12 districts** to understand how price varies geographically, who actually controls the supply, and how the city's short-term-rental regulation shows up in the data.

The objective is to turn a raw listings snapshot into a clear picture of the Berlin short-term-rental market — useful for anyone looking at pricing strategy, market concentration, or housing/tourism policy.

## 🎯 Business Problem

Short-term rentals sit at the intersection of tourism, housing, and regulation. Berlin in particular enforces strict rules on short-term letting, which shapes how the market behaves. Understanding the supply requires looking past the "individual host renting a spare room" image and asking what the data actually shows.

This project aims to answer:

**Where is Airbnb supply concentrated, how does price vary across the city, who runs the listings, and how does regulation surface in host behaviour?**

## 📊 Dataset

The dataset is an Inside Airbnb summary snapshot of Berlin listings (18 original columns, 14,274 rows) covering:

- Listing & host identifiers (listing ID, host ID, host name)
- Geography (district `neighbourhood_group`, neighbourhood, latitude/longitude)
- Listing attributes (room type, price, minimum nights, availability over 365 days)
- Activity (number of reviews, last review date, reviews per month)
- Host scale (`calculated_host_listings_count`)
- Registration/licence text

**A note on price coverage:** about 35% of listings have no listed price. These rows are **kept in the dataset** — they're perfectly valid for counting listings, geography, room type, host, and review analysis — but are **excluded from price-specific metrics**. All price figures in this project are therefore based on the ~9,242 priced listings, while supply and host counts use the full 14,274. This per-metric filtering keeps price averages honest without throwing away a third of the data.

## 🔧 Tools & Technologies

- **Python (Pandas)** → Data cleaning, type fixing, and feature engineering
- **PostgreSQL** → Data loading and business-question analysis
- **Power BI** → Five-page interactive dashboard
- **GitHub** → Project structure and version control

## 🧹 Data Cleaning & Preparation

Key cleaning steps (Python / Pandas):

- Converted `price` to numeric and `last_review` to a proper date type.
- **Capped implausible prices:** listings priced above €5,000/night (a small block of clear data errors, e.g. €40,000–€50,000 placeholders) had their price set to blank, keeping the row intact for non-price analysis.
- **Filled review blanks correctly:** `reviews_per_month` set to 0 only where a listing genuinely has no reviews (a true zero, not a guess); `last_review` left blank where no date exists.
- Exported with full quoting to avoid delimiter issues from commas inside listing names.

Engineered columns added for analysis:

- `price_category` — Budget / Mid-range / Premium / Luxury bands
- `price_band` — finer price ranges for distribution analysis
- `host_type` — single-listing vs. multi-listing host
- `availability_category` — availability bucket over the year
- `has_reviews` — whether a listing has any reviews
- `has_license` — whether registration information is shown (see caveat below)
- `min_nights_band` — minimum-stay buckets (1, 2–3, 4–7, 8–30, 31+ nights)

## 🔍 Analysis Focus

- Price geography across districts and neighbourhoods
- Room type mix and price by room type
- Host concentration (individuals vs. commercial operators)
- Registration coverage
- Review volume, activity, and recency
- Minimum-stay patterns and their link to regulation

## 📈 Dashboard

The Power BI report is a **five-page interactive dashboard** with a sidebar navigation menu and cross-filtering (clicking a district or room type filters the whole page):

**Overview** — headline KPIs (total listings, unique hosts, median price, average availability, listings with reviews) plus:
- A choropleth map of average price by district (built from a custom Berlin districts boundary file)
- A combo chart of supply vs. average price by district
- Room-type, price-category, and host-type breakdowns

**Neighborhoods** — district price heatmap, a district breakdown table (listings / average price / average reviews), and neighbourhood-level bars for both the most-listed and priciest neighbourhoods (the latter filtered to areas with enough listings to be reliable).

**Listings** — price distribution histogram, average price by room type, room-type mix, minimum-nights breakdown, availability bands, and a sample of the most expensive listings.

**Hosts** — single vs. multi-listing split, listings-per-host concentration, average price by host type, and a Top 10 hosts table.

**Reviews** — total review volume, with/without-review split, review activity by year (last-review date), and total reviews by district.


## 💡 Key Insights

- **The centre commands a premium.** Mitte has both the highest average price (~€156/night) and is among the largest by supply, while outer districts like Marzahn-Hellersdorf (~€97) sit at the bottom. Price clearly concentrates in the central ring.
- **The market is whole-unit, not spare-room.** Entire homes/apartments make up **67.7%** of listings versus 30.8% private rooms — the supply skews heavily toward full units rather than hosts renting a spare room.
- **A small number of operators hold a meaningful share.** **43.4%** of listings belong to multi-listing hosts, the top 10 hosts alone control **~6.75%** of all listings, and the single largest operator (Blueground) runs **311** listings. This is a market with a visible commercial layer, not purely individuals.
- **Commercial hosts charge more.** Multi-listing hosts average ~€144/night versus ~€119 for single-listing hosts — professional operators price above casual ones.
- **Regulation leaves a fingerprint.** The single largest minimum-stay bucket is **31+ nights (~5,480 listings)** — consistent with hosts structuring stays as longer-term rentals to work around Berlin's short-term-let restrictions (*Zweckentfremdungsverbot*). This is arguably the project's sharpest finding.
- **Registration coverage is partial.** Roughly 65% of listings show registration information and ~35% show none. Note: "none shown" means *no registration info was displayed* — not proven unlicensed.
- **Reviews concentrate centrally.** ~635K reviews in total; **77%** of listings have at least one review. Review activity mirrors price geography — Mitte (~160K) and Friedrichshain-Kreuzberg (~152K) dominate.
- **Typical price is modest, with a thin luxury tail.** Median price is **€104/night**, most listings fall in the €50–150 band, and only a small share sit above €300 — with a handful of genuine high-end spaces (€2,500–€3,800).

## 📌 Analytical Takeaways

- **The 31+ night cluster and the registration gap are the headline regulatory signals** — both are worth monitoring as proxies for how the market is responding to short-term-let rules.
- **Supply concentration matters for policy and platform alike.** A professionalised minority holds a disproportionate share, so any analysis treating Berlin Airbnb as purely peer-to-peer would be misleading.
- **Price and demand cluster centrally**, which is relevant for where regulatory attention and pricing competition are highest.
- **Insights are stated with their caveats** — price metrics use only priced listings, registration is framed as "shown / not shown," and an estimated-revenue view was deliberately *excluded* from the dashboard because the source data contains no revenue figure (any such number would be a model, not a fact).

## 📁 Project Structure

```
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
    └── (dashboard screenshots)
```

## 📌 Project Goal

This project demonstrates how a raw listings snapshot can be cleaned, queried, and visualized into a clear, honest picture of a regulated short-term-rental market — bridging the gap between raw Airbnb data and market understanding.

It showcases skills in:

- Data cleaning and feature engineering
- SQL-based analysis
- Geographic and segment-level analysis
- Interactive dashboard design
- Communicating findings honestly, with explicit data caveats<img width="1158" height="653" alt="Screenshot 2026-05-27 at 17 14 24" src="https://github.com/user-attachments/assets/b2fbb200-8b17-45e9-bb51-097ecc07fe2f" />
<img width="1158" height="653" alt="Screenshot 2026-05-27 at 17 14 24" src="https://github.com/user-attachments/assets/fbef9b72-fc0f-4fd9-93f8-573f7c210275" />
<img width="1158" height="654" alt="Screenshot 2026-05-27 at 17 14 17" src="https://github.com/user-attachments/assets/910e1ae2-5d4d-493f-a865-caa0960cb0df" />
<img width="1161" height="655" alt="Screenshot 2026-05-27 at 17 14 09" src="https://github.com/user-attachments/assets/59cd8838-2665-4d5b-8f7d-cfeb6f776d3d" />
<img width="1158" height="647" alt="Screenshot 2026-05-27 at 17 14 02" src="https://github.com/user-attachments/assets/b447468e-cb64-4be0-9c9c-dedc802b325d" />
<img width="1154" height="655" alt="Screenshot 2026-05-27 at 17 13 54" src="https://github.com/user-attachments/assets/e8e4ee5f-77f8-4156-833e-05e62be6a183" />

