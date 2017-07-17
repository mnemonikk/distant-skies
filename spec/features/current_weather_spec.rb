require 'rails_helper'

describe 'getting current weather information', type: :feature, vcr: true do
  it 'returns weather information' do
    visit '/weather_queries/new'
    fill_in 'weather_query[location]', with: 'Bötzow'
    select 'Germany', from: 'weather_query[country]'
    click_button 'Send'
    expect(page).to have_content 'scattered clouds'
  end

  it 'uses the country parameter' do
    visit '/weather_queries/new'
    fill_in 'weather_query[location]', with: 'Potsdam'
    select 'Germany', from: 'weather_query[country]'
    click_button 'Send'
    expect(page).to have_content 'scattered clouds'

    fill_in 'weather_query[location]', with: 'Potsdam'
    select 'United States', from: 'weather_query[country]'
    click_button 'Send'
    expect(page).to have_content 'mist'
  end
end
