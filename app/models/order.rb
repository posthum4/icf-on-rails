require 'csv'
# class CreatingDuplicateError < StandardError ; end
# class NonExistingOpportunityError < StandardError ; end
# class NoAttachmentsError < StandardError ; end
class NotYetImplementedError < StandardError ; end
class CreateTestingError < StandardError ; end

# Class representing both a SalesForce Opportunity and
# a JIRA Integrated Campaign Flow case
class Order < ActiveRecord::Base
  validates_presence_of :sfdcid
  validates_uniqueness_of :sfdcid

  has_many :line_items
  references :opportunities

  before_save :exists_in_salesforce?

  def opportunity_name
    SalesForce::Opportunity.find(self.sfdcid).Name
  end

  def opportunity_type
    SalesForce::Opportunity.find(self.sfdcid).Opp_Type_New__c
  end

  private

  def exists_in_salesforce?
    logger.debug "\n\n #{self.to_yaml}\n self = #{self.class}\n#{__FILE__}:#{__LINE__}"
    logger.debug "\n\n #{self.sfdcid.to_yaml}\n self.sfdcid = #{self.sfdcid.class}\n#{__FILE__}:#{__LINE__}"
    SalesForce::Opportunity.find(self.sfdcid)
  end

  def import_existing
    importer = Service::OrderImporter.new(self,@sfdcid)
  end

end

class InsertionOrderChange < Order ; end
class NewBusiness < Order ; end
