class UserprofilesController < ApplicationController
	load_resource
	authorize_resource
  def show
  	@user=current_user
  	@user_profile=@user.userprofile
  end
  def index
  	@user=current_user
  	@user_profiles=Userprofile.page(params[:page]).per(2)
  end
end
