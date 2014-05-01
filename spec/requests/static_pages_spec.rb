require 'spec_helper'

describe "Static pages" do


  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
  end
  

	let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  subject {page}

  shared_examples_for "all static pages" do
    it {should have_selector('h1', text: heading)}
    it {should have_title(full_title(page_title))}
  end

  describe "Home page" do

    before {visit root_path}

    let (:heading) { 'Sample App'}
    let (:page_title) {''}

    it_should_behave_like "all static pages"
    it {should_not have_title ('| Home')}

  

   

    describe "for signed-in users" do
      let(:user) {FactoryGirl.create(:user)}
      before do
        FactoryGirl.create(:micropost, user: user, created_at: 1.hour.ago, content: "veni, vedi, vici")
        FactoryGirl.create(:micropost, user: user, created_at: 1.day.ago, content: "Lorem ipsum")
        visit signin_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
        visit root_path
      end
    
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

    end

   # it {should have_content('Sample App')}
   # it {should have_title(full_title(''))}
   # it {should_not have_title('| Home')}

   # it "should have the content 'Sample App'" do
    #  visit root_path
    #  expect(page).to have_content('Sample App')
  #  end

  #  it "should have the base title" do
    #  visit root_path
   #   expect(page).to have_title("Ruby on Rails Tutorial Sample App")
  #  end

   # it "should not have a custom page title" do
    #  visit root_path
  #    expect(page).not_to have_title('| Home')
    end


  describe "Help Page" do
    before {visit help_path}

    let (:heading) {'Help'}
    let (:page_title) {'Help'}

    it_should_behave_like "all static pages"

 #   it {should have_content('Help')}
 #   it {should have_title(full_title('Help'))}

  	# it "shold have the content 'Help'" do
  	# 	visit help_path
  	# 	expect(page).to have_content('Help')
  	# end

  	# it "should have the right title" do
   #  	visit help_path
   #  	expect(page).to have_title("#{base_title} | Help")
   #  end
  end

  describe "About Page" do

    before {visit about_path}

    it {should have_content('about')}
    it {should have_title(full_title('About'))}

  	# it "should have the content 'about'" do
  	# 	visit about_path
  	# 	expect(page).to have_content('about')
  	# end

  	# it "should have the right title" do
   #  	visit about_path
   #  	expect(page).to have_title("#{base_title} | About")
   #  end
  end

  describe "Contact Page" do

    before {visit contact_path}

    it {should have_selector('h1', text: 'Contact')}
  #  it {should have_content('Contact')}
    it {should have_title(full_title('Contact'))}

  	# it "should have the content 'Contact'" do
  	# 	visit contact_path
  	# 	expect(page).to have_content('Contact')
  	# end

  	#  it "should have the right title" do
   #  	visit contact_path
   #  	expect(page).to have_title("#{base_title} | Contact")
   #  end
   end


end