module TreeSupport
	class Tree
		attr_reader :name

		def initialize(name)
			@name = name
			@branches = []
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
			s = "#{@name}: ["
			@branches.each do |b|
				s += b.to_s + ", "
			end
			s + "]"
		end

		def print_tree(indent)
			s = indent + @name + "\n"
			@branches.each do |b|
				s += b.print_tree(indent + '  ') + "\n"
			end
			s
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
