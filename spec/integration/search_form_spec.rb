# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'postcode checker form', type: :feature do
  scenario 'search form renders' do
    visit postcode_checker_index_path
    expect(page).to have_content('Postcode Checker')
  end

  scenario 'search form renders invalid postcode format message' do
    visit postcode_checker_index_path
    fill_in 'postcode', with: 'hello'
    click_button 'Search'
    expect(page).to have_content('The postcode format is not valid')
  end

  scenario 'search form renders after a valid postcode is submitted' do
    visit postcode_checker_index_path
    fill_in 'postcode', with: 'SH24 1AA'
    click_button 'Search'
    expect(page).to have_content('The postcode SH24 1AA is valid')
  end
end
