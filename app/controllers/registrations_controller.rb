class RegistrationsController < Devise::RegistrationsController
	require 'nokogiri'
	require 'open-uri'
	def new
		url="http://xmldata.qrz.com/xml/current/?s=#{cookies[:xml_key]}&callsign=kb4mbs"
		xml = Nokogiri::XML(open(url))
		xml_path=xml.xpath("//xmlns:Callsign")
		if xml_path.blank?
			create_session
			url="http://xmldata.qrz.com/xml/current/?s=#{cookies[:xml_key]}&callsign=kb4mbs"
			xml = Nokogiri::XML(open(url))
			xml_path=xml.xpath("//xmlns:Callsign")
		end
		@alldata={}
		xml_path.each do |node|
		    @alldata["call"]=node.xpath("//xmlns:call").first.children.text
		    @alldata["fname"]=node.xpath("//xmlns:fname").first.children.text
		    @alldata["name"]=node.xpath("//xmlns:name").first.children.text
		    @alldata["addr1"]=node.xpath("//xmlns:addr1").first.children.text
		    @alldata["addr2"]=node.xpath("//xmlns:addr2").first.children.text
		    @alldata["state"]=node.xpath("//xmlns:state").first.children.text
		    @alldata["zip"]=node.xpath("//xmlns:zip").first.children.text
		    @alldata["class_user"]=node.xpath("//xmlns:class").first.children.text
		    @alldata["lat"]=node.xpath("//xmlns:lat").first.children.text
		    @alldata["efdate"]=node.xpath("//xmlns:efdate").first.children.text
		    @alldata["expdate"]=node.xpath("//xmlns:expdate").first.children.text
		end
		@user=User.new
		@user.build_userprofile
	end

	def create
		userprofile=params[:user][:userprofile_attributes]
		params[:user]=params[:user].except(:userprofile_attributes)
		super
		unless @user.blank?
			@user.build_userprofile(userprofile).save!
			# @user.userprofile.create!(userprofile)
		end
	end

	def update
		super
	end
	private
	def create_session
		url_auth="http://xmldata.qrz.com/xml/current/?username=kb4mbs&password=scxcdr34"
		xml_auth = Nokogiri::XML(open(url_auth))
		cookies[:xml_key] = { :value => xml_auth.xpath("//xmlns:Session//xmlns:Key").first.children.text, :expires => Time.now + 3600}
	end
	
end 
