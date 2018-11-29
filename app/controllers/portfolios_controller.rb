class PortfoliosController < ApplicationController

	before_action :authenticate_user!, except: [:index, :resume, :experience, :education, :sample_work, :projects, :about]

	def index
		@info = Portfolio.pluck(:summary).first
    @projects = Portfolio.pluck(:projects).first
    @publications = Portfolio.pluck(:selected_publications).first
    @education = Portfolio.pluck(:education).first
    @core = Portfolio.pluck(:core).first
    @skills = Portfolio.pluck(:skills).first
	end

	def create
		if Portfolio.count < 1
			@info = Portfolio.new(info_params)

			if @info.save
				redirect_to @info
			else
				render 'new'
			end
		else
			flash[:danger] = "Access denied"
			redirect_to root_path
		end

	end

	def new
		if Portfolio.count < 1
			@info = Portfolio.new
		else
			flash[:danger] = "Access denied"
			redirect_to root_path
		end
	end

	def edit
		if current_user.id == 1
    		@info = Portfolio.find(1)
    	else
    		flash[:danger] = "Access denied"
    		redirect_to root_path
    	end
  	end

  	def update
  		if current_user.id == 1
    		@info = Portfolio.find(1)
    		if @info.update_attributes(info_params)
      			redirect_to root_path, :notice => "Portfolio updated."
    		else
      			redirect_to root_path, :alert => "Unable to update portfolio."
    		end
    	else
    		flash[:danger] = "Access denied"
    		redirect_to root_path
    	end
  	end

  	def resume
#  		@info = Portfolio.select([:exp, :education, :core, :skills]).map {|e| {exp: e.exp, education: e.education, core: e.core, skills: e.skills} }
		@exp = Portfolio.pluck(:exp).first
		#@education = Portfolio.pluck(:education).first
		# @core = Portfolio.pluck(:core).first
		# @skills = Portfolio.pluck(:skills).first
  	end

  	def sample_work
  		@sample_work = Portfolio.pluck(:sample_work).first
  	end

  	# def projects
  	# 	@projects = Portfolio.pluck(:projects).first
  	# 	@publications = Portfolio.pluck(:selected_publications).first
  	# end

  	def about
  		@about = Portfolio.pluck(:hobbies).first
  	end

	private

	def info_params
		params.require(:portfolio).permit(:summary, :exp, :selected_publications, :education, :sample_work, :projects, :hobbies, :locations, :dates, :core, :comapny, :position, :skills)
	end


end

=begin
	
t.text     "summary"
    t.text     "exp"
    t.text     "selected_publications"
    t.text     "education"
    t.text     "sample_work"
    t.text     "projects"
    t.text     "hobbies"
    t.text     "locations"
    t.text     "dates"
    t.text     "core"
    t.text     "comapny"
    t.text     "position"
    t.text     "skills"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
	
=end
