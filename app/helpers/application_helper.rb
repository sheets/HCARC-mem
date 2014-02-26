module ApplicationHelper
	def class_name_translate(class_name)
		case class_name
		when "T"
			return "Technician"
		when "G"
			return "General"
		when "E"
			return "Extra"
		else
			return ""
		end
		
	end
end
