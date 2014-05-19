module Exceptions

  class MissingSalesForceOpportunityID < StandardError ; end
  class JiraAlreadyExistsError < StandardError ; end
  class OpportunityAlreadyImportedLocallyAndNotForcedError < StandardError ; end
  class InvalidSalesForceOpportunityID < StandardError ; end
  class SalesForceClientError < StandardError ; end
  class MissingJiraKeyError < StandardError ; end
  class MissingEmailIDError < StandardError ; end
  class NoLineItemsFound < StandardError ; end
  class InvalidSalesForceOpportunityID < StandardError ; end
  class ReceivedCaseIDbutNeedOpportunityID < StandardError ; end
  class ReceivedAttachmentIDbutNeedOpportunityID < StandardError ; end

  class StandardError
    def to_s
      inspect
    end
  end

end
