require 'rails_extensions/inject'
require 'rails_extensions/tree_support'
require 'rails_extensions/menu_tree_support'
require 'rails_extensions/menu_support'
require 'rails_extensions/menu_system_support'

class Array
	include Inject
end

class Range
	include Inject
end

# autoload(:Tree, 'rails_extensions/tree_support')

include TreeSupport
include MenuTreeSupport
include MenuSupport
include MenuSystemSupport
