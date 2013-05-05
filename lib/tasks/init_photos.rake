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
		#root = '/home/paul/Pictures/mhbc_photos'[
        root = Rails.root.to_s + '/lib/tasks/init_images/mhbc_photos'
		load_dirtree(root)
		puts "Total files = #{$total_files}"

		Gallery.create!(name: "Anniversary Luncheon", photos: 'anniversary*',
						description: 'Celebrating 100 years with a special luncheon.')
		Gallery.create!(name: "Worship", photos: 'worship*, childrens_prayer*',
						description: 'Images from our Sunday morning worship services.')
		Gallery.create!(name: "Music", photos: 'music*',
						description: 'Enhancing our worship experience through music.')		
		Gallery.create!(name: "Choir", photos: 'choir*',
						description: 'Our Choir, led by Ms. Cheryl Spell.')
		Gallery.create!(name: "Advent", photos: 'advent*',
						description: 'Images from the Advent season.')
		
	end
end
