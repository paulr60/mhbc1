
module MenuTreeSupport
	include TreeSupport
	
	class MenuTree < Tree

		def initialize(parent, name)
			super(parent, name)
		end	
		def add_branch(b)
			t = MenuTree.new(self, b)
			@branches << t
			t
		end
		def add_branches(branches)
			branches.each { |b| add_branch(b) }
		end
		def parse_menu_chain(menu_chain)
			# Input string is colon-separated menu-tree starting w/ navbar entry
			return [] if !menu_chain || menu_chain.empty?
			items = menu_chain.split(':')
			items.collect! { |i| i.strip }
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
		def add_menu_chain_to_tree(menu_chain, content)
			return nil if menu_chain.blank?
			return nil if menu_chain_valid_navbar?(menu_chain) == false
			items = parse_menu_chain(menu_chain)
			add_menu_chain_items(items, menu_chain, content)
		end
		def add_menu_chain_items(items, menu_chain, content)
			return if !items || items.length == 0
			i = items[0]
			b = find_branch_by_name(i)
			if (b == nil)
				b = add_branch(i)
			end
			if items.length > 1
				b.add_menu_chain_items(items[1..-1], menu_chain, content)
			else
				b.attach_content(menu_chain, content)
			end
		end

	end

	def menu_tree_test
		mt = MenuTree.new(['a', 'b', 'c'])
		s = '<pre>' + mt.print_tree('') + '</pre>'
		s.html_safe
	end

end
