module Exceptions

  class MissingSalesForceOpportunityID < StandardError ; end
  class JiraAlreadyExistsError < StandardError ; end
  class OpportunityAlreadyImportedLocallyAndNotForcedError < StandardError ; end
  class InvalidSalesForceOpportunityIDNotStartingWith0068 < StandardError ; end
  class SalesForceClientError < StandardError ; end
  class MissingJiraKeyError < StandardError ; end
  class MissingEmailIDError < StandardError ; end
  class NoLineItemsFound < StandardError ; end
  class ReceivedCaseIDbutNeedOpportunityIDstartingWith0068 < StandardError ; end
  class ReceivedAttachmentIDbutNeedOpportunityIDstartingWith0068 < StandardError ; end

  class StandardError
    def to_s
      inspect
    end
  end

end
