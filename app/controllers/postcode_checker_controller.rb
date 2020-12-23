# frozen_string_literal: true

class PostcodeCheckerController < ApplicationController
  def index
    postcode = postcode_checker_params['postcode']
    return if postcode.blank?

    begin
      service = PostcodeCheckerService.new
      is_valid = service.postcode_valid?(postcode) ? 'valid' : 'not valid'
      @result = "The postcode #{postcode} is #{is_valid}"
    rescue StandardError => e
      @result = e
    end
  end

  private

  def postcode_checker_params
    params.permit(:postcode)
  end
end
