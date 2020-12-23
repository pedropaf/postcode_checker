# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe PostcodeCheckerService, type: :model do
  describe 'PostcodeCheckerService' do
    let(:service) { PostcodeCheckerService.new }

    it 'validates correctly postcodes additional to the lsoa defined' do
      expect(service.postcode_valid?('SH24 1AA')).to eq(true)
    end

    it 'raise an exception when a postcode does not meet the UK Gov regex' do
      expect { service.postcode_valid?('SH24') }.to raise_error(StandardError, 'The postcode format is not valid')
    end

    it 'raise an exception when there is a HTTP error' do
      stub_request(:get, 'http://api.postcodes.io/postcodes/EC1R5BX').to_return(status: [500, 'Internal Server Error'])
      expect do
        service.postcode_valid?('EC1R 5BX')
      end.to raise_error(StandardError, 'We could not verify the postcode at the moment')
    end

    it 'validates correctly a valid postcode within the lsoa accepted areas' do
      response = file_fixture('SE17QD_response.json').read
      stub_request(:get, 'http://api.postcodes.io/postcodes/SE17QD').to_return(
        body: response,
        headers: { content_type: 'application/json' }
      )
      expect(service.postcode_valid?('SE1 7QD')).to eq(true)
    end

    it 'validates correctly an invalid postcode outside lsoa accepted areas' do
      response = file_fixture('EC1R5BX_response.json').read
      stub_request(:get, 'http://api.postcodes.io/postcodes/EC1R5BX').to_return(
        body: response,
        headers: { content_type: 'application/json' }
      )
      expect(service.postcode_valid?('EC1R 5BX')).to eq(false)
    end
  end
end
