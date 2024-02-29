Test task for Data Analyst position at Kiss My Apps
---

# Task 1.1

For the first task I use PostgreSQL syntax. 

Also I insert two additional rows to the existing user 

_00cb6d7e-d276-4b39-8699-4b4ad608ea06_ 

to show case that SQL works correctly if a user has several subscriptions.


Few notes on how I calculate certain columns:

# todo add elaborate documentation
- revenue_usd - I calculate this column as sum of all previous transactions. 
Rows with event_name 'cancellation' does not add to total revenue.
- renewal_number - rows with event_name 'refund' or 'cancellation' are not counted as subscription renewal


# Task 1.2
I assume that the user can only have one active subscription at a time.

I create aggregated info about every user with respect to every subscription a user ever had.

So to determine current user subscription, we should look at the latest transaction.

To determine first trial purchase *trial_started_time*, I look 
for the transaction with the earliest timestamp instead of searching
by the *trial* event_name, because earliest timestamp logic is more reliable.


