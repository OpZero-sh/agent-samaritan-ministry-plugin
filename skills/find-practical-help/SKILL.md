---
name: find-practical-help
description: "Find practical help near a US ZIP or city: food pantries and food banks, help with rent, utility, phone, internet or hospital bills, HUD housing counseling, and a short referral plan when someone has several needs at once. Use when someone says things like 'I need food', 'food pantry near 30303', 'I can't pay my electric bill', 'help with rent', 'I got a shutoff notice', 'eviction notice', 'help with a hospital bill', 'who can help me with bills', or 'I need help with food and my power bill'."
---

# Find practical help

Help a person find the organization to call for a concrete need, and tell them what the listing does and does not confirm. People often ask under pressure. Be direct, lead with the phone number or link, and never promise that help is available.

The tools come from this plugin's `ministry` connector. They read public directories for the United States. A search creates no application, appointment, donation or referral.

## First, check for urgency

- Immediate danger or a medical emergency in the US: call 911.
- Thoughts of suicide or a crisis: call or text 988, or chat at https://988lifeline.org/chat/.
- A deadline, such as a shutoff date, an eviction date or no food today, is not an emergency service matter, but it changes the answer. Ask about it and put it in the first line of the next step. Some results name the local 211 line. Pass it on when they do.

## When to use

- Food, a bill (rent, utilities, phone or internet, medical), housing counseling, clothing, employment or health resources.
- Two or more needs at once.

Use another skill for a bill calendar or budget worksheet (`plan-bills-and-budget`), for pastoral or grief support (`find-pastoral-care`), and for a church to attend or serve with (`connect-with-a-ministry`).

## Workflow

1. **Ask only what the search needs.**
   - Which need, if unclear.
   - A US ZIP, or a city and state. ZIP is better because energy assistance is matched by county.
   - For a past due bill: which bill, and whether a shutoff, eviction or payment deadline is coming.
   - Never ask for account numbers, bank statements, exact income, medical details, a Social Security number or identity documents. The provider collects private paperwork, not this conversation.
2. **Pick the tool.** Full argument values are in [references/needs-and-tools.md](references/needs-and-tools.md).
   - One bill: `find_bill_assistance` with `bill_type` (`rent`, `utilities`, `phone_internet`, `medical_bills`, or `bills` when unspecified).
   - One other need: `find_community_help` with `need` (`food`, `housing`, `clothing`, `health`, `employment` and others).
   - Two to four needs: `plan_referrals` with `needs` as a list. It returns up to two local options, a referral contact and questions to confirm for each need.
   - Local Christian ministries and church offices for a need: `find_ministries`.
   - All take `zip_code` or `city` with `state`, plus optional `faith_preference`, `free_only`, `radius_miles` (1 to 50, default 25) and `limit`.
3. **Read `search_status`, `sources` and the counts** before writing. They tell you whether you have local programs, regional referral lines or national guides only. See [references/sources-and-result-fields.md](references/sources-and-result-fields.md).
4. **Open the strongest local match** with `get_organization_details` and the exact `id` (in `plan_referrals` output the field is `organization_id`). Use `get_contact_options` when the person wants only a phone number, an email or a website.
5. **Answer** in the shape below. Offer a `practical_support` introduction draft (`prepare_ministry_introduction`) or a worksheet only if it would help.

## Decision points

- **Faith preference.** `faith_preference` filters the provider's affiliation (`any`, `christian`, `catholic`, `protestant`, `nonreligious`). Set it only when the person asks. Never infer the person's faith. Using the service has no religious requirement.
- **Free only.** `free_only: true` keeps entries documented as free. It can hide useful entries whose cost is simply not stated, so use it when the person asks.
- **County lines.** Energy assistance results name the intake office for the county at the ZIP's reference point. ZIP codes can cross county lines. Tell the person to confirm their county with the office.
- **Food banks versus pantries.** A `food_bank` entry may be a regional warehouse. Its summary says to contact it for pantry or distribution sites before traveling there. Repeat that.

## What the answer looks like

For each option, at most three or four options:

- Name and what it is (food pantry, county energy assistance intake office, HUD listed housing counseling agency, statewide referral line, national guide).
- The contact with its published label, phone first.
- Distance if given. It is a straight line from the ZIP or city reference point.
- Eligibility and cost exactly as recorded. `not_stated` means "the listing does not say, ask".
- Source link and source date.
- Questions to ask on the call. `plan_referrals` supplies them in `questions_to_confirm`.

Then one line, every time: listings can be out of date, and only the provider can confirm hours, funding, eligibility and what to bring. The response says the same in `provider_confirmation`, whose `status` is `unconfirmed`.

## What never to say

- That the person qualifies, will be approved or will receive a specific amount.
- That funds, food or appointments are available today.
- That a listed organization endorses, partners with or was contacted by this service.
- Which bill the person should skip or pay late. Offer the prioritizing bills worksheet instead.

## Empty results and errors

- **`search_status` is `national_only`.** No place was given. Ask for a ZIP and search again, or present the national guides as guides.
- **`search_status` is `curated_only` with no results.** No directory source covers that need at that place. Say so, try a wider `radius_miles` or the broader `need`, then give the response's `next_step`, which points to local 211.
- **A source failed** (`sources[].status` other than `ok`): name it and say the list may be incomplete.
- **`ORGANIZATION_NOT_FOUND`**: the record is gone or the ID is wrong. Search again.
- **Outside the US.** These tools cover the United States. Say so and suggest the person's local social services or emergency number.

## Examples

**"I need a food pantry near 30303. What do I bring?"**
Call `find_community_help` with `need: "food"`, `zip_code: "30303"`, `limit: 5`. Give two or three pantries with phone or site, distance, the eligibility note as written and the source date. On what to bring, say the listing does not say unless it does, and suggest asking when the next distribution is and whether an appointment or documents are needed.

**"I got a shutoff notice for my power. I'm in 30303."**
Ask the shutoff date if not given. Call `find_bill_assistance` with `bill_type: "utilities"`, `zip_code: "30303"`. Lead with the county energy assistance intake office and its listed phone, then the statewide line. Tell them to say the shutoff date when they call and to confirm which office serves their county. Mention the local 211 line if the results name it.

**"I'm behind on rent and we're low on food."**
Call `plan_referrals` with `needs: ["rent", "food"]` and the place. Present one short block per need with the top option, the referral contact and the questions to confirm. Offer the bill calendar or prioritizing bills worksheet at the end.
