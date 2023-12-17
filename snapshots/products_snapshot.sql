{% snapshot orders_snapshot %}

{{
    config(
        target_database='nettikauppasimulaattori',
        target_schema='store_analysis_dbt',
        unique_key='id',
    
        strategy='timestamp',
        updated_at='last_modified'
    )
}}

SELECT
    *
FROM {{ source("nettikauppasimulaattori_data_warehouse", "import_products") }}

{% endsnapshot %}