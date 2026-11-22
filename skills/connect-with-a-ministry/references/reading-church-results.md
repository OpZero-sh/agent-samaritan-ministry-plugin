# Reading church and volunteer results

Field notes for `find_church_community`, `find_volunteer_opportunities` and `get_church_details`. Every value below was observed in the service's own output. The service can add values, so treat an unfamiliar value as unknown and report it as written.

## Where the data comes from

- **US congregations** come from a source the response names "OpenStreetMap congregation contacts". Each record carries `provenance.publisher` "OpenStreetMap contributors", an attribution string and the ODbL license link.
- **Congregations in other countries** come from OpenStreetMap through a place name lookup (the response names Photon and an Esri hosted OpenStreetMap layer). The response also returns `international_directories`: denominational finders such as a Catholic Mass times directory, an Orthodox directory, an Adventist directory and the Anglican Communion member list.
- **Volunteer finders** are entries reviewed by Agent Samaritan (`provenance.publisher` "Agent Samaritan") that point to a national organization's own volunteer page.
- **US locations** resolve to a ZIP or city reference point. The response names its location sources in `location.source_url`.

Keep the `source_urls` link with every entry you show. When an entry has `provenance.attribution`, include it once near the list.

## Kinds of entry

| `kind` | `service_type` | What it is | How to describe it |
| --- | --- | --- | --- |
| `pastoral_inquiry` | `congregation` | A mapped US congregation with a published phone or website. | A church to contact or visit. Programs are unconfirmed. |
| `congregation` | `congregation` | A mapped place of worship outside the US. | A named place of worship. Check its own information before visiting. |
| `directory` | `volunteer_locator` | A national volunteer finder. `mission_only` is true. | A finder to search, not a local opening. |
| `church_locator` | `church_locator` | A denominational directory in `international_directories`. | A directory to search for a parish or congregation. |

`coverage.type` says how local the entry is: `local`, `national_referral` or `international_referral`. `coverage.match_basis` of `inquiry_contact` or `mapped_location` means the entry matched by map position, not by a documented service area.

## Counts at the top of the response

- `local_match_count`: entries near the place.
- `local_program_count`: entries with a documented local program. Zero is common. It means the search found places to ask, not confirmed programs or roles.
- `inquiry_contact_count`: congregations with a published contact.
- `national_referral_count` and `international_referral_count`: finders and directories.
- `total_matches`: everything, before `limit`.

## Church details

`church_profile` holds `denomination`, `service_times`, `service_languages` and `accessibility`. Null means the source does not say. It does not mean "none". Tell the person the detail is not published and that the church confirms it.

`contact_options` is a list. Each item has `kind` (`phone`, `email` or `website`), a `label` and a `value` or `url`. Repeat the label as written, for example "Church phone listed on the map" or "Church website listed on the map". When `get_contact_options` has nothing of the requested kind it returns an empty `contacts` list and a message saying the source lists no contact of that type. Say exactly that.

`distance_miles` is a straight line from the ZIP or city reference point. `get_church_details` returns it as null because it has no search origin.

## Freshness and verification

- `listing_freshness.status` is `unknown` when no dated review exists, and `recently_reviewed` when the published source was reviewed within 30 days. The field describes the source record. It does not confirm that worship services or volunteer openings are current.
- `provenance.verification_status` values seen: `community_mapped`, `recently_reviewed`, `official_directory`.
- `verification` is a sentence written for people. Follow it closely. For a mapped congregation it says the record is community maintained and that the contact and service information have not been verified with the congregation.
- `freshness_filter` on the search controls what is returned. `hide_stale` keeps recently reviewed and undated listings. `recently_reviewed` requires a dated review within 30 days. `include_stale` adds flagged or overdue records. Every mode leaves out listings confirmed inactive.

## Suggested next calls in the response

- `introduction_action` on a result gives the tool and arguments for a draft introduction to that congregation.
- `follow_up_action` at the top suggests the matching search in the other tool, for example a volunteer search after a church search.

Use these as given. Offer them to the person. Do not run them unasked.

## Other fields worth repeating

- `cost.status`: `not_stated`, `free` or `varies`, with a `note`. Repeat the note when cost matters.
- `eligibility`, `availability`, `accessibility`: plain sentences. They usually say the detail is unknown and who confirms it.
- `next_step`: the service's suggested closing line.
- `support_notice` and `crisis_resources`: the service's own statement of its limits and urgent contacts. Keep them available. Surface them when what the person says makes them relevant, not in every reply.
