Test task for Data Analyst position at Kiss My Apps
---

# Task 1

For the first task I use PostgreSQL syntax. 

Also I insert two additional rows to the existing user 

_00cb6d7e-d276-4b39-8699-4b4ad608ea06_ 

to show case that SQL works correctly if a user has several subscriptions.


Few notes on how I calculate certain columns:

# todo add elaborate documentation
- revenue_usd - rows with event_name 'cancellation' does not add to total revenue. I calculate this column 
as sum of all previous transactions.
- renewal_number - rows with event_name 'refund' or 'cancellation' are not counted as subscription renewal


# Task 2
I assume that the user can only have one active subscription at a time.

Edge case to consider
User subscription journey

sub1_plan [date1, date2]

sub2_plan [date2, date3]

again sub1_plan [date3, date4]