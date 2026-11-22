---
name: find-pastoral-care
description: "Find Christian pastoral care, lay care, grief support or companionship near a place, and show who to contact. Use when someone says things like 'I need to talk to a pastor', 'is there a care team near me', 'grief support group after my mother died', 'someone to visit my dad who lives alone', 'I want someone to pray with me', or 'who handles pastoral care at this church'. Lists published contacts and national group finders. It is not counseling, therapy or a crisis line."
---

# Find pastoral care

Help a person find a human being to talk to through a church or Christian ministry: a pastoral or lay care contact, a grief group, or companionship for someone isolated. People often ask in a hard moment. Be plain, calm and brief. Find the contact and say honestly what is and is not confirmed.

The tools come from this plugin's `ministry` connector. They read public directories. They never contact anyone.

## First, check for urgency

If the person says they are in danger, may hurt themselves or someone else, or cannot stay safe, do this before any search:

- In the US, immediate danger: call 911.
- In the US, crisis support at any hour: call or text 988, or chat at https://988lifeline.org/chat/.
- Outside the US: contact local emergency services.

Say it once, without alarm, and stay with the request. Then offer to keep looking for ongoing support. A church office is not an emergency responder and may not answer today. See [references/care-boundaries.md](references/care-boundaries.md).

## When to use

- Pastoral care, lay care, prayer support or a care team.
- Grief support after a death.
- Companionship or visits for someone lonely or homebound.
- Finding who handles care at a church the person already named.

Use another skill for a church to attend or a place to volunteer (`connect-with-a-ministry`), and for food, bills or housing (`find-practical-help`). When a person needs care and practical help together, `plan_referrals` in `find-practical-help` accepts `pastoral`, `grief` and `companionship` beside practical needs.

## Workflow

1. **Listen for the need and the place.** You need a US ZIP or a city and state. Without a place the search returns national finders only. Do not ask what happened, who died, what the person believes or whether they attend church. If they volunteer details, use them only to pick the `need`.
2. **Search with `find_pastoral_support`.**

   | Argument | Use |
   | --- | --- |
   | `need` | `pastoral`, `grief` or `companionship`. Leave as `any` when unclear. |
   | `zip_code`, or `city` with `state` | US place. ZIP wins if both are sent. |
   | `faith_preference` | `any` (default), `christian`, `catholic`, `protestant`, `nonreligious`. It filters the provider's affiliation. It is never a statement about the person. Set it only when the person asks. |
   | `free_only` | True keeps only entries documented as free. |
   | `radius_miles` | 1 to 50, default 25. |
   | `limit` | 1 to 20. Use 3 to 5. |

   `find_ministries` takes the same arguments and also returns local Christian ministries and congregation offices. Use it when the person asks for ministries in general or when the first search is thin.
3. **Sort what came back into three groups** using `kind`, `coverage.type` and the counts:
   - **Documented local programs** (`local_program_count` above 0): a named care or grief program with its own record.
   - **Offices to ask** (`kind` is `pastoral_inquiry`): a nearby congregation with a published phone or website. Its presence does not establish a grief group or a care program.
   - **National finders** (`coverage.type` is `national_referral`): a group locator such as a grief group finder. It is not a nearby provider.
4. **Open one or two entries.** `get_organization_details` with the exact `id` returns limitations, cost, contacts and review dates. `get_contact_options` with `kind` returns only phone, email or website.
5. **Offer an introduction.** If the person wants help reaching out, call `prepare_ministry_introduction` with `organization_id` and `topic` set to `pastoral`, `grief` or `companionship`. Present the result as an unsent draft with the contact's published label. The person sends it or calls themselves.

## What the answer looks like

- Lead with the most direct human contact, labelled exactly as published ("Church phone listed on the map", not "pastoral care line").
- Keep the three groups separate and say which group each entry is in.
- For each entry: name, distance (straight line), what is documented, cost as recorded (`free`, `varies` or `not_stated`), the source link and the review date if there is one.
- One closing line: listings can be out of date, so the office or group leader confirms availability, times and any fee.

Keep it short. Three good options beat ten.

## What never to say

- Do not diagnose or name a condition. Do not tell the person what they are going through.
- Do not promise that someone will call back, that a group has space, or that care will help.
- Do not call lay or pastoral care counseling or therapy. If the person asks for a licensed counselor, say this service does not list licensed clinicians and that their doctor, insurer or https://findtreatment.gov/ can help them find one.
- Do not offer theological advice or steer the person toward or away from faith. Follow their lead.

## Empty results and errors

- **Only offices and finders.** This is the usual case. Say no documented local program was found, then give the offices as places to ask and the finders as searches to run.
- **Nothing local.** Widen `radius_miles` once, try `find_ministries`, then give the national finders.
- **A source did not answer** (`sources[].status` other than `ok`): name it and say the list may be incomplete.
- **`ORGANIZATION_NOT_FOUND`**: search again and use the fresh `id`.

## Limits to state honestly

- US only for this search. Local entries are mostly mapped congregations, not verified care programs.
- The service is a Christian ministry directory. `nonreligious` narrows to providers recorded as nonreligious, and there may be few or none.
- Nothing here checks live availability.

## Examples

**"My mom died last month. Is there a grief group near 30303?"**
Acknowledge the loss in one sentence. Call `find_pastoral_support` with `need: "grief"`, `zip_code: "30303"`, `limit: 5`. Present any documented program first, then the national grief group finder with its note that some groups charge for materials, then two nearby church offices as places to ask. Offer a `grief` introduction draft.

**"Can someone from a church visit my father? He lives alone in Marietta, Georgia."**
Call `find_pastoral_support` with `need: "companionship"`, `city: "Marietta"`, `state: "GA"`. Present nearby offices as places to ask about visiting ministries. Do not ask for the father's name, address or health details. Offer a `companionship` draft the person can send.

**"I can't do this anymore."**
Do not search yet. Give 988 and 911 as above, say you are glad they said something, and ask if they are safe right now. Offer to look for ongoing pastoral support once they have reached someone.
