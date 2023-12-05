{% snapshot orders_snapshot %}

{{
    config(
        target_database='nettikauppasimulaattori',
        target_schema='store_operational',
        unique_key='id',
    
        strategy='timestamp',
        updated_at='last_modified'
    )
}}

SELECT
    *
FROM {{ source("bigquery_nettikauppasimulaattori", "orders") }}

{% endsnapshot %}