require 'spec_helper'

describe "StaticPages" do
	subject { page }

  	describe "Home page" do
  		before { visit '/static_pages/home' }
  		let(:mhbc) { 'Montgomery Hills Baptist Church' }

  		it { should have_selector('h1',		text: "#{mhbc}") }
  		it { should have_selector('title',	text: "#{mhbc}") }
  	end
end
