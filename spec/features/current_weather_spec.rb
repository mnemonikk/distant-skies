require 'rails_helper'

describe 'getting current weather information', type: :feature, vcr: true do
  it 'returns weather information' do
    visit '/weather_queries/new'
    fill_in 'weather_query[location]', with: 'Bötzow'
    click_button 'Send query'
    expect(page).to have_content 'broken clouds'
  end
end
