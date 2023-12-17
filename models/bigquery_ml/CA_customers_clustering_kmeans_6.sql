{{
    config(
        materialized='model',
        ml_config={
            'model_type': 'KMEANS',
            'kmeans_init_method': 'KMEANS++',
            'num_clusters': 6
        },
        post_hook="{{ dbt_ml.model_audit() }}"
    )
}}

SELECT
    average_order_price,
    average_product_price,
    number_of_orders,
    mean_hours_between_orders,
    peak_activity_hour,
    favourite_product_category
FROM {{ ref('CA_aggregate_customer_analysis_data') }}
