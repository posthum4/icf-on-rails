Feature: Automatic jira creation on new order
  In order to launch campaigns faster and with fewer errors
  As an account manager
  I want to see key SalesForce fields in the JIRA description

  Scenario: Existing JIRA
    Given I have an ICF JIRA
    When I look at the description
    Then I will see an amount
    And I will see a currency
    And I will see a campaign start date
    And I will see a campaign end date
    And I will see the SalesForce Opp_Type classification
