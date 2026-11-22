---
name: connect-with-a-ministry
description: "Use when someone wants to find a church, volunteer opportunity, pastoral or grief support, or an editable introduction to a care team."
---

1. For church discovery use `find_church_community`; for serving opportunities use `find_volunteer_opportunities`. Use `find_pastoral_support` for lay care, grief support or companionship. Search by the approximate location and stated preferences. Use the returned freshness and verification information when choosing entries.
2. Follow the best match with `get_church_details` or `get_organization_details` and `get_contact_options`. Preserve the organization ID and published labels. If only a general office is documented, identify it as an office that may route the request. Keep national locators distinct from a specific local program. Show source links and any known fee or service-area limit.
3. When the person asks for an introduction, call `prepare_ministry_introduction` with that organization ID and the matching topic. Use the resulting editable draft and contact labels; the form accepts no requester identity. The person can send the draft themselves. Describe it as a draft and never report a call, booking or delivery on its basis.
