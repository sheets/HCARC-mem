class UserprofilesController < ApplicationController
  before_filter :authenticate_user!
	load_resource
	authorize_resource
  def show
  	@user=User.find(params[:user_id])
  	@user_profile=@user.userprofile
  end
  def index
  	@user=current_user
  	@user_profiles=Userprofile.page(params[:page]).per(10)
  end
end
