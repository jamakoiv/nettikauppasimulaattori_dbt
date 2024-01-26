## DBT-code related to the nettikauppasimulaattori-repository.

Import operational database from the nettikauppasimulaattori-project and
transform the data to suitable form for analysis.

Main parts have been arranged into following directories in models:

 - **import_production_database**: 
    - Import raw production-database to data warehouse.
    - Add date-tag for monitoring source freshness.

 - **staging**:
    - Data-sanitation, throw out duplicates and incomplete data.
    - Limit amount of data if using development-environment.

 - **calender_analysis**:
    - Statistics (total sales, amount of orders etc.) orders for hour, day, and month.
    - Used mainly for ML-models forecasting future sales etc.

 - **customer_analysis**:
    - Extract features related to customer behaviour for each customer.
    - Used mainly as input for customer-segmentation ML-models.

 - **product_analysis**:
    - Totals for each product and product-category, how many ordered, total sales etc.
    - TODO: Move to calender_analysis.
    - TODO: Calculate per hour, day, month to track possible changes over time.

