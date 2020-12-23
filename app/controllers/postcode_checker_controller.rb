# frozen_string_literal: true

class PostcodeCheckerController < ApplicationController
  def index
    return unless params[:postcode]

    begin
      service = PostcodeCheckerService.new
      is_valid = service.postcode_valid?(params[:postcode]) ? 'valid' : 'not valid'
      @result = "The postcode #{params[:postcode]} is #{is_valid}"
    rescue StandardError => e
      @result = e
    end
  end

  private

  def postcode_checker_params
    params.require(:postcode)
  end
end
