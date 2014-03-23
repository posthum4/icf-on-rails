require 'spec_helper'

describe SalesForce::Client do

  before do
    @c = SalesForce::Client.new()
    # @o = SalesForce::Opportunity.all.sample
    # @a = SalesForce::Account.all.sample
    # @e = SalesForce::User.all.sample
  end

  describe 'new' do
    it 'returns a SalesForce::Client object' do
      expect(@c).to be_an_instance_of(SalesForce::Client)
    end
  end

  # describe 'materialize_all' do
  #   it 'creates Opportunity objects' do
  #     expect(@o).to be_an_instance_of(SalesForce::Opportunity)
  #   end
  #   it 'creates non nil Opportunity objects' do
  #     expect(@o).not_to be_empty
  #   end
  # end

end
