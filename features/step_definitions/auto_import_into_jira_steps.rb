# encoding: utf-8

Given(/^I have been trained in ICF$/) do
  true # assuming
end

When(/^my AE pushes a new order thru dealdesk$/) do
  @msg = double
  @msg.stub(:sfdcid) { '0068000000frQyY' }
end

Then(/^I will get a jira assigned to me$/) do
  @o = Order.find(@msg.sfdcid)
  @o.find_or_create_jira.jira_key.should match(/ICF-\d{4,}/)
end

When(/^dealdesk has approved an order in the past$/) do
  @msg2 = double
  @msg2.stub(:sfdcid) { '0068000000oAoSg' }
end

Then(/^there is an associated JIRA$/) do
  Order.find(@msg2.sfdcid).jira_key.should match('ICF-3214')
end
