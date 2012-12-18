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
				create_menu_block(b) if (b.branches != nil && b.branches.length > 0)
			end
			return Dropdown.new(@context, t.name, dd_items)			
		end

		# Provides support for array of content-items, generating a 'wrapper' page
		# that will contain blurbs for each article listed in array.
		def content_path(content)
			content
		end
	end

	class MenuSystem

		def initialize(context, site_info, articles)
			@context = context
			@user_menubar_items = site_info.menubar.split
			@tree = MenuTree.new('root')
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

		#private

			def create_navbar
				#home_item = MenuButton.new(@context, 'Home', {controller: 'static_pages', action: 'home'})
				home_item = MenuButton.new(@context, 'Home', @context.root_path)
				acct_menu = create_account_menu
				cms_menus = create_cms_menus
				Navbar.new(@context, [home_item] + cms_menus + [acct_menu])
			end

			def create_account_menu
				if  @context.signed_in?
					user = @context.current_user
					dd_items = []
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


	def menu_sys_test(context, site_info, articles)		
		m = MenuSystem.new(context, site_info, articles)
		m.navbar_html
	end

end
