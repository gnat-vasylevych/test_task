with min_timestamp as (
  select
    uuid,
    product_id,
    min(event_timestamp) as min_timestamp
  from
    test_task
  group by
    uuid,
    product_id
),

original_transaction_id as (
  select
    test_task.uuid,
    test_task.product_id,
    transaction_id as original_transaction_id
  from
    test_task
    inner join min_timestamp on test_task.uuid = min_timestamp.uuid
    and test_task.event_timestamp = min_timestamp.min_timestamp
    and test_task.product_id = min_timestamp.product_id
),

cumulative_revenue as (
  select
    transaction_id,
    sum(
      case when event_name = 'cancellation' then 0 else revenue_usd end
    ) over(
      partition by uuid,
      product_id
      order by
        event_timestamp asc
    ) as revenue_usd
  from
    test_task
),

renewal_number as (
  select
    transaction_id,
    sum(
      case when event_name = 'cancellation' then 0 when event_name = 'refund' then 0 else 1 end
    ) over(
      partition by uuid,
      product_id
      order by
        event_timestamp asc
    ) as renewal_num
  from
    test_task
)

select
  t.uuid,
  t.product_id,
  t.transaction_id,
  original_transaction_id,
  r.revenue_usd,
  renewal_num
from
  test_task t
  left join original_transaction_id ot on t.uuid = ot.uuid
  and t.product_id = ot.product_id
  left join cumulative_revenue r on t.transaction_id = r.transaction_id
  left join renewal_number n on t.transaction_id = n.transaction_id
order by
  t.uuid,
  event_timestamp;
