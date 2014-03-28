# Class representing both a SalesForce Opportunity and
# a JIRA Integrated Campaign Flow case
class Order < ActiveRecord::Base
  attr_accessor :sfdcid,:name,:parent_order,:jira_key

  def opportunity_name
    @name = SalesForce::Opportunity.find(self.sfdcid).Name
  end

  def exists_in_salesforce?
    not SalesForce::Opportunity.find(self.sfdcid).Id.nil?
  end

  def check_for_jira_key
    @jira_key = self.find_jira_key
    save
  end

  def find_jira_key
    r = Jira::Issue.find_by_sfdcid(sfdcid)
    r.size < 1 ? nil : r.first.key
  end

  def import_existing
    importer = Service::OrderImporter.new(self,@sfdcid)
  end

end
