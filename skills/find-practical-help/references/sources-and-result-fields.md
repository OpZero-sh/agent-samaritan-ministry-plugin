# Sources and result fields

How to read a response from `find_community_help`, `find_bill_assistance`, `find_ministries` and `get_organization_details`. Every value below was observed in the service's own output. Treat an unfamiliar value as unknown and report it as written.

## Sources named in results

| Source name in `sources` | What it supplies | Publisher in `provenance` |
| --- | --- | --- |
| Feed America | Food pantries and food banks | Feed America, with a CC BY 4.0 license link and an attribution line |
| HUD housing counseling | Housing counseling agencies and the services each lists | U.S. Department of Housing and Urban Development |
| HHS LIHEAP Clearinghouse county intake | The energy assistance intake office for a county | HHS LIHEAP Clearinghouse |
| OpenStreetMap congregation contacts | Church offices with a published phone or website | OpenStreetMap contributors |
| (no source entry) | Statewide lines, national guides and worksheets reviewed by hand | Agent Samaritan |

Each `sources` item has a `status` and a `matching_candidates` count. A status other than `ok` means that source did not answer and the list may be incomplete.

When an entry carries `provenance.attribution`, show it once with the list. Always keep the `source_urls` link.

## `search_status`

| Value | Meaning | What to do |
| --- | --- | --- |
| `searched` | A place was resolved and directory sources were queried | Present results |
| `national_only` | No place was supplied | Ask for a ZIP, or present national guides as guides |
| `curated_only` | No directory source covers this need here. Only hand reviewed entries were checked | If empty, say so and use `next_step` |

`location.status` is `resolved` or `not_supplied`. `location_interpretation` explains that distances are straight line miles from the ZIP or city reference point.

## Counts

`local_match_count`, `local_program_count`, `regional_referral_count`, `inquiry_contact_count`, `national_referral_count`, `total_matches`. Use them to say honestly what kind of list this is, for example "two local pantries and five national resources".

## Kinds of entry

| `kind` | Example `service_type` | Describe as |
| --- | --- | --- |
| `local_organization` | `food_pantry`, `food_bank` | A local site listed by the directory |
| `housing_counseling_agency` | `housing_counseling` | A HUD listed counseling office. Not a source of rent money or shelter beds |
| `energy_assistance_office` | `energy_assistance_intake` | The LIHEAP intake office listed for the county |
| `referral_service` | | A regional or statewide line that routes to a local group |
| `information_resource` | | A national guide or worksheet. Not a provider |
| `directory` | | A locator to search |
| `pastoral_inquiry` | `congregation` | A church office to ask. No program is confirmed |

`coverage.type` is `local`, `regional_referral` or `national_referral`. `coverage.note` often carries the caveat to repeat, for example that the provider sets its own service boundary, or that a county office should be confirmed because ZIP codes can cross county lines.

## Fields to repeat exactly

- `contact_options[].label`: the published label, for example `Directory-listed phone`, `LIHEAP-listed phone` or `ZIP-routed assistance line`. Repeat labels exactly as returned. Never rename a general line as an intake worker or a named person.
- `eligibility`: published notes, not a decision. "Directory notes: referral" means the directory says a referral may be needed. Ask the provider.
- `cost.status`: `free`, `varies` or `not_stated`, with a `note`.
- `availability` and `accessibility`: usually say to confirm with the provider.
- `published_services` on housing counseling entries: the list of services HUD records for that agency.
- `counseling_methods` on housing counseling entries, for example phone counseling.

## Dates and verification

- `source_checked_at` or `provenance.source_record_date`: the date of the source record or of the manual review. It is not the date anyone confirmed hours or funding.
- `freshness.status` of `recently_reviewed` with `checked_live` false: a person reviewed the source page recently. Hours and intake still need confirmation.
- `provenance.verification_status` values seen: `verified` and `unverified` (the food directory's own flag), `listed_by_HUD`, `listed_for_county`, `recently_reviewed`, `community_mapped`.
- `verification`: a sentence for people. A typical one says the record is not an endorsement, an eligibility decision or a live capacity check.
- `provider_confirmation.status`: `unconfirmed`. Nothing in a search response is confirmed by the provider.

If two numbers or labels in one record look inconsistent, show them as listed, say they come from the directory, and tell the person to confirm on the agency's own website from `source_urls`.

## Extras in the response

- `financial_worksheets`: openers for the three CFPB worksheets. Offer them. See the `plan-bills-and-budget` skill.
- `next_step`: the service's suggested closing line.
- `access_policy`: the service is free to use, and each outside program sets its own requirements and fees.
- `support_notice` and `crisis_resources`: the service's limits and US urgent contacts (911, 988, FindTreatment.gov, the SAMHSA National Helpline). Surface them when relevant.

## Errors

`get_organization_details` and `get_contact_options` return `ORGANIZATION_NOT_FOUND` when an ID is unknown or the source no longer lists the record. Search again for a current ID.
