{{
    config(
        materialized='model',
        ml_config={
            'model_type': 'linear_reg',
            'input_label_cols': ['products_ordered']    
        },
        post_hook="{{ dbt_ml.model_audit() }}"
    )
}}

SELECT 
    product.id AS id,
    CAST(product.id / 1000 AS INTEGER) AS product_category,
    product.price AS price,
    stats.products_ordered AS products_ordered
FROM {{ ref('PA_individual_products') }} AS stats
JOIN {{ ref('staging_products') }} AS product
ON product.id = stats.id