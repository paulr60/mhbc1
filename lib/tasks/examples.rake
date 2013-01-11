namespace :db do

	desc "Add some example data to database"
	task examples: :environment do
		puts "Loading example data..."

		100.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
						email: email,
						password: password,
						password_confirmation: password)
		end

		50.times do |n|
			title = "Article #{n+1}"
			content = ""
			5.times do
				content += Faker::Lorem.paragraph(4) + "\n\n"
			end

			Article.create!(title: title, content: content, publish: true,
							rank: (n % 10) + 1, frontpage: (n <= 20) )
		end

	end
end

