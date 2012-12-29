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
#  image      :text
#

class Article < ActiveRecord::Base
 	attr_accessible :content, :frontpage, :image, :label, :menu, :publish, :rank, 
 					:summary, :title, :author

	validates :title, presence: true

	mount_uploader :image, ImageUploader

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

end
