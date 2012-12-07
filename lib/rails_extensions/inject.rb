#
# Code from 'Programming Ruby' book modeled on Smalltalk's inject function.
#
# Example usage:
#
# 	class Array
# 		include Inject
# 	end
#
# 	[1,2,3,4,5].sum
#
module Inject
	def inject(n)
		each do |value|
			n = yield(n, value)
		end
		n
	end

	def sum(initial = 0)
		inject(initial) { |n, value| n + value }
	end

	def product(initial = 1)
		inject(initial) { |n, value| n * value }
	end

end
