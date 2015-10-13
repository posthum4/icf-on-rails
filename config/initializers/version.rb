VERSION = '3.1.9'

DESCR_PREFIX=<<-EOP
- ICF v#{VERSION} (2015-10-12): Migrated ICF to new server with higher reliability/fewer outages!
- Attachment names now sanitized and should be uploaded properly (unicode chars, slashes, etc. removed)
- Remember always to convert Renewals and Revisions to "IO Change" subtasks before
  working on them!
EOP

DESCR_SUFFIX=<<-EOS
- See all your ICF campaigns on the Kanban board: <http://is.gd/awF7Cc>
- See the ICF user group for docs and any questions: <http://is.gd/cbVtcu>
EOS

CHAMPIONS=<<-EOC

# Account Managers:

- East: Kristy Bendetti
- Central/Canada: Kelsey Julius
- West: Youna Kim
- EMEA: Andrew Hammond, Robert Marshall
- Champion-in-chief: Amanda Schneider

# Other functions:

- (Lean) Campaign Managers: Jennifer Lin
- Ops: Elaina Remin
- Analytics: Therese-Heather Belen
- Reporting: Steve Sammonds
- ICF import bugs: Dan Kras
- Sales: your account manager

EOC
