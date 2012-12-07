
module MenuTreeSupport
	include TreeSupport
	
	class MenuTree < Tree
		def initialize(navbar_items)
			super('root')
			navbar_items.each do |i|
				add_branch(i)
			end
		end
		def parse_menu_chain(menu_chain)
			# Input string is colon-seperated menu-tree starting w/ navbar entry
			return [] if !menu_chain || menu_chain.empty?
			items = menu_chain.split(':')
			items.each do |i|
				i.strip!
			end
			items
		end
		def menu_chain_valid_navbar?(menu_chain)
			items = parse_menu_chain(menu_chain)
			find_branch_by_name(items[0])
		end
		def menu_chain_will_create_new_subtree?(menu_chain)
			items = parse_menu_chain(menu_chain)
			t = self
			items.slice(0, items.length-1).each do |i|
				b = t.find_branch_by_name(i)
				return true if b == nil
				t = b
			end
			return false
		end
		def add_menu_chain_to_tree(menu_chain)
			return nil if menu_chain_valid_navbar?(menu_chain) == false
			items = parse_menu_chain(menu_chain)

		end

	end

	def menu_tree_test
		mt = MenuTree.new(['a', 'b', 'c'])
		s = '<pre>' + mt.print_tree('') + '</pre>'
		s.html_safe
	end

end
