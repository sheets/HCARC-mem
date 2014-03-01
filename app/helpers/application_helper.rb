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
	def user_profile_icon(user)
		if user.userprofile.avatar.blank?
			image_tag "/assets/default-user-icon-profile.png"
		else
			image_tag user.userprofile.avatar_url(:medium)
			# image_tag  current_user.userprofile.assets.avatar(:tumb)
		end
	end
end
