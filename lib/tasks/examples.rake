namespace :db do

	desc "Add some example data to database"
	task examples: :environment do
		puts "Loading example data..."

        puts "   Load dummy users..."
		100.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
						email: email,
						password: password,
						password_confirmation: password)
		end

        puts "   Load dummy articles..."
		50.times do |n|
			title = "Article #{n+1}"
			content = ""
			5.times do
				content += Faker::Lorem.paragraph(4) + "\n\n"
			end

			Article.create!(title: title, content: content, publish: true,
							rank: (n % 10) + 1, frontpage: (n <= 20) )
		end

        puts "   Load dummy events..."
        articles = Article.all
        article_names = articles.collect { |a| a.title }
        article_list = article_names.join(', ')
        Event.create!(name: 'Longwinded Event',
                        abbr: 'Long',
                        date: '2013-4-20',
                        article: article_list)

        dates = Array Date.today..(Date.today + 100)
        dates = dates.collect { |d| d.to_s }
        date_list = dates.join(', ')
        Event.create!(name: 'Frequently Sporadic',
                        abbr: 'freq',
                        date: date_list)

        d = Date.today
        100.times do |n|
            Event.create!(name: "Event #{n}",
                        abbr: "E-#{n}",
                        date: (d + n).to_s)
        end

	end
end

