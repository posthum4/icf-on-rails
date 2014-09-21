SalesForce::Client.new()
module SalesForce
  class OpportunitySplit

    def self.all(sfdcid)
      self.find_all_by_OpportunityId(sfdcid).sort_by{|s| s.SplitAmount}.reverse!
    end

    def self.first(sfdcid)
      self.all_owners(sfdcid)[0]
    end

    def self.second(sfdcid)
      self.all_owners(sfdcid)[1]
    end

  end
end
