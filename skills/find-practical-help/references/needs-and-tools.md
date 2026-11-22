# Needs and tools

Which tool to call for which need, with the exact argument values the `ministry` connector accepts.

## Tool by situation

| Situation | Tool | Key argument |
| --- | --- | --- |
| One bill | `find_bill_assistance` | `bill_type` |
| One practical need | `find_community_help` | `need` |
| Two to four needs | `plan_referrals` | `needs` (list) |
| Local Christian ministries or church offices for a need | `find_ministries` | `need` |
| Full record for one organization | `get_organization_details` | `organization_id` |
| Only phone, email or website | `get_contact_options` | `organization_id`, `kind` |
| A draft note to an organization | `prepare_ministry_introduction` | `organization_id`, `topic: "practical_support"` |

## `bill_type` values for `find_bill_assistance`

| Value | Use for |
| --- | --- |
| `bills` | General or unspecified bill help (default) |
| `rent` | Past due rent |
| `utilities` | Energy bills |
| `phone_internet` | Phone or internet service discounts |
| `medical_bills` | Hospital financial assistance |

## `need` values for `find_community_help` and `find_ministries`

`any` (default), `food`, `housing`, `utilities`, `clothing`, `health`, `employment`, `community`, `pastoral`, `grief`, `companionship`, `bills`, `rent`, `phone_internet`, `medical_bills`, `budgeting`.

`plan_referrals` accepts the same values except `any`, as a list of one to four.

## Shared arguments

| Argument | Notes |
| --- | --- |
| `zip_code` | Five digit US ZIP. Wins over `city` when both are sent. |
| `city` and `state` | `state` is two capital letters and is required with `city`. |
| `faith_preference` | `any` (default), `christian`, `catholic`, `protestant`, `nonreligious`. Provider affiliation only. `christian` includes Catholic and Protestant. |
| `free_only` | Default false. True keeps only entries documented as free. |
| `radius_miles` | 1 to 50, default 25. Straight line from the reference point. Entries matched by documented service area are included separately. |
| `limit` | 1 to 20, default 10. `plan_referrals` has no `limit`. It returns up to two local options per need. |

Location is optional. Without it the tools return national resources only.

## What each need tends to return

Observed in live results for a Georgia ZIP. Coverage varies by place, and statewide lines appear only where the service has reviewed one.

| Need | Typical entries |
| --- | --- |
| `food` | Local pantries and food banks from the Feed America directory |
| `utilities` | The county energy assistance (LIHEAP) intake office, then a statewide energy assistance referral |
| `rent` | A statewide charitable assistance line, a national rent help guide that names 211, and HUD listed housing counseling agencies nearby |
| `budgeting` | Free CFPB worksheets, and with a place, HUD listed counselors that offer financial management counseling |
| `clothing` | May return nothing. The response then suggests a wider radius, broader filters or local 211 |
| `pastoral`, `grief`, `companionship` | Church offices to ask and national group finders. Use the `find-pastoral-care` skill |

## Shape of a `plan_referrals` response

- `referrals`: one item per need, each with:
  - `status` and `sources` for that need
  - `local_options`: up to two programs, each with `organization_id`, `name`, `service_type`, `coverage_basis`, `distance_miles`, one `contact`, `eligibility`, `cost`, `source_urls`
  - `referral`: a regional or statewide contact for that need, or null
  - `inquiry_contact`: an office to ask, or null
  - `questions_to_confirm`: questions for the person to ask the provider
- `financial_worksheets`: the three worksheet openers, ready for `open_financial_worksheet`
- `provider_confirmation`: `status` is `unconfirmed`, with a note that intake, funds and eligibility need confirmation from the provider

Note the field name: `plan_referrals` uses `organization_id` where search results use `id`. Both go into `get_organization_details` as `organization_id`.
