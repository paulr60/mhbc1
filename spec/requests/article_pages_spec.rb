require 'spec_helper'

describe "ArticlePages" do
	before { FactoryGirl.create(:site_info) }
	let(:author) { FactoryGirl.create(:author) }

	subject { page }

	describe "New article" do
		before do
			sign_in(author)
			visit new_article_path
		end
		let(:submit) { "Create article" }

		describe "with invalid information" do
			it "should not create new article" do
				expect { click_button submit }.not_to change(Article, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Title",	with: "Story of zzyzx"
				fill_in "Label",	with: "example"
				fill_in "Content",	with: "This is a very short test story about zzyzx."
			end

			it "should create a new article" do
				expect { click_button submit }.to change(Article, :count).by(1)
			end	

			describe "after saving the article" do
				before { click_button submit }
				let(:article) { Article.find_by_label('example') }

				it { should have_content('zzyzx') }
				it { should have_selector('div.alert.alert-success', text: 'Article created') }
			end
			
		end

	end

	describe "Article Index page" do
		before do
			sign_in(author)
			visit articles_path
		end

		it { should have_header('All articles') }

		describe "pagination" do
			before(:all) { 40.times { FactoryGirl.create(:article) } }
			after(:all)  { Article.delete_all }

			it { should have_selector('div.pagination') }

			it "should list each article" do
				Article.paginate(page: 1).each do |article|
					page.should have_selector('li', text: article.title)
				end
			end
		end
	end

	describe "Article show page" do
		let(:article) { FactoryGirl.create(:article, title: "The story of zzyzx") }
		before { visit article_path(article) }

		it { should have_content('zzyzx') }
	end

end
