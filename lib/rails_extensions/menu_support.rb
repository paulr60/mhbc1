module MenuSupport

	# Can be either a leaf node (MenuButton) or a submenu.
	# Menu is an array of these.
	class MenuItem
		def initialize
		end
	end

	class MenuButton < MenuItem
		include ActionView::Helpers::TagHelper
        attr_writer :options

		def initialize(context, text, path)
			@context = context
			@text = text
			@path = path
			@options = {}
		end
		def method(m)
			@options[:method] = m
		end
		def to_html
			if (@options == nil || @options.length == 0)
				s = @context.link_to(@text, @path)
			else
				s = @context.link_to(@text, @path, @options)
			end
			Rails.logger.debug("MyDebug MenuButton to_html: #{@path}: (#{s})")
			content_tag(:li, s)
		end
		def to_s
			"(#{@text} --> #{@path})"
		end
	end

    class Label < MenuItem
		include ActionView::Helpers::TagHelper
        def initialize(context, text)
            @context = context
            @text = text
        end
        def to_html
            #s = @context.link_to(@text, '#')
            s = @text
            content_tag(:li, s, :class => 'active').html_safe
        end
        def to_s
            "(#{@text} Active)"
        end
    end

	class Menu < MenuItem
		def initialize(context, items)
			@context = context
			@items = items
			Rails.logger.debug("MyDebug Menu.New: #{@items.to_s}")
		end
		def to_html
			menu_wrapper_html(body_html)
		end	
		def body_html
            debugger if false && (self.class == MenuBlock)
			s = (@items.collect {|i| i.to_html }).join("\n")
			s.html_safe
		end
		def to_s
			'[' + (@items.collect {|i| i.to_s}).join(', ') + ']'
		end
	end

	class Navbar < Menu
		include ActionView::Helpers::TagHelper
		def menu_wrapper_html(body)
			content_tag(:ul, body, :class => 'nav pull-right').html_safe
		end
	end

    class Selector < Menu
        include ActionView::Helpers::TagHelper
        def menu_wrapper_html(body)
            content_tag(:ul, body, :class => 'nav nav-pills selector pull-left').html_safe
        end
    end

	class MenuBlock < Menu
		include ActionView::Helpers::TagHelper
		def initialize(context, breadcrumb_data, items)
			super(context, items)
            @breadcrumbs = Breadcrumbs.new(breadcrumb_data)
		end
		def menu_wrapper_html(body)
			links = content_tag(:ul, body, :class => 'nav nav-list').html_safe
            s = @breadcrumbs.to_html + "\n" + links
            s.html_safe
		end
	end

    class Breadcrumbs
        include ActionView::Helpers::TagHelper
        def initialize(elems)
            @elems = elems
        end
        def to_html
            elems_html = @elems.collect { |e| e.to_html }
            s = elems_html.join(' <span class="divider">/</span> ')
            s2 = content_tag(:ul, s.html_safe, :class => 'breadcrumb').html_safe
            s2
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
		def to_s
			"<#{@title}: #{super.to_s}>"
		end
	end

end
