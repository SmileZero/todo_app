module TodosHelper
	def new_line(s)
		# "\n" = "<br>"
		raw(s.gsub(/\n/, '<br>'))#.html_safe
	end
end
