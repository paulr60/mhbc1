# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  label      :string(255)
#  content    :string(255)
#  summary    :string(255)
#  publish    :boolean
#  frontpage  :boolean
#  menu       :string(255)
#  rank       :integer
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

end
