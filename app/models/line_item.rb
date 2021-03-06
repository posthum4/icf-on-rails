class LineItem < ActiveRecord::Base
  belongs_to :campaign_order

  monetize :budget_cents, with_model_currency: :budget_currency, :allow_nil => true
  monetize :price_cents, with_model_currency: :budget_currency, :allow_nil => true

  def fractional_bonus
    100.0 * self.bonus_impressions.to_f/(self.impressions.to_f + self.bonus_impressions.to_f)
  end

  def tactics_panel
    ViewModel::TacticsPanel.new(self).to_s
  end
end
