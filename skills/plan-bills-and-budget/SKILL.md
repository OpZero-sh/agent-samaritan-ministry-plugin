---
name: plan-bills-and-budget
description: "Open or fill in a free CFPB worksheet: a bill calendar for due dates, a prioritizing bills worksheet for when money is short, or a weekly cash flow budget. Use when someone says things like 'help me make a budget', 'I can't keep track of when my bills are due', 'which bills should I pay first', 'bill calendar', 'cash flow worksheet', 'budget worksheet I can print', or asks to turn the bills they listed into a PDF."
---

# Plan bills and a budget

Help a person lay out their bills on one of three free worksheets published by the Consumer Financial Protection Bureau (CFPB). The person can fill the worksheet in privately inside a widget, or tell you the entries they choose to share and get a filled PDF back.

The tools come from this plugin's `ministry` connector. They need no ZIP, no account and no sign in. Nothing is submitted to a creditor, an agency or the CFPB.

## When to use

- The person wants to see when bills are due across a month: `bill_calendar`.
- Money is short and the person wants to sort which bills matter most: `bill_priorities`.
- The person wants to plan income and spending week by week: `cash_flow_budget`.

Use `find-practical-help` instead when the person needs someone to help pay a bill, a food pantry or a housing counselor. The two skills work well together: find help first when there is a deadline, then offer a worksheet.

## Workflow

1. **Pick the worksheet.** If the person did not name one, ask one question: do they want due dates on a calendar, help ranking bills, or a weekly budget.
2. **Open it blank by default.** Call `open_financial_worksheet` with `worksheet` set to `bill_calendar`, `bill_priorities` or `cash_flow_budget`, and no `values`. In a client that shows widgets, the person types their entries privately in the widget and selects Download PDF. Tell them that, and that you do not see what they type there.
3. **Prefill only what the person chose to share.** If they already told you specific bills, dates or amounts and ask you to put them in, pass them in `values` using the field IDs the tool returns. Field patterns are in [references/worksheets.md](references/worksheets.md). Do not invent amounts, estimate income or fill a field the person did not give you.
4. **Text only clients.** If no widget appears, the tool's text reply lists every field ID and a link to the official blank PDF. Offer two paths: the person downloads the blank PDF and fills it in themselves, or they tell you entries and you call `export_financial_worksheet` with `worksheet` and `values`. The export returns a filled PDF attachment and readable text.
5. **Confirm before export.** Read the entries back in a short list and ask if they are right. Then call `export_financial_worksheet` once.

## What to ask and what not to ask

- Ask for bill names, due days and amounts only as far as the person wants to share them. Round numbers are fine.
- Never ask for account numbers, card numbers, bank logins, a Social Security number, an employer's name or an exact income figure. No worksheet field needs them.
- Do not press for more detail than the person offers. A half filled worksheet is still useful.

## What you may and may not say about the numbers

- You may add up figures the person gave, point out two bills due the same week, and explain what a worksheet section is for.
- You may not tell the person which bill to skip, promise that a plan will work, or give legal, tax, credit or investment advice.
- On the prioritizing bills worksheet the rank fields hold the person's own ranking. Ask them how they want to rank each item. If they ask what to pay first, say the worksheet is built to help them decide, mention any deadline they told you about, and offer to look for a HUD listed housing counselor or bill assistance through `find-practical-help`.

## Handling values

- `values` is an object of field ID to a string (up to 180 characters) or a number.
- Use the field IDs exactly as the tool lists them. A wrong ID is the most likely cause of an entry not appearing.
- For the bill calendar, `month` uses the form `YYYY-MM` and each `day_N` field holds free text such as a bill name and amount.
- Keep entries short so they fit the printed boxes.

## Errors and gaps

- **No widget and no attachment support.** Give the official blank PDF link from the tool's reply and offer the entries as a plain text list the person can copy.
- **An entry is missing from the PDF.** Check the field ID against the list from `open_financial_worksheet` and export again.
- **The person wants a different kind of worksheet.** Only these three are available. The search result named "CFPB bill calendar and cash flow worksheets" in `find_community_help` (need `budgeting`) links to the wider CFPB toolkit.

## Limits to state honestly

- The worksheets are the CFPB's public tools. This plugin does not provide financial counseling.
- Entries sent in `values` go to the Agent Samaritan service to build the worksheet. The tool description says the export processes them in memory. The service describes widget entry as private editing by the person. Say this if the person asks where their numbers go.

## If money stress turns into a crisis

If the person says they cannot go on or may hurt themselves, pause the worksheet. In the US they can call or text 988, or call 911 in immediate danger. Then offer to continue when they are ready.

## Examples

**"I keep missing due dates. Can you help?"**
Call `open_financial_worksheet` with `worksheet: "bill_calendar"`. Tell the person they can type each bill on its due day in the widget and download the PDF, or list bills here if they would like you to place them.

**"Put these on a calendar for December: rent 925 on the 1st, electric about 65 on the 18th."**
Confirm the two entries. Call `export_financial_worksheet` with `worksheet: "bill_calendar"` and `values` of `{"month": "YYYY-12", "bill_1": "Rent", "bill_2": "Electricity", "day_1": "Rent $925", "day_18": "Electricity $65"}`, with the real year in place of `YYYY`. Return the PDF and the text summary.

**"I can't pay everything this month. What do I pay first?"**
Do not rank for them. Open `bill_priorities`, explain that it groups housing and utilities, insurance, work and transportation, and other obligations, and that they set the priority for each. Ask if any bill has a shutoff or eviction date and offer to search for assistance with that bill.
