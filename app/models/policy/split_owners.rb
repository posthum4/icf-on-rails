module Policy
  class SplitOwners

    attr_accessor :splits

    def initialize(sfdcid)
      @sfdcid             = sfdcid
      source              = SalesForce::OpportunitySplit.find_all_by_OpportunityId(sfdcid).sort_by{|o| o.SplitPercentage}.reverse!
      @splits             = Hash.new
      source.each do |split|
        shark = SalesForce::User.find(split.SplitOwnerId).Email.split('@').first || 'robbie'
        @splits[shark] = split.SplitPercentage.to_s+"%"
      end
      @splits
    end
  end

end
