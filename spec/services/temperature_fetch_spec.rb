require 'rails_helper'

RSpec.describe TemperatureFetch do

=begin  
  context "with valid city" do
    let (:valid_city) { "Warsaw" }

    it 'should return truthy value' do
      expect(TemperatureFetch.call(valid_city)).to be_truthy
    end

    it 'should return float' do
      expect(TemperatureFetch.call(valid_city)).to be_an(Float)
    end
  end

  context "with invalid city" do
    let (:invalid_city) { "Town123" }

    it 'should return nil' do
      expect(TemperatureFetch.call(invalid_city)).to be_nil
    end
  end
=end
end