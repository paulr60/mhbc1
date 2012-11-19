module ApplicationHelper

	#
	# When no password entered on sign-up page, we get a message about
	# the blank field (Password can't be blank) and also an internal
	# message that the 'password digest' can't be blank.  Remove this
	# (redundant) digest message as it is just confusing.
	#
	def filter_out_digest_error(error_msgs)
		error_msgs.delete_if { |m| m.index('Password digest') }
	end
end
