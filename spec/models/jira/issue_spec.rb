require 'spec_helper'


describe Jira::Issue do

  before do
    @j = Jira::Issue.find_by_key('ICF-3214')
    @k = Jira::Issue.find_by_sfdcid('0068000000oAoSg')
    #@l = Jira::Issue.find_or_create_by_sfdcid('0068000000iVbIV')
  end

  # describe 'find_or_create_by_sfdcid', :focus => true do
  #   it 'returns a jira issue' do
  #     expect(@l).to be_a_kind_of(Jira::Issue)
  #   end
  # end

  context 'When JIRA exists' do

    describe '.find_by_key' do
      it 'returns an enumeration of results' do
        expect(@j).to respond_to(:each)
      end

      it 'returns Jira::Issue objects in the enumeration' do
        expect(@j.first).to be_a_kind_of(Jira::Issue)
      end
    end

    describe '#sfdcid' do
      it 'returns the expected SalesForce ID' do
        expect(@j[0].sfdcid).to eql('0068000000oAoSg')
      end
    end

    describe '.find_by_sfdcid' do
      it 'returns the expected Jira' do
        expect(@k[0].key).to eql('ICF-3214')
      end
    end


  end

end
