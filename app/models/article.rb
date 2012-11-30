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
#

class Article < ActiveRecord::Base
 	attr_accessible :content, :frontpage, :label, :menu, :publish, :rank, 
 					:summary, :title, :author

	validates :title, presence: true


	def summary_text
		if self.summary.blank?
			self.content[0,200]
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
