module Policy

  class OpportunityID

    def self.validate(_string)
      Rails.logger.info "Checking sfdcid for #{_string}"
      fail Exceptions::MissingSalesForceOpportunityID, _string if ( _string.nil? or !_string )
      fail Exceptions::ReceivedCaseIDbutNeedOpportunityIDstartingWith006, _string if _string =~  (/500\w{12,15}/)
      fail Exceptions::ReceivedAttachmentIDbutNeedOpportunityIDstartingWith006, _string if _string =~ (/00P\w{12,15}/)
      matcher = _string.match(/006\w{12,15}/)
      if matcher.nil?
        fail Exceptions::InvalidSalesForceOpportunityID, _string.to_s
      else
        return matcher[0][0..14]
      end
    end

  end

end
