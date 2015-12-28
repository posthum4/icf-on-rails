module Exceptions

  class MissingSalesForceOpportunityID < StandardError ; end
  class JiraAlreadyExistsError < StandardError ; end
  class OpportunityAlreadyImportedLocallyAndNotForcedError < StandardError ; end
  class InvalidSalesForceOpportunityIDNotStartingWith006 < StandardError ; end
  class InvalidSalesForceOpportunityID < StandardError ; end
  class SalesForceClientError < StandardError ; end
  class MissingJiraKeyError < StandardError ; end
  class MissingEmailIDError < StandardError ; end
  class NoLineItemsFound < StandardError ; end
  class ReceivedCaseIDbutNeedOpportunityIDstartingWith006 < StandardError ; end
  class ReceivedAttachmentIDbutNeedOpportunityIDstartingWith006 < StandardError ; end
  class DealDeskCaseMissing_NeedToSubmitForApprovalBeforeICFCanImport < StandardError ; end
  class CampaignStartDateUnexpectedValue < StandardError ; end
  class ReceivedDateUnexpectedValue < StandardError ; end

  class StandardError
    def to_s
      inspect
    end
  end

end
