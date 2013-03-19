module MenuSystemSupport

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
				@navbar_item = MenuButton.new(@context, tree.name, content_path(tree.content))
			else
				@navbar_item = create_dropdown
			end
		end

		def create_dropdown
			dd_items = []
			t = @tree
			if t.content.blank? == false
				dd_items << MenuButton.new(@context, t.name, content_path(t.content))
			end
			t.branches.each do |b|
				dd_items << MenuButton.new(@context, b.name, content_path(b.content))
			end
			return Dropdown.new(@context, t.name, dd_items)			
		end

		# Provides support for array of content-items, generating a 'wrapper' page
		# that will contain blurbs for each article listed in array.
		def content_path(content)
			content
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
            MenuButton.new(@context, node.name, node.content)
        end
        def link_list_old()
            links = []
            0...(@partial_paths.length-1).each do |i|
                links << create_link(@partial_path[i], @path_elems[i])
            end
            links << Label.new(@context, @path_elems[-1])
            return links
        end
        def create_link_old(menu_path, name)
            # menu_path is colon-separated. name is last elem, i.e. what
            # would appear in the last level menu of menu chain.
            #
            # We need to find the associated content (i.e. page to link to)
            # by searching down menu tree to find node with menu_path in it.
            #
            node = @tree.find_by_menu_path(menu_path)
            return nil if node == nil
            MenuButton.new(@context, name, node.content)
        end
    end

	class MenuSystem

		def initialize(context, site_info, articles)
			@context = context
			@user_menubar_items = site_info.menubar.split
			@tree = MenuTree.new(nil, 'root')
			@tree.add_branches(@user_menubar_items)
			articles.each do |a|
				chain = a.menu
				@tree.add_menu_chain_to_tree(chain, "#{@context.article_path(a.id)}")
			end
			@navbar = create_navbar
		end

		def navbar_html
			@navbar.to_html
		end

		def dump_to_logger
			Rails.logger.debug("MyDebug MenuSystem:\n#{debug_text}")
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
            breadcrumbs = BreadcrumbData.new(@context, tree, menu_path)
            crumbs = breadcrumbs.link_list()

            items = []
            tree.branches.each do |b|
                if b == this_node    # Is this branch the current page ?
                    items << Label.new(@context, b.name)
                else
                    items << MenuButton.new(@context, b.name, b.content)
                end
            end
			mb =  MenuBlock.new(@context, crumbs, items)
            return mb
        end

		def test1(context)
			r = context.request
			n = find_node_for_current_page()
			rp = r.path
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

			def create_cms_menus_old
				items = []
				@user_menubar_items.each do |name|
					items << MenuButton.new(@context, name, '#')
				end
				items
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

	end

end
