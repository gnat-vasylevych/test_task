Test task for Data Analyst position at Kiss My Apps
---

# Task 1

For the first task I use PostgreSQL syntax. 

Also I insert two additional rows to the existing user 

_00cb6d7e-d276-4b39-8699-4b4ad608ea06_ 

to show case that SQL works correctly if a user has several subscriptions.


Few notes on how I calculate certain columns:

- revenue_usd - rows with event_name 'cancellation' does not add to revenue.
- renewal_number - rows with event_name 'refund' or 'cancellation' do not count subscription renewal


