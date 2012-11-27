require 'spec_helper'

describe SiteInfo do
 	before do
 		@site_info = SiteInfo.new(title: "Montgomery Hills Baptist Church",
 									phone: "301-681-7990",
 									email: "foo@example.com",
 									address: "9727 Georgia Ave. Silver Spring, MD 20910")
 	end

 	subject { @site_info }

 	it { should respond_to(:title) }
 	it { should respond_to(:phone) }
 	it { should respond_to(:email) }
 	it { should respond_to(:address) }

 	it { should be_valid }

 	describe "when phone number blank" do
 		before { @site_info.phone = '' }
 		it { should_not be_valid }
 	end

end