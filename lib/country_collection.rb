require 'csv'

class CountryCollection
  # got countries.csv from http://blog.plsoucy.com/2012/04/iso-3166-country-code-list-csv-sql/
  def self.instance
    new(
      CSV.read(
        Rails.root.join('config/countries.csv'), headers: true
      )
    )
  end

  def initialize(table)
    @table = table
  end

  def to_a
    @array ||= table.map { |row| row.values_at('English Name', 'Code') }
  end

  def codes
    @code ||= table.map { |row| row['Code'] }
  end

  private

  attr_reader :table
end
