require 'csv'
module Value

  class Field < CSV::Table

    @@instance = nil
    @@table = nil

    def initialize
      @@table = CSV::read("#{Rails.root}/db/fields.csv", headers: true)
      @@instance = self
      @@instance
    end

    def for_campaign_order
      @@table.select { |f| f['Object'] == 'Order' }.to_a
    end

  end
end
