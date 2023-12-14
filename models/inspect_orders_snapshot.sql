SELECT
    *
FROM {{ ref('orders_snapshot') }}

WHERE id = 866971411
--WHERE dbt_updated_at IS NOT NULL AND status = 1
-- WHERE dbt_updated_at IS NOT NULL AND dbt_valid_to IS NOT NULL
