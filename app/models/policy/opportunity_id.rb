module Policy

  class OpportunityID

    def self.validate(_string)
      Rails.logger.info "Checking sfdcid for #{_string}"
      fail Exceptions::MissingSalesForceOpportunityID, _string if ( _string.nil? or !_string )
      fail Exceptions::ReceivedCaseIDbutNeedOpportunityID, _string if _string =~ (/5008000000\w{5,8}/)
      fail Exceptions::ReceivedAttachmentIDbutNeedOpportunityID, _string if _string =~ (/00P8000000\w{5,8}/)
      matcher = _string.match(/0068000000\w{5,8}/)
      if matcher.nil?
        fail Exceptions::InvalidSalesForceOpportunityID, _string.to_s
      else
        return matcher[0][0..14]
      end
    end

  end

end