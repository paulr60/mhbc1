module MenuSystemSupport

	class MenuSystem

		def initialize(context, site_info, articles)
			@context = context
			@user_menubar_items = site_info.menubar.split
			@tree = MenuTree.new(@user_menubar_items)
			articles.each do |a|
				chain = a.menu
				@tree.add_menu_chain_to_tree(chain)
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
				home_item = MenuButton.new(@context, 'Home', {controller: 'static_pages', action: 'home'})
				#home_item = MenuButton.new(@context, 'Home', '/')
				return
				acct_menu = create_account_menu
				cms_menus = create_cms_menus
				Navbar.new(@context, [home_item] + cms_menus + [acct_menu])
			end

			def create_account_menu
				MenuButton.new(@context, 'Sign in', '#')
			end

			def create_cms_menus
				items = []
				@user_menubar_items.each do |name|
					items << MenuButton.new(@context, name, '#')
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

	def menu_sys_test1(context, site_info, articles)
		'foo'
	end

	def menu_sys_test2(context, site_info, articles)
		#Rails.logger.debug("MyDebug menu_sys_test2: #{@site_info.inspect}")
		#Rails.logger.debug("MyDebug menu_sys_test2: #{@site_info.menubar.inspect}")

		#m = MenuSystem.new(context, site_info, articles)
		#user_menubar_items = site_info.menubar.split
		"site_info: #{site_info.class}, #{site_info.inspect}"
		mb_items = site_info.menubar.split
		mt = MenuTree.new(mb_items)
		articles.each do |a|
			chain = a.menu
			mt.add_menu_chain_to_tree(chain)
		end
		home_item = MenuButton.new(context, 'Home', root_path)
		#home_item = MenuButton.new(context, 'Home', {controller: 'static_pages', action: 'home'})
		acct_menu = MenuButton.new(context, 'Sign in', '#')
		cms_menus = []
		mb_items.each do |name|
			cms_menus << MenuButton.new(context, name, '#')
		end
		nb = Navbar.new(context, [home_item] + cms_menus + [acct_menu])
		nb.to_html
		

		ms = MenuSystem.new(context, site_info, articles)
		
		#ms.navbar_html
		'end of menu_sys_test2'
	end

	def menu_sys_test(context, site_info, articles)		
		#foo = MenuButton.new(@context, 'Home', root_path)
		m = MenuSystem.new(context, site_info, articles)
		m.dump_to_logger
		m.navbar_html
	end

end
