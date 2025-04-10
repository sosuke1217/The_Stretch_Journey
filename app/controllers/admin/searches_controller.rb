class Admin::SearchesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @range = params[:range]
    @word = params[:word]
  
    case @range
    when "User"
      @users = User.looks(params[:search], params[:word])
    when "Stretch"
      @stretch_programs = StretchProgram.looks(params[:search], params[:word])
    when "Comment"
      @comments = Comment.looks(params[:search], params[:word])
    else
      flash[:notice] = "Invalid search range."
      redirect_to root_path
    end
  end
end