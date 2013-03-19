namespace :db do

	task :reload => [:reset, :defaults, :init_articles, :init_photos,
					:examples, :populate2, 'test:prepare'] do
		puts 'DB Reload complete'
	end

	desc "Load database with initial users and SiteInfo"
	task defaults: :environment do
		puts "Loading default users and SiteInfo..."
		
		admin = User.create!(name: "Admin User",
							email: "example@railstutorial.org",
							password: "foobar",
							password_confirmation: "foobar")
		admin.toggle!(:admin)		

		joel = User.create!(name: "Joel Hawthorne",
							email: "joel@example.com",
							password: "foobar",
							password_confirmation: "foobar")
		joel.toggle!(:author)


		site_info = SiteInfo.create!(title: "Montgomery Hills Baptist Church",
	 								phone: "301-681-7990",
	 								email: "foo@example.com",
	 								menubar: "About Youth Ministries",
	 								address: "9727 Georgia Ave. Silver Spring, MD 20910",
	 								weekly: "h5. Sundays\n\n" +
	 										"Sunday School - 9:45 am\n" +
	 										"Worship Service - 11 am\n\n" +
	 										"h5. Wednesdays\n\n" +
	 										"Wednesday Night Live! - 6:15 pm\n" +
	 										"Bible Study, Choir Rehearsal - 7 pm")

	end
end
