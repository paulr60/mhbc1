# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  label      :string(255)
#  content    :text(255)
#  summary    :text(255)
#  publish    :boolean
#  frontpage  :boolean
#  menu       :string(255)
#  rank       :integer          default(5)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author     :string(255)
#  image      :string(255)
#  gallery    :string(255)
#

class Article < ActiveRecord::Base
 	attr_accessible :content, :frontpage, :image, :gallery, :label, :menu, 
 					:publish, :rank, :summary, :title, :author

	validates :title, presence: true

    validate :valid_image, :valid_gallery

	def styled_content
		RedCloth.new(self.content).to_html
	end

	def summary_text
		if self.summary.blank?
			s = self.styled_content
			limit = 300
			s = s[0, limit]
			if s.length >= limit
				i = s.rindex(' ')
				s[0, i]
			else
				s
			end
		else
			self.summary
		end
	end

	def edit_date
		updated_at.strftime('%b %d, %Y')
	end

	def byline
		s = ''
		s += ('by ' + self.author + ' - ') if !self.author.blank?
		s + edit_date
	end

    def valid_image
        return if image.blank?
        p = Photo.find_by_name(image)
        errors.add :image, "Photo (#{image}) not found" if p == nil
    end
    def valid_gallery
        return if gallery.blank?
        g = Gallery.find_by_name(gallery)
        errors.add :gallery, "Gallery (#{gallery}) not found" if g == nil
    end

end
