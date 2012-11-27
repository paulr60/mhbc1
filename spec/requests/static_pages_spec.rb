require 'spec_helper'

describe "StaticPages" do
    before { FactoryGirl.create(:site_info) }
    subject { page }

  	describe "Home page" do
  		before { visit root_path }
  		let(:mhbc) { 'Montgomery Hills Baptist Church' }

  		it { should have_selector('h1',		text: "#{mhbc}") }
  		it { should have_selector('title',	text: "#{mhbc}") }
  	end

  	describe "Contact Page" do
  		before { visit contact_path }

  		it { should have_selector('h1', text: 'Contact') }
  	end
  	
end
