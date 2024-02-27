create table test_task
(
    uuid                    uuid not null,
    event_timestamp         timestamp,
    event_name              text,
    product_id              text,
    is_trial                boolean,
    period                  integer,
    trial_period            integer,
    revenue_usd             numeric(1000, 2), -- 2 digits after decimal point
    transaction_id          uuid,
    refunded_transaction_id uuid
);