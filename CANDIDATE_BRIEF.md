# Atlas HXM — Senior DevOps Engineer Take-Home Exercise

**Time budget:** 2–3 hours  
**AI tools:** Permitted — we'll ask how you used them in the review session  
**Submission:** Reply to this email with a short writeup (see below) + any modified files as a zip or GitHub link  
**Confidentiality:** Please keep these materials to yourself — we rotate exercises and sharing them disadvantages future candidates.

---

## Context

You're inheriting the `payroll-service` — a Node.js REST API that processes payroll runs for Atlas HXM customers. It's been running in production for about eight months, originally stood up by a backend team that moved on. No dedicated DevOps ownership until now.

The repo contains:

- `Dockerfile` — container build
- `.github/workflows/deploy.yml` — CI/CD pipeline (GitHub Actions, deploys to AWS EKS)
- `k8s/` — Kubernetes deployment and service manifests
- `terraform/` — AWS infrastructure (IAM, security groups, RDS)

The service handles payroll data. Treat it with the sensitivity that implies.

---

## What We're Asking

### Part 1 — Review (written, ~1 hrs)

Review the artifacts as if you were the new owner doing a first-pass audit before the next release. Write your findings as you would in a real context — a Slack message to the team, an internal doc, inline PR comments, whatever format feels natural to you.

For each finding:

- What the issue is
- Why it matters (what actually breaks or risks)
- What you'd do about it, concretely

Not everything is wrong. Part of what we're evaluating is whether you can distinguish a critical issue from a non-issue. You don't need to find everything — we're more interested in how you triage than total count.

### Part 2 — Extend (hands-on, ~1 hr)

Pick **one** of the following and implement it:

**Option A — Staging gate**  
Right now, every push to `main` deploys straight to production. Add a staging environment to the pipeline: changes should deploy to staging first, then require a manual approval before promoting to production. You can modify or rewrite the workflow file; include a brief note on any assumptions you made about what "staging" means in this context.

**Option B — Autoscaling**  
Payroll processing spikes hard on the last business day of each month. Add autoscaling to the Kubernetes deployment. Configure the HPA appropriately and ensure the deployment is set up correctly for autoscaling to function. Include a brief note on what metrics you'd use to determine the right min/max replicas for this workload.

You don't need to test against a live cluster. YAML that's correct-by-inspection is fine.

---

## What to Submit

1. **Your review writeup** (any format)
2. **The modified file(s)** for Part 2
3. **A short note** (3–5 sentences) on how you approached it — what you looked at first, any time trade-offs you made, where you used AI and how

---

## Live Review Session (~35 min)

We'll schedule a follow-up to walk through your work together. Expect questions like:

- Walk us through what you prioritized and why
- What would you fix first if you owned this service starting Monday?
- We'll point at a few specific choices — including things you may not have flagged — and ask for your read

The live session is where most of the signal lives for us. The take-home is the starting point for that conversation.

---

Questions? Reply to this email.