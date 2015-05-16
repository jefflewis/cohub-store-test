require 'spec_helper.rb'

feature "Looking up products", js: true do
  before do
    Product.create!(name: 'Soccer Ball')
    Product.create!(name: 'Tennis Racket')
    Product.create!(name: 'Tennis Ball')
    Product.create!(name: 'Shotgun')
  end
  scenario "finding products" do
    visit '/'
    fill_in "keywords", with: "ball"
    click_on "Search"

    expect(page).to have_content("Soccer Ball")
    expect(page).to have_content("Tennis Ball")
  end
end
