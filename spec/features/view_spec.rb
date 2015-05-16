require 'spec_helper.rb'

feature "Viewing a product", js: true do
  before do
    Product.create!(name: 'Baked Potato w/ Cheese',
           description: "nuke for 20 minutes")

    Product.create!(name: 'Baked Brussel Sprouts',
           description: 'Slather in oil, and roast on high heat for 20 minutes')
  end
  scenario "view one product" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    click_on "Baked Brussel Sprouts"

    expect(page).to have_content("Baked Brussel Sprouts")
    expect(page).to have_content("Slather in oil")

    click_on "Back"

    expect(page).to     have_content("Baked Brussel Sprouts")
    expect(page).to_not have_content("Slather in oil")
  end
end
