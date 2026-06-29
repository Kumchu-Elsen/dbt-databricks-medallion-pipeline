SELECT

    {{ multiply('unit_price', 'quantity') }} as calculated_gross_amount

FROM {{ ref('bronze_sales') }}
