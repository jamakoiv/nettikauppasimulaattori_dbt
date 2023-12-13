{{
    config(
        materialized='table'
    )
}}

WITH predict_features AS (
    SELECT 
        product.id AS id,
        CAST(product.id / 1000 AS INTEGER) AS product_category,
        product.price AS price,
        stats.products_ordered AS products_ordered
    FROM {{ ref('PA_individual_products') }} AS stats
    JOIN {{ ref('staging_products') }} AS product
    ON product.id = stats.id
)

SELECT * FROM {{ dbt_ml.predict( ref("PA_linreg_products_ordered"), "predict_features") }}