class UserprofilesController < ApplicationController
	load_resource
	authorize_resource
  def show
  	@user=current_user
  	@user_profile=@user.userprofile
  end
end
