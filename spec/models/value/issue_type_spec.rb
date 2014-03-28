require 'spec_helper'

describe Value::IssueType do
  before do
    @t = Value::IssueType.jira_id('Media: New Business')
    @random = ('a'..'z').to_a.shuffle[0,8].join
    @s = Value::IssueType.jira_id(@random)
  end


  describe '#jira_id' do
    it 'returns 19 for a launch' do
      expect(@t).to eql(19)
    end
    it 'returns 19 for a random string' do
      expect(@s).to eql(19)
    end

  end

end
