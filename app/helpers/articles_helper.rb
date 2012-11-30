module ArticlesHelper
	def string_add_name_if_missing(str, name)
		str = '' if !str
		if (str.index(name) == nil)
			str += ', ' unless str.empty?
			str + name
		else
			str
		end
	end
end
