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
#

class Article < ActiveRecord::Base
 	attr_accessible :content, :frontpage, :label, :menu, :publish, :rank, :summary, :title

	validates :title, presence: true


	def summary_text
		if self.summary.blank?
			self.content[0,200]
			#"Summary for " + self.title
		else
			self.summary
		end
	end

	def blurb(n_chars)
		self.summary_text[0, n_chars]
	end

	def edit_date
		updated_at.strftime('%b %d, %Y')
	end

end
