require 'spec_helper'

describe Order do
  before do
    @o = Array[]
    oppts = [
      '0068000000oAoSg', # 0 @o Enterprise: DSP
      '0068000000iVbIV', # 1 @p Channel: Booking
      '0068000000m9tPS', # 2 @q Media: Renewal
      '0068000000lOV8c', # 3 @r Media: New Business
      '0068000000nO334'  # 4 @s Media: Budget Change
    ]
    oppts.each { |o| @o << Order.find_or_create_by(sfdcid: o) }
    @p = Order.find_by(jira_key: 'ICF-3214')
  end

  context 'when opportunity exists' do

    context 'when JIRA exists' do

      describe '.find_or_create_by_(jira_key)', :focus => true do
        it 'finds an existing JIRA linkage' do
          expect (@p.sfdcid).to eql('0068000000oAoSg')
        end
      end

      describe '.find_or_create_by_(sfdcid)' do
        it 'finds an existing opportunity' do
          expect(@o[0].opportunity_name).to match('Bloomingdale')
        end
        it 'is an Order type' do
          expect(@o[0]).to be_kind_of(Order)
        end
      end

      describe '#sfdcid' do
        it 'matches an opportunity ID syntax' do
          expect(@o[0].sfdcid).to match(/(0068000000\w{5,})/)
        end
        it 'returns the same opportunity ID' do
          expect(@o[0].sfdcid).to eql('0068000000oAoSg')
        end
      end

    end
  end

  context 'when opportunity does not exist' do
    describe '::find_or_create_by_(sfdcid)' do
      it 'raises a non existant error' do
        expect { Order.find_or_create_by(sfdcid: '239872349872349') }.to raise_error(Databasedotcom::SalesForceError, 'Provided external ID field does not exist or is not accessible: 239872349872349')
      end
    end
  end
end
