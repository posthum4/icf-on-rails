require 'csv'

class Value::Field < CSV::Table

  @@table = nil

  def initialize
    if @@table.nil?
      @@table = CSV::read("#{Rails.root}/db/fields.csv", headers: true)
    end
    self
  end

  def self.fields_for_order
    @@table.select { |f| f['Object'] == 'Order' }
  end

end