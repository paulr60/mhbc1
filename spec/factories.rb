FactoryGirl.define do
	factory :user do
		name	 "Joe User"
		email	 "joe_user@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
end