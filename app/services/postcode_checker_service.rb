# frozen_string_literal: true

class PostcodeCheckerService
  def initialize
    @additional_valid_postcodes = %w[SH241AA SH241AB]
    @valid_lsoa = %w[Southwark Lambeth]
  end

  def postcode_valid?(postcode)
    postcode = sanitize(postcode)
    postcode_validate_regex(postcode)
    return true if @additional_valid_postcodes.include?(postcode)

    postcode_lsoa = postcode_lsoa(postcode)
    index = @valid_lsoa.find_index { |l| postcode_lsoa.starts_with?(l.downcase) }
    !index.nil?
  end

  private

  def sanitize(postcode)
    postcode.is_a?(String) ? postcode.delete(' ').upcase : ''
  end

  def postcode_validate_regex(postcode)
    return if /[A-Z]{1,2}[0-9R][0-9A-Z]?[0-9][A-Z-[CIKMOV]]{2}/.match?(postcode)

    raise StandardError, 'The postcode format is not valid'
  end

  def postcode_lsoa(postcode)
    uri = URI("http://api.postcodes.io/postcodes/#{postcode}")
    response = Net::HTTP.get_response(uri)

    unless (response.is_a? Net::HTTPSuccess) && (response.code == '200')
      raise StandardError, 'We could not verify the postcode at the moment'; end

    ((JSON.parse(response.body))['result']['lsoa']).downcase
  end
end
