Feature: Automatic jira creation on new order
  In order to launch campaigns faster and with fewer errors
  As an account manager
  I want to get automatic jiras for new orders

  Scenario: New campaign launch
    Given I have been trained in ICF
    When my AE pushes a new order thru dealdesk
    Then I will get a jira assigned to me

  Scenario: Existing campaign ready
    Given I have been trained in ICF
    When dealdesk has approved an order in the past
    Then there is an associated JIRA
