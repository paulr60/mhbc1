module TreeSupport
	class Tree
		attr_reader :name, :content
		attr_writer :content

		def initialize(name)
			@name = name
			@branches = []
			@content = nil
		end

		def branches
			@branches	# Make copy ?
		end

		def add_branch(b)
			t = Tree.new(b)
			@branches << t
			t
		end

		def find_branch_by_name(s)
			@branches.each do |b|
				return b if b.name == s
			end
			return nil
		end

		def to_s
			b = @branches.collect {|b| b.to_s}
			s = "#{@name}: [#{b.join(', ')}] (#{@content ? @content : ''})"
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
		def attach_content(new_content)
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
		t = Tree.new('root')
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
