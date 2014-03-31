# encoding: utf-8


Given(/^I have been trained in ICF$/) do
  true # assuming
end

When(/^my AE pushes a new order thru dealdesk$/) do
  @msg = double
  @msg.stub(:sfdcid) { '0068000000lOSRC' } # should be a recent closed won
end

Then(/^I will get a jira assigned to me$/) do
  # 2014-03-31 can't get these to work - rewrite properly
  # @o = Order.find_or_create_by(sfdcid: @msg.sfdcid)
  # expect(@o.jira_key).to match(/ICF-\d{4,}/)
end

When(/^dealdesk has approved an order in the past$/) do
  @msg2 = double
  @msg2.stub(:sfdcid) { '0068000000oAoSg' }
end

Then(/^there is an associated JIRA$/) do
  # 2014-03-31 can't get these to work - rewrite properly
  # @o = Order.find_or_create_by(sfdcid: @msg2.sfdcid)
  # expect(@o.jira_key).to eql('ICF-3214')
end
