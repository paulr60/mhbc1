module MenuSystemSupport

    # Provides support for array of content-items, generating a 'wrapper' page
    # that will contain blurbs for each article listed in array.
    def content_path(node)
        content = node.content
        if content.kind_of? Array
            menu = node.menu_path
            content = "/article_set?title=#{node.name}&menu_path=#{menu}"
        end
        content
    end

    
	class CmsMenu
		#
		# We create one of these for each CMS-type entry in navbar.
		# (i.e. those whose names are entered in site_info object's field,
		#  and whose content is derived from 'menu' fields in article objects)
		# 
		# Tree object passed in has:  name, branches, content
		#
		# If branches == nil, just a navbar button, else dropdown menu of branches
		#
		# If branches & content, need to create 1st entry in dropdown with same
		# name as b.name (i.e. b.name->b.name) and use it to attach content to.
		#
		# If branches, need to examine each one to see whether it has sub-branches.
		# For each branch with sub-branches, create a menu-block object.  When
		# creating menu-block, if another level of branching, generate error msg.
		# 
		# Also, if content is an array, we need to create 'wrapper' page to hold
		# multiple article-blurbs, one blurb per content-array item.
		#
		attr_reader :navbar_item

		def initialize(context, tree)
			@context = context
			@navbar_text = tree.name
			@tree = tree
			@navbar_item = nil	# May be drop-down or button
			@menu_blocks = nil	# Array of menu-blocks for sidebar display of 3rd level items

			#@navbar_item = MenuButton.new(@context, tree.name, '#')
			#@navbar_item = MenuButton.new(@context, tree.name, tree.content)

			if (tree.branches == nil || tree.branches.length == 0)
				@navbar_item = MenuButton.new(@context, tree.name, content_path(tree))
			else
				@navbar_item = create_dropdown
			end
		end

		def create_dropdown
			dd_items = []
			t = @tree
			if t.content.blank? == false
				dd_items << MenuButton.new(@context, t.name, content_path(t))
			end
			t.branches.each do |b|
				dd_items << MenuButton.new(@context, b.name, content_path(b))
			end
			return Dropdown.new(@context, t.name, dd_items)			
		end

	end

    class SelectorBlock
        def initialize(context, path_base, options, current_option)
            @items = []
            options.each do |o|
                opt_val = o.downcase
                if opt_val == current_option
                    mb = MenuButton.new(context, o, '#')
                    mb.options = {:class => 'active'}
                    @items << mb
                else
                    @items << MenuButton.new(context, o, path_base + opt_val)
                end
            end
            @sel = Selector.new(context, @items)
        end
        def to_html
            @sel.to_html
        end
    end

    class BreadcrumbData
        def initialize(context, tree, full_path)
            @context = context
            @tree = tree
            @full_path = full_path
            @path_elems = @full_path.split(':')
            @partial_paths = compute_partials(@path_elems)
        end
        def compute_partials(elem_list)
            elems = elem_list.clone
            return [] if !elems || elems.length == 0
            partials = []
            while elems.length > 0 do
                partials << elems.join(':')
                elems.pop
            end
            return partials.reverse
        end
        def link_list()
            paths = @partial_paths.clone
            paths.pop   # Remove last elem, it is current/active & becomes label
            links = paths.collect { |p| create_link(p) }
            links << Label.new(@context, @path_elems[-1])
            return links
        end
        def create_link(menu_path)
            # menu_path is colon-separated. name is last elem, i.e. what
            # would appear in the last level menu of menu chain.
            #
            # We need to find the associated content (i.e. page to link to)
            # by searching down menu tree to find node with menu_path in it.
            #
            node = @tree.find_by_menu_path(menu_path)
            return nil if node == nil
            MenuButton.new(@context, node.name, content_path(node))
        end
    end

	class MenuSystem

        # Call 'get' not 'new'
		def initialize(context, site_info, articles)
			@context = context
			@user_menubar_items = site_info.menubar.split
			@tree = MenuTree.new(nil, 'root')
			@tree.add_branches(@user_menubar_items)
			articles.each do |a|
                next if a.publish == false  # Draft articles don't add to menus
				chain = a.menu
                if (chain == 'About:Staff')
                    destination = '/staff'
                elsif (chain == 'Blog')
                    destination = '/blog'
                elsif (chain == 'About:Contact')
                    destination = '/contact'
                else
                    destination = @context.article_path(a.id)
                end
				@tree.add_menu_chain_to_tree(chain, destination)
			end
            @tree.add_menu_chain_to_tree('About:Help', '/help')
			@navbar = create_navbar
		end

        @@instance = nil
        def MenuSystem.get(context, site_info, articles)
            if @@instance == nil
                @@instance = self.new(context, site_info, articles)
            end
            return @@instance
        end

        def MenuSystem.reset
            @@instance = nil
        end

		def navbar_html
			@navbar.to_html
		end

		def find_node_with_content(content)
			return @tree.find_branch_by_content(content)
		end

		def find_node_for_current_page()
			c = @context.request.path
			return find_node_with_content(c)
		end

        def create_menu_block()
            this_node = find_node_for_current_page()
            return nil if this_node == nil
            
            menu_path = this_node.menu_path
            if this_node.branches == nil || this_node.branches.length == 0
                tree = this_node.parent #Show links for siblings
            else
                tree = this_node        #Show links for children
            end
            branches = tree.branches
            breadcrumbs = BreadcrumbData.new(@context, @tree, menu_path)
            crumbs = breadcrumbs.link_list()

            items = []
            tree.branches.each do |b|
                if b == this_node    # Is this branch the current page ?
                    items << Label.new(@context, b.name)
                else
                    items << MenuButton.new(@context, b.name, content_path(b))
                end
            end
			mb =  MenuBlock.new(@context, crumbs, items)
            return mb
        end

        def menu_debug_html
            indent = 0
            html = ''
            @user_menubar_items.each do |nav|
                tree = @tree.find_branch_by_name(nav)
                html += menu_debug_html_helper(indent, tree)
            end
            return html.html_safe
        end

		def dump_to_logger
			Rails.logger.debug("MyDebug MenuSystem:\n#{debug_text}")
		end

		#private

			def create_navbar
				#home_item = MenuButton.new(@context, 'Home', {controller: 'static_pages', action: 'home'})
				home_item = MenuButton.new(@context, 'Home', @context.root_path)
                news_item = MenuButton.new(@context, 'News', '/news')
				acct_menu = create_account_menu
				cms_menus = create_cms_menus
				Navbar.new(@context, [home_item] + [news_item] + cms_menus + [acct_menu])
			end

			def create_account_menu
				if  @context.signed_in?
					user = @context.current_user
					dd_items = []

                    if @context.privileged_user?(user)
                        dd_items << MenuButton.new(@context, 'Edit Content', '/content')
                    end
					dd_items << MenuButton.new(@context, 'Profile', @context.user_path(user))
					dd_items << MenuButton.new(@context, 'Settings', @context.edit_user_path(user))

					mb = MenuButton.new(@context, 'Sign out', @context.signout_path)
					mb.method('delete')
					dd_items << mb

					return Dropdown.new(@context, 'Account', dd_items)
				else
					return MenuButton.new(@context, 'Sign in', @context.signin_path)
				end
			end

			def create_cms_menus
				items = []
				@tree.branches.each do |b|
					cm = CmsMenu.new(@context, b)
					items << cm.navbar_item
				end
				items
			end

			def debug_text
				s = "MenuSystem (#{self}):\n"
				s += "\tuser_menubar_items: #{@user_menubar_items.inspect}\n"
				s += "\ttree: #{@tree.inspect}\n"
				s
			end

            def menu_debug_html_helper(indent, tree)
                html = ' ' * 4 * indent + "<ul>\n"

                btn = MenuButton.new(@context, tree.name, content_path(tree))
                s = ' ' * 4 * indent + btn.to_html + "\n"
                html += s.html_safe

                if tree.branches != nil && tree.branches.length > 0
                    tree.branches.each do |b|
                        html += menu_debug_html_helper(indent + 1, b)
                    end
                end

                html += ' ' * 4 * indent + "</ul>\n"
                return html.html_safe
            end
            
	end

end
