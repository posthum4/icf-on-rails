VERSION = '3.1.8'

DESCR_PREFIX=<<-EOP
- ICF v#{VERSION} (2015-10-02): SFDC Account ID now included in description
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
- Central/Canada: Erin Seramur
- West: Youna Kim
- EMEA: Andrew Hammond, Robert Marshall
- Champion-in-chief: Amanda Schneider

# Other functions:

- (Lean) Campaign Managers: Mike Walker
- Ops: Elaina Remin
- Analytics: Therese-Heather Belen
- Reporting: Steve Sammonds
- Sales: your account manager

EOC
