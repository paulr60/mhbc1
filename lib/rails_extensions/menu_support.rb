module MenuSupport

	class Foo
		def initialize
		end

		def to_s
			"foo"
		end
	end

	# Can be either a leaf node (MenuButton) or a submenu.
	# Menu is an array of these.
	class MenuItem
		def initialize
		end
	end

	class MenuButton < MenuItem
		include ActionView::Helpers::TagHelper
		def initialize(context, text, path)
			@context = context
			@text = text
			@path = path
		end
		def to_html
			s = @context.link_to(@text, @path)
			content_tag(:li, s)
		end
	end

	class Menu < MenuItem
		def initialize(context, items)
			@context = context
			@items = items
		end
		def to_html
			menu_wrapper_html(body_html)
		end
		def body_html
			s = ''
			@items.each do |i|
				s += i.to_html
			end
			s.html_safe
		end
	end

	class Navbar < Menu
		include ActionView::Helpers::TagHelper
		def menu_wrapper_html(body)
			content_tag(:ul, body, class: 'nav').html_safe
		end
	end

	class Dropdown < Menu
		include ActionView::Helpers::TagHelper
		def initialize(context, title, items)
			super(context, items)
			@title = title
		end
		def menu_wrapper_html(body)
			s = "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>\n" +
				"#{@title} <b class='caret'></b>\n</a>\n"
			s += content_tag(:ul, body, class: 'dropdown-menu')
			s = content_tag(:li, s.html_safe, class: 'dropdown')
			s.html_safe
		end
	end

	def MenuSupport.test1
		'foo'
	end

	def MenuSupport.test2(context)
		c = context
		mi = MenuButton.new(c, 'Home', '/')
		mi.to_html
	end

	def menu_test(context, site_info)
		Rails.logger.debug("MyDebugHelperSide2: #{@site_info.menubar.inspect}")

		c = context

		dropdown = Dropdown.new(c, 'Articles', [MenuButton.new(c, 'Index', articles_path),
												MenuButton.new(c, 'New', new_article_path)])
		nav = Navbar.new(c, [MenuButton.new(c, 'Home', root_path),
						  	 MenuButton.new(c, 'SiteInfo', edit_site_info_path(1)),
						  	 MenuButton.new(c, 'Users', users_path),
						  	 dropdown])
		nav.to_html
	end

	class MI
		include ActionView::Helpers::TagHelper
		def initialize(context)
			@context = context
		end
		def to_html(text, path)
			#content_tag(:a, text, href: path)
			@context.link_to(text, path)	
		end
	end

	def menu_gen(context)
		mi = MI.new(context)
		s = ''
		s += content_tag(:li, mi.to_html('Home', '/'))
		#s += content_tag(:li, mi.to_html('SiteInfo', '/site_infos/1/edit'))
		s += content_tag(:li, mi.to_html('SiteInfo', edit_site_info_path(1)))
		s = content_tag(:ul, s.html_safe, class: 'nav')
		s.html_safe
	end

end
