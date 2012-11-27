FactoryGirl.define do
	factory :user do
		sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end

	factory :site_info do
		title "Montgomery Hills Baptist Church"
	 	phone "301-681-7990"
	 	email "foo@example.com"
	 	address "9727 Georgia Ave. Silver Spring, MD 20910"
	 	weekly "Sundays<br>Worship service 11 a.m."
	end
end