module TodosHelper
	def new_line(s)
		# "\n" = "<br>"
		raw html_escape(s).gsub(/\n/, '<br />')#.html_safe
	end
end
