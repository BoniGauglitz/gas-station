class Station < ActiveRecord::Base
  def gas_price=(value)
    super(format_currency(value)) if value.present?
  end

  def etanol_price=(value)
    super(format_currency(value)) if value.present?
  end

  def diesel_price=(value)
    super(format_currency(value)) if value.present?
  end

  def format_currency(value)
    value.gsub(/R\$/, '').gsub(',', '.').to_f
  end
end
