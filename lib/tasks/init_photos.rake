namespace :db do

	desc "Add initial photos to database"
	task init_photos: :environment do
		puts "Loading initial photos..."

		def load_dirtree(dir)
			puts "DIR: #{dir}"
			fl = FileList["#{dir}/*"]
			fl.each do |f|
				if File.directory?(f)
					load_dirtree(f)
				else
					puts f
					base = File.basename(f, '.jpg')
					p = Photo.create!(name: base)
					p.image.store!(File.open(f))
					p.save!
					$total_files += 1
				end
			end
		end

		$total_files = 0
		root = '/home/paul/Pictures/mhbc_photos/'
		load_dirtree(root)
		puts "Total files = #{$total_files}"

		terps = Article.create!(title: "Terps", publish: true, 
								menu: 'About:Terps',
								content: "Fear the Turtle.  If you are playing defense against them, watch out or a pass might hit you in the face.")

	end
end
