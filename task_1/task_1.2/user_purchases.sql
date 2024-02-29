-- with max_timestamp as(
--     select uuid, product_id, max(event_timestamp) as max_timestamp
--     from test_task
--     group by uuid, product_id
--
-- ),

-- current_product_id as (
--     select t.uuid, t.product_id from test_task t
--         inner join max_timestamp m on t.uuid = m.uuid and t.event_timestamp = m.max_timestamp
-- ),

with trial_started as (
    select uuid, product_id, min(event_timestamp) as trial_started_time from test_task
    group by uuid, product_id
),

first_purchase as (
    select uuid, product_id, min(event_timestamp) as first_purchase_time from test_task
        where event_name = 'purchase'
        group by uuid, product_id
),

last_purchase as (
    select t.uuid, t.product_id, max(event_timestamp) as last_purchase_time from test_task t
        where event_name = 'purchase'
        group by t.uuid, t.product_id
),

total_purchases as (
    select uuid, product_id, sum(case when event_name='purchase' then 1 else 0 end) as total_purchases from test_task
        group by uuid, product_id
),

total_revenue as (
    select uuid, product_id, sum(case when event_name='cancellation' then 0 else revenue_usd end) as total_revenue from test_task
        group by uuid, product_id
),

expiration_time as (
    select uuid, product_id, max(event_timestamp) + interval '1' day * period as expiration_time from test_task
        where event_name = 'purchase'
        group by uuid, product_id, period
),

cancelation_time as (
    select uuid, product_id, max(event_timestamp) as cancelation_time from test_task
        where event_name = 'cancellation'
        group by uuid, product_id
),

refund_time as (
    select uuid, product_id, max(event_timestamp) as refund_time from test_task
        where event_name = 'refund'
        group by uuid, product_id
)

select t.uuid, t.product_id, s.trial_started_time,
       f.first_purchase_time, l.last_purchase_time,
       p.total_purchases, r.total_revenue, e.expiration_time,
       c.cancelation_time, ref.refund_time
from (select distinct uuid, product_id from test_task) t
left join trial_started s on t.uuid = s.uuid and t.product_id = s.product_id
left join first_purchase f on t.uuid = f.uuid and t.product_id = f.product_id
left join last_purchase l on t.uuid = l.uuid and t.product_id = l.product_id
left join total_purchases p on t.uuid = p.uuid and p.product_id = t.product_id
left join total_revenue r on t.uuid = r.uuid and t.product_id = r.product_id
left join expiration_time e on t.uuid = e.uuid and t.product_id = e.product_id
left join cancelation_time c on t.uuid = c.uuid and t.product_id = c.product_id
left join refund_time ref on t.uuid = ref.uuid and t.product_id = ref.product_id;
