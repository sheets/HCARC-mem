class RegistrationsController < Devise::RegistrationsController
	before_filter :call_sign_call,:only=>[:profile]
	require 'nokogiri'
	require 'open-uri'
	def new
		@user=User.new
		@userprofile=params[:userprofile]
	end

	def create
		super
		unless @user.blank?
			@user.build_userprofile(params[:userprofile]).save!
		end
	end

	def update
		super
	end
	def profile
		@profile=Userprofile.new
	end
	def add_remove_role
		if params[:userid].present?
			user=User.find(params[:userid])
			user_type=(params[:member_type]=="voting")? "voting_member" : params[:member_type]
			if params[:add_role]=="true"
				user.add_role user_type
			else
				user.remove_role user_type
			end
		end
		respond_to	do |format|
			format.json{render json:{:success=>true}}
		end
	end
	private
	def call_sign_call
		if params[:call_sign].present?
			url="http://xmldata.qrz.com/xml/current/?s=#{cookies[:xml_key]}&callsign=#{params[:call_sign]}"
			xml = Nokogiri::XML(open(url))
			xml_path=xml.xpath("//xmlns:Callsign")
			if xml_path.blank?
				create_session
				url="http://xmldata.qrz.com/xml/current/?s=#{cookies[:xml_key]}&callsign=#{params[:call_sign]}"
				xml = Nokogiri::XML(open(url))
				xml_path=xml.xpath("//xmlns:Callsign")
			end
			@alldata={}

			xml_path.each do |node|
				@alldata["image"]=node.xpath("//xmlns:image").first.children.text rescue ""
			    @alldata["call"]=node.xpath("//xmlns:call").first.children.text rescue ""
			    @alldata["fname"]=node.xpath("//xmlns:fname").first.children.text rescue ""
			    @alldata["name"]=node.xpath("//xmlns:name").first.children.text rescue ""
			    @alldata["addr1"]=node.xpath("//xmlns:addr1").first.children.text rescue ""
			    @alldata["addr2"]=node.xpath("//xmlns:addr2").first.children.text rescue ""
			    @alldata["state"]=node.xpath("//xmlns:state").first.children.text rescue ""
			    @alldata["zip"]=node.xpath("//xmlns:zip").first.children.text rescue ""
			    @alldata["class_user"]=node.xpath("//xmlns:class").first.children.text rescue ""
			    @alldata["lat"]=node.xpath("//xmlns:lat").first.children.text rescue ""
			    @alldata["efdate"]=node.xpath("//xmlns:efdate").first.children.text rescue ""
			    @alldata["expdate"]=node.xpath("//xmlns:expdate").first.children.text rescue ""
			end
		else
			@alldata=""
		end
	end
	def create_session
		if params[:call_sign].present?
			url_auth="http://xmldata.qrz.com/xml/current/?username=kb4mbs&password=scxcdr34"
			xml_auth = Nokogiri::XML(open(url_auth))
			cookies[:xml_key] = { :value => xml_auth.xpath("//xmlns:Session//xmlns:Key").first.children.text, :expires => Time.now + 3600}
			cookies[:call_sign] = params[:call_sign]
		end
	end
	
end 
