# The three worksheets

Field notes for `open_financial_worksheet` and `export_financial_worksheet`. The field IDs below were read from the tool's own output. The tool lists the full set every time it opens a worksheet, so treat its list as the authority if anything here differs.

All three are free worksheets from the Consumer Financial Protection Bureau's "Your Money, Your Goals" toolkit: https://www.consumerfinance.gov/consumer-tools/educator-tools/your-money-your-goals/toolkit/

## Bill calendar (`bill_calendar`)

A one month calendar for writing each bill on the day it is due.

Official blank PDF: https://files.consumerfinance.gov/f/documents/cfpb_your-money-your-goals_bill_calendar_tool_2018-11_ADA.pdf

| Field IDs | Meaning |
| --- | --- |
| `month` | The month, in the form `YYYY-MM` |
| `bill_1` to `bill_8` | A list of up to eight bill names |
| `day_1` to `day_31` | Free text for that day, such as a bill name and amount |

## Prioritizing bills (`bill_priorities`)

A list of common bills in four groups. For each one the person writes an amount and their own priority.

Official blank PDF: https://files.consumerfinance.gov/f/documents/cfpb_your-money-your-goals_prioritizing-bills_tool.pdf

Each fixed item has two fields, `<item>_amount` and `<item>_rank`. Each "other" line has three: `<line>_label`, `<line>_amount` and `<line>_rank`.

| Group | Fixed items | Other lines |
| --- | --- | --- |
| Housing and utilities | `rent` (rent, mortgage or property tax), `energy` (gas or electricity), `water` (water, garbage or sewer) | `other_housing_1` to `other_housing_3` |
| Insurance | `car_insurance`, `health_insurance`, `home_insurance` (renters or home) | `other_insurance_1`, `other_insurance_2` |
| Work and transportation | `transport`, `equipment` (work equipment or uniform), `childcare` | `other_work_1`, `other_work_2` |
| Other obligations | `credit_cards`, `loans`, `child_support`, `court_costs` (court ordered fines or fees) | `other_obligation_1`, `other_obligation_2` |

Examples: `rent_amount`, `rent_rank`, `other_housing_1_label`.

The rank fields are the person's own ranking. Do not fill them from your own judgment.

## Weekly cash flow budget (`cash_flow_budget`)

Income and spending for up to five weeks.

Official blank PDF: https://files.consumerfinance.gov/f/documents/cfpb_your-money-your-goals_cash_flow_budget_tool_2018-11_ADA.pdf

`opening_balance` is the starting balance. Every other field is `week_N_<line>` with N from 1 to 5.

| Kind | Lines |
| --- | --- |
| Income | `pay_1`, `pay_2`, `housing_benefit`, `snap`, `tanf`, `other_income` |
| Spending and saving | `phone`, `debt`, `eating_out`, `childcare`, `entertainment`, `groceries`, `health`, `helping_others`, `housing`, `pets`, `emergency_savings`, `goal_savings`, `transport`, `other_expenses` |

Examples: `week_1_pay_1`, `week_3_groceries`, `week_5_other_expenses`.

## Rules for `values`

- An object that maps a field ID to a string of at most 180 characters or to a number.
- `open_financial_worksheet`: `worksheet` defaults to `bill_calendar` and `values` is optional. Leave `values` out for private entry in the widget.
- `export_financial_worksheet`: `worksheet` and `values` are both required.
- Send only entries the person gave and asked you to include.

## What each tool returns

- `open_financial_worksheet` opens the worksheet widget where the client supports it. Its text reply names the worksheet, says it can be filled in privately in the widget and downloaded as a PDF, links the official blank PDF, shows a fictional example input and lists every field ID with its label.
- `export_financial_worksheet`, by its description, returns the selected worksheet with the supplied entries as a PDF attachment and readable text, and processes the entries in memory. It needs no contact details, account number or upload, and submits no application.

The connector also has a `get_worksheet_template` tool that hands the blank PDF to the widget. It is for the widget's own use. Do not call it for the person.
