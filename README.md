# nettikauppasimulaattori_dbt
DBT-code related to the nettikauppasimulaattori-project analytics.

Main parts:
--------------

import_production_database: 
    Simulates importing production database to data warehouse.
    Adds created_at date-tag for monitoring source freshness.

staging:
    Basic data-sanitation, throwing out duplicates and NULL data.

calender_analysis:
    Basic order-statistics like total sales for hour, day, and month time-bins.
    TODO: Add same for products. Maybe merge product analysis here?
    TODO: Change into incremental models.

customer_analysis:
    Extract features describing customer behavious for each customer.
    Main goal is to use ML-clustering for identifying possible customer-segments.

product_analysis:
    Basic totals for each product and product-category, how many ordered, total sales etc.
    TODO: should probably calculate per hour, day, month to track possible changes over time.

