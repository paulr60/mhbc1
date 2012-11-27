namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "Example User",
							email: "example@railstutorial.org",
							password: "foobar",
							password_confirmation: "foobar")
		admin.toggle!(:admin)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
						email: email,
						password: password,
						password_confirmation: password)
		end

		site_info = SiteInfo.create!(title: "Montgomery Hills Baptist Church",
	 								phone: "301-681-7990",
	 								email: "foo@example.com",
	 								address: "9727 Georgia Ave. Silver Spring, MD 20910",
	 								weekly: '<div class="subhead">Sundays</div>' +
	 										"Sunday School - 9:45 a.m.<br>" +
	 										"Worship Service - 11 a.m.<br>" +
	 										'<div class="subhead">Wednesdays</div>' +
	 										"Wednesday Night Live! - 6:15 p.m.<br>" +
	 										"Bible Study, Choir Rehearsal - 7 p.m.")

	end
end
