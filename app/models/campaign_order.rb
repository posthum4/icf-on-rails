class CampaignOrder < ActiveRecord::Base

  validates_presence_of :sfdcid
  validates_uniqueness_of :sfdcid

  has_many :line_items
  has_many :attachments

  register_currency :usd

  monetize :budget_cents, with_model_currency: :budget_currency, :allow_nil => true

  def update_io_case
    # also moved this to to opportunity_to_campaign_order importer, may no
    # longer be necessary here
    if self.io_case.nil?
      guesscase = SalesForce::Case.find_by_Opportunity__c(sfdcid)['Id']
      # TODO 2015-03-26 change to its own object to encapsulate error checking
      unless guesscase.nil?
        self.io_case = guesscase
        self.save!
      end
    end
    self.io_case
  end

  def parent_id
  end
end
