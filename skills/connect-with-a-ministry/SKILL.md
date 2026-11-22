---
name: connect-with-a-ministry
description: "Find a Christian church or congregation to visit, find a place to volunteer or serve through a church, check a church's published contacts and worship details, and draft an editable introduction the person sends themselves. Use when someone says things like 'find a church near me', 'churches in 30303', 'is there a Catholic parish in York', 'where can I volunteer', 'I want to serve with a ministry', 'what time are services', 'how do I contact this church', or 'help me write a note to the church office'."
---

# Connect with a ministry

Help a person find a Christian congregation to visit or a place to serve, show what the listing actually publishes, and prepare a short introduction they can send themselves.

The tools come from this plugin's `ministry` connector. They read public directories. They never call, email, book or register anyone, and they need no account.

## When to use

- The person wants a church, parish or congregation near a place, in the US or in another country.
- The person wants to volunteer or serve through a church or Christian ministry.
- The person picked a church and wants its contacts, worship times, languages or access details.
- The person wants help wording a first message to a church office or a volunteer coordinator.

Use another skill when:

- The person wants pastoral care, grief support or companionship: `find-pastoral-care`.
- The person needs food, help with a bill, housing counseling or several kinds of help at once: `find-practical-help`.
- The person wants a bill calendar or a budget worksheet: `plan-bills-and-budget`.

If the person describes immediate danger or thoughts of suicide, give the contacts under "When it is urgent" before anything else.

## Workflow

1. **Get a place.** Ask only for what the search needs: a US ZIP, a US city and state, or a city or postal code with a country. Never ask for a street address. Ask about tradition only if the person raised it. Do not ask about or guess the person's own faith.
2. **Search.**
   - A church to visit: `find_church_community`.
   - A place to serve: `find_volunteer_opportunities`.
   - Both take the same arguments:

   | Argument | Use |
   | --- | --- |
   | `zip_code` | Five digit US ZIP. |
   | `city` with `state` | US city with a two letter state. |
   | `city` or `postal_code` with `country_code` | Any country, ISO two letter code. Add `region` to narrow a common city name. |
   | `faith_preference` | `any` (default), `christian`, `catholic`, `protestant`, `orthodox`. It filters the congregation's tradition. It says nothing about the person. |
   | `freshness_filter` | `hide_stale` (default), `recently_reviewed` when the person asks for recently checked listings, `include_stale` to widen. |
   | `radius_miles` | 1 to 50, default 25. |
   | `limit` | 1 to 20, default 10. Use 3 to 5 for a first answer. |

3. **Read the counts before you write.** `local_program_count`, `inquiry_contact_count`, `national_referral_count` and `international_referral_count` tell you what kind of entries came back. In a volunteer search, `local_program_count` of 0 means no published local role was found. The churches returned are places to ask, not confirmed openings. See [references/reading-church-results.md](references/reading-church-results.md).
4. **Open the entries the person cares about.** Call `get_church_details` with the exact `id` from the search. For one contact type only, call `get_contact_options` with `organization_id` and `kind` (`phone`, `email`, `website` or `any`). For a volunteer locator or other organization that is not a church, use `get_organization_details`.
5. **Offer an introduction, and prepare it only when the person wants one.** Call `prepare_ministry_introduction` with `organization_id` and a `topic` of `visiting_church` or `volunteering`. Search results often carry an `introduction_action` with the right arguments. Follow [references/introductions.md](references/introductions.md).
6. **Answer** in the shape below.

## What to ask and what not to ask

- Ask for a place if none was given. A search with no place returns directories only.
- Ask which entry to open when several fit. Do not open every result.
- Do not ask for a name, phone number, email, membership history or reason for looking. The tools take none of these.

## Empty results and errors

- **No local entries.** Say so plainly. Offer one wider search (`radius_miles` up to 50). With the person's agreement try `freshness_filter: include_stale` and label those entries as possibly out of date. Then give the directories the response returned (`international_directories`, or entries whose `coverage.type` is `national_referral`).
- **A source did not answer.** If any entry in `sources` has a `status` other than `ok`, name it and say the list may be incomplete.
- **`ORGANIZATION_NOT_FOUND`.** The ID is unknown or the source no longer lists the record. Search again. Never reuse an ID from memory or build one by hand.
- **Null details.** `service_times`, `service_languages` or `accessibility` set to null means unknown. Say "not published" and point to the church's own contact.

## What the answer looks like

For each church or opportunity, in a short block:

- Name, tradition as recorded, and distance. Distances are straight line miles from the ZIP or city reference point, not driving distance.
- Address, worship times and languages if published, otherwise "not published, confirm with the church".
- Accessibility exactly as recorded.
- The contact with its published label, for example "Church phone listed on the map".
- The source link, and one line on freshness, for example "Community mapped record with no dated review".

Close with one next step. State once that listings can be out of date and that the congregation or coordinator confirms times, openings and requirements. Never say a church is welcoming, active, a good fit or accepting volunteers unless the record says so.

## Limits to state honestly

- Congregation data is community mapped from OpenStreetMap, with denominational directories as a fallback. Coverage is uneven. A church missing from the list may still exist.
- A listing shows where a congregation is and how to reach it. It does not confirm that services, groups or volunteer roles are current.
- The service lists Christian congregations and ministries. It has no directory for other faiths.

## When it is urgent

Agent Samaritan is not a counseling or crisis service, and a listed church is not an emergency responder. If the person is in immediate danger in the US, tell them to call 911. For crisis support in the US they can call or text 988 or use the chat at https://988lifeline.org/chat/. Outside the US, tell them to contact local emergency services. Say this once, plainly, then offer to continue.

## Examples

**"Find a church near 30303, Methodist if possible."**
Call `find_church_community` with `zip_code: "30303"`, `faith_preference: "protestant"`, `limit: 5`. The filter has no Methodist value, so pick entries whose `denomination` is `methodist` and say that is how you narrowed it. Give name, distance, address, listed phone or website and the freshness line. Offer to open one for details or to draft a first visit note.

**"Where can I volunteer with a church in Atlanta?"**
Call `find_volunteer_opportunities` with `city: "Atlanta"`, `state: "GA"`. If `local_program_count` is 0, say no published local roles were found. Present the national volunteer finders as finders, and two or three nearby churches as places to ask. Offer a `volunteering` introduction.

**"Is there a Catholic church in York, England?"**
Call `find_church_community` with `city: "York"`, `country_code: "GB"`, `region: "England"`, `faith_preference: "catholic"`. Present mapped places with their OpenStreetMap link and add the Catholic directory from `international_directories` for Mass times.
