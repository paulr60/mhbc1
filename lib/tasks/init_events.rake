namespace :db do

	desc "Add some example events to database"
	task init_events: :environment do
		puts "Loading initial events..."

        Event.create!(name: "Sunday School",
                        abbr: "Sun Sch",
                        start_time: "9:45",
                        start_date: "2013-1-1",
                        end_date: "2015-12-31",
                        sun: true)

        Event.create!(name: "Worship Service",
                        abbr: "Worship",
                        start_time: "11:00",
                        start_date: "2013-1-1",
                        end_date: "2015-12-31",
                        sun: true)

        Event.create!(name: "Coffee Fellowship",
                        abbr: "Coffee",
                        start_time: "12:15",
                        date: "2013-4-14, 2013-4-21")

        Event.create!(name: "Youth Choir",
                        abbr: "Youth Chr",
                        start_time: "6:00",
                        start_date: "2013-4-1",
                        end_date: "2015-12-31",
                        wed: true)

        Event.create!(name: "Fellowship Dinner",
                        abbr: "Dinner",
                        start_time: "6:15",
                        start_date: "2013-4-1",
                        end_date: "2015-12-31",
                        wed: true)

        Event.create!(name: "Kids Choir",
                        abbr: "Kids Chr",
                        start_time: "6:30",
                        start_date: "2013-4-1",
                        end_date: "2015-12-31",
                        wed: true)

        Event.create!(name: "Wednesday Bible Study",
                        abbr: "Bible Study",
                        start_time: "7:00",
                        start_date: "2013-4-1",
                        end_date: "2015-12-31",
                        wed: true)

        Event.create!(name: "Adult Choir",
                        abbr: "Adult Chr",
                        start_time: "7:00",
                        start_date: "2013-4-1",
                        end_date: "2015-12-31",
                        wed: true)

        Event.create!(name: "MNBS",
                        abbr: "MNBS",
                        start_time: "6;30",
                        start_date: "2013-4-1",
                        end_date: "2015-12-31",
                        mon: true)

         Event.create!(name: "Thursday Bible Study",
                        abbr: "Bible Study",
                        start_time: "10:30",
                        start_date: "2013-4-1",
                        end_date: "2015-12-31",
                        thu: true)

         Event.create!(name: "Men's Breakfast",
                         abbr: "Mens Bkfst",
                         date: "2013-4-13")

        Event.create!(name: "Deacons Meeting",
                        abbr: "Deacons",
                        date: "2013-4-21",
                        start_time: "12:15")

	end
end