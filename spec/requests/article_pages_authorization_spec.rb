require 'spec_helper'


describe "ArticlePages Authorization" do
	before { FactoryGirl.create(:site_info)	}
	let(:article) { FactoryGirl.create(:article) }

	subject { page }


	describe "for non-signed-in users" do 

		describe "visiting the new article page" do
			before { visit new_article_path }
			it { should have_header('Sign in') }
		end


		describe "visiting the edit page" do
			before { visit edit_article_path(article) }
			it { should have_header('Sign in') }
		end

		describe "submitting to the update action" do
			before { put article_path(article) }
			specify { response.should redirect_to(signin_path) }
		end

		describe "visiting the article index" do
			before  { visit articles_path }
			it { should have_header('Sign in') }
		end
	end

	describe "for non-authorized users" do
		let(:user) { FactoryGirl.create(:user) }
		before { sign_in(user) }

		describe "visiting the new article page" do
			before { visit new_article_path(user) }
			it { should have_header('Montgomery') }
		end


		describe "visiting the edit page" do
			before { visit edit_article_path(article) }
			it { should have_header('Montgomery') }
		end

		describe "submitting to the update action" do
			before { put article_path(article) }
			specify { response.should redirect_to(root_path) }
		end

		describe "visiting the article index" do
			before  { visit articles_path }
			it { should have_header('Montgomery') }
		end
	end

	describe "for admin users" do
		let(:admin) { FactoryGirl.create(:admin) }

	end

	describe "for author users" do
		let(:author) { FactoryGirl.create(:author) }

	end
end
