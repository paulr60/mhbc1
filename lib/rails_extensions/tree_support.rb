module TreeSupport
	class Tree
		attr_reader :name, :parent, :content, :menu_path, :branches
		attr_writer :content

		def initialize(parent, name)
			@name = name
            @parent = parent
			@branches = []
			@menu_path = nil
			@content = nil
		end

		def branches
			@branches	# Make copy ?
		end

		def add_branch(b)
			t = Tree.new(self, b)
			@branches << t
			t
		end

		def find_branch_by_name(s)
			@branches.each do |b|
				return b if b.name == s
			end
			return nil
		end

		def find_branch_by_content(s)
			@branches.each do |b|
				return b if b.content == s
			end
			@branches.each do |b|
				subnode = b.find_branch_by_content(s)
				return subnode if subnode != nil
			end
			return nil
		end

        def find_by_menu_path(s)
            return self if @menu_path == s
			@branches.each do |b|
				return b if b.menu_path == s
			end
			@branches.each do |b|
				subnode = b.find_by_menu_path(s)
				return subnode if subnode != nil
			end
			return nil
        end

		def to_s
			b = @branches.collect {|b| b.to_s}
			s = "#{@name}: [#{b.join(', ')}] #{@menu_path} (#{@content ? @content : ''})"
		end

		def print_tree(indent)
			s = indent + @name + "\n"
			@branches.each do |b|
				s += b.print_tree(indent + '  ') + "\n"
			end
			s
		end

		#
		# If no content previously, just attach it.  If other content already
		# attached, then (create array if necessary &) append to content array.
		#
		def attach_content(menu_chain, new_content)
			@menu_path = menu_chain
			if @content == nil
				@content = new_content
			else
				if @content.kind_of? Array
					@content << new_content
				else
					@content = [@content, new_content]
				end
			end
		end

	end


	def tree_test
		t = Tree.new(nil, 'root')
		['a','b','c'].each do |i|
			t1 = t.add_branch(i)
			['1','2','3'].each do |j|
				t1.add_branch(j)
			end
		end

		s = '<pre>' + t.print_tree('') + '</pre>'
		s.html_safe
	end

end
