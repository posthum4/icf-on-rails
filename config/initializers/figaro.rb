require 'figaro'
Figaro.require_keys(%w(DATABASEDOTCOM_USERNAME
                       DATABASEDOTCOM_PASSWORD
                       DATABASEDOTCOM_SECURITY_TOKEN
                       DATABASEDOTCOM_CLIENT_ID
                       DATABASEDOTCOM_CLIENT_SECRET
                       JIRA_API
                       JIRA_USER
                       JIRA_PASS
                       JIRA_DEFAULT_USER
                       GMAIL_USER
                       GMAIL_PASS
                       CALLOUT
                       MINMARGIN
                       MAXMARGIN
                       MINCPM
                       MAXCPM
                       DESCR_PREFIX
                       DESCR_SUFFIX
                       EMAIL_BATCH_SIZE
                       ERROR_MONITOR_ADDRESS
                       AM_SUBSTITUTE_ADDRESS))
#Figaro.require_keys(%w(OMNIAUTH_PROVIDER_KEY
                       # OMNIAUTH_PROVIDER_SECRET
                       # DATABASEDOTCOM_HOST))
