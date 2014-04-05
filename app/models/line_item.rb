class LineItem < ActiveRecord::Base
  belongs_to :campaign_order

  monetize :budget_cents, with_model_currency: :budget_currency, :allow_nil => true
  monetize :price_cents, with_model_currency: :budget_currency, :allow_nil => true

end
