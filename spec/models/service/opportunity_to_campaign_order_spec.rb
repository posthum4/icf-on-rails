require 'rails_helper'

##########################################################
#  TODO once configured to Rocket Fuel holidays, reconfigure 'holiday' tests to appropriate values
##########################################################

#describe Service::Importer::OpportunityToCampaignOrder do
RSpec.describe Service::Importer::OpportunityToCampaignOrder, type: :model do

	describe ".calculate_internal_due_date" do

		###################################################
		# 			unexpected inputs
		###################################################

		context "ERROR: campaign_start_date is null" do
			before do 
				#@received_date = DateTime.parse("October 19th, 2015, 12:00 pm -500")
				@received_date = Time.new(2015, 10, 19, 12, 0, 0, "-05:00")
				@campaign_start_date = nil
			end

			it "raises CampaignStartDateUnexpectedValue" do
				expect{ Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date) }.to raise_error(Exceptions::CampaignStartDateUnexpectedValue)
			end

		end

		context "ERROR: received date is null" do
			before do 
				@received_date = nil
				@campaign_start_date = Date.parse("October 19th, 2015, 12:00 pm -500")
			end

			it "raises ReceivedDateUnexpectedValue" do
				expect{ Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date) }.to raise_error(Exceptions::ReceivedDateUnexpectedValue)
			end

		end

		context "ERROR: campaign_start_date is not a Date object" do
			before do 
				#@received_date = DateTime.parse("October 19th, 2015, 12:00 pm -500")
				@received_date = Time.new(2015, 10, 19, 12, 0, 0, "-05:00")
				@campaign_start_date = DateTime.parse("October 19th, 2015, 12:00 pm -500")
			end

			it "raises CampaignStartDateUnexpectedValue" do
				expect{ Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date) }.to raise_error(Exceptions::CampaignStartDateUnexpectedValue)
			end

		end

		#context "ERROR: received_date date is not a DateTime object" do
		context "ERROR: received_date date is not a Time object" do
			before do 
				@received_date = Date.parse("October 19th, 2015, 12:00 pm -500")
				@campaign_start_date = Date.parse("October 19th, 2015, 12:00 pm -500")
			end

			it "raises ReceivedDateUnexpectedValue" do
				expect{ Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date) }.to raise_error(Exceptions::ReceivedDateUnexpectedValue)
			end

		end

		###################################################
		# 			standard case
		###################################################
		context "1) DUE DATE: received_date and campaign_start_date are non-holiday weekdays during normal business hours" do
			before do 
				#@received_date = DateTime.parse("October 19th, 2015, 12:00 pm -500") #Monday
				@received_date = Time.new(2015, 10, 19, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("October 23rd, 2015") #Friday
			end

			it "sets internal_due_date to campaign_start_date - 1" do
				#expected = DateTime.parse("October 22nd, 2015, 5:00 pm -500")
				expected = Time.new(2015, 10, 22, 17, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end

		context "2) SLA: received_date and campaign_start_date are non-holiday weekdays during normal business hours" do
			before do 
				#@received_date = DateTime.parse("October 19th, 2015, 12:00 pm -500") #Monday
				@received_date = Time.new(2015, 10, 19, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("October 20th, 2015") #Tuesday
			end

			it "sets internal_due_date to received_date + SLA" do
				#expected = DateTime.parse("October 21st, 2015, 1:00 pm -500")
				expected = Time.new(2015, 10, 21, 13, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end

		###################################################
		# 	when received_date falls on a weekend
		###################################################

		context "3) DUE DATE: received_date = weekend, campaign_start_date non-holiday weekday during normal business hours" do
			before do 
				#@received_date = DateTime.parse("October 17th, 2015, 12:00 pm -500") #Saturday
				@received_date = Time.new(2015, 10, 17, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("October 22th, 2015") #Thursday
			end

			it "sets internal_due_date to campaign_start_date - 1" do
				#expected = DateTime.parse("October 21st, 2015, 5:00 pm -500")
				expected = Time.new(2015, 10, 21, 17, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end	
		
		context "4) SLA: received_date = weekend, campaign_start_date non-holiday weekday during normal business hours" do
			before do 
				#@received_date = DateTime.parse("October 17th, 2015, 12:00 pm -500") #Saturday
				@received_date = Time.new(2015, 10, 17, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("October 19th, 2015") #Monday
			end

			it "sets internal_due_date to received_date + SLA" do
				#expected = DateTime.parse("October 20th, 2015, 5:00 pm -500")
				expected = Time.new(2015, 10, 20, 17, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end

		###################################################
		# 	when campaign_start_date falls on a weekend
		###################################################

		context "5) DUE DATE: received_date = non-holiday weekday during normal business hours, campaign_start_date = weekend" do
			before do 
				#@received_date = DateTime.parse("October 13th, 2015, 12:00 pm -500") #Tuesday
				@received_date = Time.new(2015, 10, 13, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("October 18th, 2015") #Sunday
			end

			it "sets internal_due_date to campaign_start_date - 1" do
				#expected = DateTime.parse("October 16th, 2015, 5:00 pm -500")
				expected = Time.new(2015, 10, 16, 17, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end	
		
		context "6) SLA: received_date = non-holiday weekday during normal business hours, campaign_start_date = weekend" do
			before do 
				#@received_date = DateTime.parse("October 16th, 2015, 12:00 pm -500") #Friday
				@received_date = Time.new(2015, 10, 16, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("October 18th, 2015") #Sunday
			end

			it "sets internal_due_date to received_date + SLA" do
				#expected = DateTime.parse("October 20th, 2015, 1:00 pm -500")
				expected = Time.new(2015, 10, 20, 13, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end

		###################################################
		# 	holidays
		###################################################

		context "7) DUE DATE: received_date = non-holiday weekday during normal business hours, campaign_start_date = holiday" do
			before do 
				#@received_date = DateTime.parse("December 23rd, 2015, 12:00 pm -500") #Wednesday last week
				@received_date = Time.new(2015, 12, 23, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("December 31st, 2015") #Thursday (NYE)
			end

			it "sets internal_due_date to campaign_start_date - 1" do
				#expected = DateTime.parse("December 30th, 2015, 5:00 pm -500")
				expected = Time.new(2015, 12, 30, 17, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end	
		
		context "8) SLA: received_date = non-holiday weekday during normal business hours, campaign_start_date = holiday" do
			before do 
				#@received_date = DateTime.parse("December 31st, 2015, 12:00 pm -500") #Wednesday
				@received_date = Time.new(2015, 12, 31, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("January 1st, 2016") #Friday
			end

			it "sets internal_due_date to received_date + SLA" do
				#expected = DateTime.parse("January 5th, 2016, 12:00 pm -500")
				expected = Time.new(2016, 1, 5, 12, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end

		context "9) DUE DATE: received_date = holiday, campaign_start_date = non-holiday weekday during normal business hours" do
			before do 
				#@received_date = DateTime.parse("January 1st, 2016, 12:00 pm -500") #Friday
				@received_date = Time.new(2016, 1, 1, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("January 8th, 2016") #Friday
			end

			it "sets internal_due_date to campaign_start_date - 1" do
				#expected = DateTime.parse("January 7th, 2016, 5:00 pm -500")
				expected = Time.new(2016, 1, 7, 17, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end	
		
		context "10) SLA: received_date = holiday, campaign_start_date = non-holiday weekend" do
			before do 
				#@received_date = DateTime.parse("January 1st, 2016, 12:00 pm -500") #Friday
				@received_date = Time.new(2016, 1, 1, 12, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("January 2nd, 2016") #Saturday
			end

			it "sets internal_due_date to received_date + SLA" do
				#expected = DateTime.parse("January 5th, 2016, 5:00 pm -500")
				expected = Time.new(2016, 1, 5, 17, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end

		###################################################
		# 	non-business hours
		###################################################

		context "11) DUE DATE: received after business hours" do
			before do 
				#@received_date = DateTime.parse("October 19th, 2015, 6:00 pm -500") #Monday
				@received_date = Time.new(2015, 10, 19, 18, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("October 23rd, 2015") #Friday
			end

			it "sets internal_due_date to campaign_start_date - 1" do
				#expected = DateTime.parse("October 22nd, 2015, 5:00 pm -500")
				expected = Time.new(2015, 10, 22, 17, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end	
		
		context "12) SLA: received after business hours" do
			before do 
				#@received_date = DateTime.parse("October 19th, 2015, 6:00 pm -500") #Monday
				@received_date = Time.new(2015, 10, 19, 18, 0, 0, "-05:00")
				@campaign_start_date = Date.parse("October 21st, 2015") #Thursday
			end

			it "sets internal_due_date to received_date + SLA" do
				#expected = DateTime.parse("October 21st, 2015, 5:00 pm -500")
				expected = Time.new(2015, 10, 21, 17, 0, 0, "-05:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end

		###################################################
		# 	time zone 
		###################################################

		context "13) DUE DATE: received_date and campaign_start_date are non-holiday weekdays during normal business hours" do
			before do 
				#@received_date = DateTime.parse("October 19th, 2015, 12:00 pm -500") #Monday
				@received_date = Time.new(2015, 10, 19, 12, 0, 0, "-10:00")
				@campaign_start_date = Date.parse("October 23rd, 2015") #Friday
			end

			it "sets internal_due_date to campaign_start_date - 1" do
				#expected = DateTime.parse("October 22nd, 2015, 5:00 pm -500")
				expected = Time.new(2015, 10, 22, 17, 0, 0, "-10:00")
				puts "expected: #{expected}"
				actual = Service::Importer::OpportunityToCampaignOrder.calculate_internal_due_date(@received_date, @campaign_start_date)
				expect(actual).to eq(expected)
			end
		end


	end



end