module Exceptions

  class MissingSalesForceOpportunityIDError < StandardError ; end
  class JiraAlreadyExistsError < StandardError ; end
  class OpportunityAlreadyImportedLocallyAndNotForcedError < StandardError ; end
  class SalesForceClientError < StandardError ; end
  class MissingJiraKeyError < StandardError ; end
  class MissingEmailIDError  < StandardError ; end
end
