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

    before_validation :strip_whitespace

	validates :title, presence: true, uniqueness: true

    validate :valid_image, :valid_gallery, :valid_menu_entry

    def strip_whitespace
        self.title.strip!   if self.title.blank? == false
        self.image.strip!   if self.image.blank? == false
        self.gallery.strip! if self.gallery.blank? == false
    end

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

    def valid_menu_entry
        return if menu.blank?
        menu_fields = menu.split(':')

        # Make sure first field is in SiteInfo.menubar
        site_info = SiteInfo.all[0]
        user_menubar_items = site_info.menubar.split
        navbar_item = menu_fields[0]
        if user_menubar_items.include?(navbar_item) == false
            errors.add :menu, "#{navbar_item} not an entry in SiteInfo menubar list"
        end

        # Make sure all intermediate fields (not last) already have a 'published'
        # article whose menu field is that node.  If not, and this article's
        # publish field is false, warn.  If publish flag set here, fail validate.

        return if publish == false          # Don't need to pass this check on draft
        return if menu_fields.length < 3    # First and last are skipped here
        articles = Article.all
        menu_nodes = []
        articles.each do |a|
            menu_nodes << a.menu if a.publish
        end

        partial = navbar_item
        1.upto(menu_fields.length - 2) do |n|
            partial += ':' + menu_fields[n]
            if menu_nodes.include?(partial) == false
                errors.add :menu, "Can't publish this article until creating #{partial}"
            end
        end
    end
end
