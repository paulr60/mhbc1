namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
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

		98.times do |n|
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
	 								menubar: "About News Youth Ministries",
	 								address: "9727 Georgia Ave. Silver Spring, MD 20910",
	 								weekly: "h5. Sundays\n\n" +
	 										"Sunday School - 9:45 a.m.\n" +
	 										"Worship Service - 11 a.m.\n\n" +
	 										"h5. Wednesdays\n\n" +
	 										"Wednesday Night Live! - 6:15 p.m.\n" +
	 										"Bible Study, Choir Rehearsal - 7 p.m.")

		about = Article.create!(title: "About us", publish: true,
								content: "We are very friendly.  Come visit us!")
		news = Article.create!(title: "News", publish: true,
								content: "No news is good news.")
		youth = Article.create!(title: "Youth program", publish: true,
								content: "We have special programs for youths.  Contct us.")
		ministries = Article.create!(title: "Ministries", publish: true,
								content: "We have both local and global ministries.")
		50.times do |n|
			title = "Article #{n+1}"
			content = ""
			5.times do
				content += Faker::Lorem.paragraph(4) + "\n\n"
			end

			Article.create!(title: title, content: content, publish: true)
		end

	end
end
