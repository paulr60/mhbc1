FactoryGirl.define do
	factory :user do
		sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end

		factory :author do
			author true
		end
	end

	factory :site_info do
		title "Montgomery Hills Baptist Church"
	 	phone "301-681-7990"
	 	email "foo@example.com"
	 	address "9727 Georgia Ave. Silver Spring, MD 20910"
	 	weekly "Sundays<br>Worship service 11 a.m."
	end

	factory :article do
		sequence(:title)	{ |n| "Article #{n}" }
		content		'Lorem ipsum Lorem ipsum dolor sit amet, consectetur adipisicing elit, ' +
					'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ' +
					'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ' +
					'ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit ' +
					'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur ' +
					'sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt ' +
					'mollit anim id est laborum.'
	end

end
