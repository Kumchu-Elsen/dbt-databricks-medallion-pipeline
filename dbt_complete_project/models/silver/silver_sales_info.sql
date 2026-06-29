with sales as (

    select
        sales_id,
        gross_amount,
        {{ multiply('unit_price', 'quantity') }} as calculated_gross_amount,
        payment_method,
        product_sk,
        customer_sk   
    from 
        {{ ref('bronze_sales') }}
),

products as (
    select
        product_sk,
        category
    from 
        {{ ref('bronze_product') }}
),

customer as (
    select
        customer_sk,
        gender
    from 
        {{ ref('bronze_customer') }}
),

joined_query as (
    select
        sales.sales_id,
        sales.gross_amount,
        sales.payment_method,
        products.category,
        customer.gender
    from
        sales
    join 
        products on sales.product_sk = products.product_sk
    join 
        customer on sales.customer_sk = customer.customer_sk
)

select 
    category,
    gender,
    sum(gross_amount) as total_sales
FROM 
    joined_query
group by 
    category,
    gender
order by 
    total_sales desc