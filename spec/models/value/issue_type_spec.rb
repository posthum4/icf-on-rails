require 'spec_helper'

describe Value::IssueType do
  before do
    @t = Value::IssueType.jira_id(:launch)
    @s = Value::IssueType.symbol_for(19)
  end


  describe '#jira_id' do
    it 'returns 19 for a launch' do
      expect(@t).to eql(19)
    end
    it 'returns a :launch symbol for 19' do
      expect(@s).to eql(:launch)
    end

  end

end
