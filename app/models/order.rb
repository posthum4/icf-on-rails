# encoding: utf-8
# == Schema Information
#
# Table name: orders
#
#  sfdcid                                  :string(15)
#  name                                    :string(255)
#  close_date                              :date
#  amount                                  :decimal(, )
#  campaign_start_date                     :date
#  vertical                                :string(255)
#  account                                 :string(255)
#  agency                                  :string(255)
#  advertiser                              :string(255)
#  stage_name                              :string(255)
#  opportunity_owner                       :string(255)
#  opp_type_new                            :string(255)
#  account_manager                         :string(255)
#  sales_region                            :string(255)
#  last_modified_date                      :datetime
#  brand                                   :string(255)
#  campaign_end_date                       :date
#  campaign_objectives                     :text
#  primary_audience_am                     :string(255)
#  secondary_audience_am                   :string(255)
#  hard_constraints_am                     :string(255)
#  is_secondary_audience_a_hard_constraint :string(255)
#  rfp_special_client_requests             :string(255)
#  special_client_requirements             :string(255)
#  special_notes                           :text
#  brand_safety_vendor                     :string(255)
#  type_of_service                         :string(255)
#  brand_safety_restrictions               :string(255)
#  who_is_paying_for_brand_safety          :string(255)
#  client_vendor_pre_existing_relations    :string(255)
#  who_will_implement_adchoices_icon       :string(255)
#  brand_safety_notes                      :string(255)
#  who_will_wrap_the_tags                  :string(255)
#  io_case                                 :string(255)
#  viewability                             :string(255)
#  viewability_metrics                     :string(255)
#  who_is_paying_for_viewability           :string(255)
#  parent_order                            :string(255)
#  created_at                              :datetime
#  updated_at                              :datetime
#

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

  before_validation :import_existing

  # def self.initialize(params=nil)
  #   if ( params.nil? || params['opp_type_new'].nil? )
  #     object=Order.allocate
  #   else
  #     object =  case params['opp_type_new'].partition(': ').last
  #     when 'Renewal', 'Budget Change', 'Cancellation'
  #       InsertionOrderChange.allocate
  #       # when 'Media: Budget Change'
  #       #   Incremental.allocate
  #     else
  #       NewBusiness.allocate
  #     end
  #   end
  #   object.send :initialize, params
  #   object
  # end

  private
  def import_existing
    importer = Service::OrderImporter.new(self,@sfdcid)
  end

end

class InsertionOrderChange < Order ; end
class NewBusiness < Order ; end
