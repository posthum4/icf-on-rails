module Exceptions

  class MissingSalesForceOpportunityID < StandardError ; end
  class JiraAlreadyExistsError < StandardError ; end
  class OpportunityAlreadyImportedLocallyAndNotForcedError < StandardError ; end
  class SalesForceClientError < StandardError ; end
  class MissingJiraKeyError < StandardError ; end
  class MissingEmailIDError < StandardError ; end
  class NoLineItemsFound < StandardError ; end
  class InvalidSalesForceOpportunityID < StandardError ; end
end
