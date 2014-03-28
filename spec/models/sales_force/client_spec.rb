require 'spec_helper'


describe "Too slow for comfort", :slow => true do

  describe SalesForce::Client do

    before do
      @c = SalesForce::Client.new()
      @o = SalesForce::Opportunity.all.sample
      @a = SalesForce::Account.all.sample
      @u = SalesForce::User.all.sample
    end

    describe 'new' do
      it 'returns a SalesForce::Client object' do
        expect(@c).to respond_to(:materialize_all)
      end
    end

    describe 'materialize_all' do
      it 'creates Opportunity objects' do
        expect(@o).to be_an_instance_of(SalesForce::Opportunity)
      end
      it 'creates non nil Opportunity objects' do
        expect(@o).not_to be_nil
      end
      it 'creates Account objects' do
        expect(@a).to be_an_instance_of(SalesForce::Account)
      end
      it 'creates non nil Account objects' do
        expect(@a).not_to be_nil
      end
      it 'creates User objects' do
        expect(@u).to be_an_instance_of(SalesForce::User)
      end
      it 'creates non nil User objects' do
        expect(@u).not_to be_nil
      end

    end

  end
end
