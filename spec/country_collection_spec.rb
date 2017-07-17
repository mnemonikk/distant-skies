require 'rails_helper'

RSpec.describe CountryCollection do
  subject(:countries) { described_class.instance }

  describe "#to_a" do
    it "contains pairs of english country name and iso code" do
      expect(countries.to_a).to include(["Germany", "DE"])
    end
  end

  describe "#codes" do
    it "contains country codes" do
      expect(countries.codes).to include("DE")
    end
  end
end
