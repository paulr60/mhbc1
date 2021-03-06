require 'spec_helper'

describe "Authorization" do
	before { FactoryGirl.create(:site_info) }
	subject { page }

	describe "for non-signed-in users" do
		let(:user) { FactoryGirl.create(:user) }

		describe "when attempting to visit a protected page" do
			before do
				visit edit_user_path(user)
				fill_in "Email",	with: user.email
				fill_in "Password",	with: user.password
				click_button "Sign in"
			end

			describe "after signing in" do
				it "should render the desired protected page" do
					page.should have_selector('h1', text: 'Update')
				end
			end
		end

		describe "in the Users controller" do

			describe "visiting the edit page" do
				before { visit edit_user_path(user) }
				it { should have_selector('h1', text: 'Sign in') }
			end

			describe "submitting to the update action" do
				before { put user_path(user) }
				specify { response.should redirect_to(signin_path) }
			end

			describe "visiting the user index" do
				before  { visit users_path }
				it { should have_selector('h1', text: 'Sign in') }
			end
		end
	end

	describe "as wrong user" do
		let(:user) { FactoryGirl.create(:user) }
		let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
		before { sign_in user }

		describe "visiting Users#edit page" do
			before { visit edit_user_path(wrong_user) }
			it { should_not have_selector('h1', text: 'Update') }
		end

		describe "submitting a PUT request to the Users#update action" do
			before { put user_path(wrong_user) }
			specify { response.should redirect_to(root_path) }
		end
	end

	describe "as non-admin user" do
		let(:user) { FactoryGirl.create(:user) }
		let(:non_admin) { FactoryGirl.create(:user) }

		before { sign_in non_admin }

		describe "submitting a DELETE request to the Users#destroy action" do
			before { delete user_path(user) }
			specify { response.should redirect_to(root_path) }
		end
	end
	
end
