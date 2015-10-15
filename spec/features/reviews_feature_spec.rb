require 'rails_helper'

feature 'reviewing' do

  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testttest')
    fill_in('Password confirmation', with: 'testttest')
    click_button('Sign up')
  end

  before {Restaurant.create name: 'The Ox'}

  scenario 'allows user to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review The Ox'
    fill_in 'Thoughts', with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end

  scenario 'user can only leave one review per restaurant' do 
    visit '/restaurants'
    click_link 'Review The Ox'
    fill_in 'Thoughts', with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review The Ox'
    click_button 'Leave Review'
    expect(page).to have_content('You have already reviewed this restaurant')
  end


end
