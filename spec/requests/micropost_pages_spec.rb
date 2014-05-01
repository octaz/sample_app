require 'spec_helper'

describe "MicropostPages" do
 
 	subject {page}

 	let(:user) {FactoryGirl.create(:user)}

 	before {sign_in user}

 	describe "micropost creation" do
 		before {visit root_path}

 		describe "with invalid information" do

 			it "should not create a micropost" do
 				expect {click_button "Post" }.not_to change(Micropost, :count)
 			end

 			describe "error mesages" do
 				before {click_button "Post"}

 				it {should have_content('error')}
 			end

 		end

 		describe "with valid information" do
 			before {fill_in 'micropost_content', with: "Lorem ipsum"}
 			it "should create a micropost" do
 				expect {click_button "Post"}.to change(Micropost, :count).by(1)
 			end
 		end

 	end

 	describe "micropost deletion" do

 		before do
 			FactoryGirl.create(:micropost, user: user)
 			
 		end

 		describe "as a correct user" do
 			before {visit root_url}
 		

	 		it "should be able to delete micropost" do
	 			expect {click_link "delete"}.to change(Micropost, :count).by(-1)
	            # expect do
	            #   click_link('delete', match: :first)
	            # end.to change(user.microposts, :count).by(-1)
	        end
     	end
 	end

end
