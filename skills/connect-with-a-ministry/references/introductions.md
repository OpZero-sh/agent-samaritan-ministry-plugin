# Preparing an introduction

`prepare_ministry_introduction` returns the organization's published contact labels and an editable introduction. It sends nothing. The person decides whether to call or to send their own email.

## Arguments

| Argument | Notes |
| --- | --- |
| `organization_id` | Required. The exact `id` from a search result. |
| `topic` | `pastoral` (default), `grief`, `companionship`, `practical_support`, `visiting_church`, `volunteering`. |

The tool takes no name, phone number, email or personal story. Do not collect them in order to call it.

## Choosing a topic

- First visit to a church, worship times, small groups: `visiting_church`.
- Serving or volunteering: `volunteering`.
- Asking a care team or office for pastoral care: `pastoral`.
- Grief support: `grief`.
- Visits or company for someone isolated: `companionship`.
- Food, bills or another practical need: `practical_support`.

If two topics fit, ask the person which one the note should be about.

## How to present the draft

1. Call it a draft. Say that nothing has been sent, no call has been placed and nothing is booked.
2. Show the contact with its published label. A general church office stays "church office". A named care contact stays a care contact. Never upgrade an office line into a care team.
3. Show the draft text as returned, ready to copy. Offer to adjust the wording.
4. Tell the person they can add their own name and details before sending, and that they choose what to share.
5. If the organization lists only a phone number, offer a short version of the draft as talking points for a call.

## Editing with the person

- Add personal details only when the person gives them and asks for them to be included.
- Keep requests modest and concrete, for example asking when to visit or who coordinates volunteers.
- Do not promise on the organization's behalf. The draft asks. It does not confirm a place, a visit or a role.

## The plugin's reminder

In Claude Code this plugin runs a short local script after `prepare_ministry_introduction` returns. It adds a reminder to the conversation: present the introduction as an unsent draft, keep the published contact labels, and do not ask for identity details in order to show it. The script reads nothing and sends nothing.

## What was and was not verified

The arguments and behavior above come from the tool's published schema and description. The draft wording itself is produced by the service at call time, so describe what it returned rather than what you expect it to say.
