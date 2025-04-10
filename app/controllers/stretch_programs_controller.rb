class StretchProgramsController < ApplicationController
  before_action :authenticate_user!

  def new
    @stretch_program = StretchProgram.new
  end
  
  def create
    @stretch_program = StretchProgram.new(stretch_program_params)
    @stretch_program.user_id = current_user.id
    
    if @stretch_program.save
      redirect_to @stretch_program, notice: 'Stretch program was successfully created.'
    else
      render :new
    end
  end

  def index
    @stretch_programs = StretchProgram.all
  end

  def show
    @stretch_program = StretchProgram.find(params[:id])
  end

  def edit
    @stretch_program = StretchProgram.find(params[:id])
  end

  def update
    @stretch_program = StretchProgram.find(params[:id])
    
    if @stretch_program.update(stretch_program_params)
      redirect_to @stretch_program, notice: 'Stretch program was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if params[:tag_id]
      tag = StretchTag.find(params[:tag_id])

      StretchProgramTag.where(stretch_tag_id: tag.id).destroy_all
      tag.destroy

      flash[:notice] = "タグを削除しました。"
      redirect_back fallback_location: stretch_programs_path
    else
      @stretch_program = StretchProgram.find(params[:id])
      @stretch_program.destroy

      flash[:notice] = "ストレッチプログラムを削除しました"
      redirect_to stretch_programs_path
    end
  end
  

  private
  def stretch_program_params
    params.require(:stretch_program).permit(:title, :description, :duration, :difficulty, :genre_id, :user_id, :tag_names, stretch_tag_ids: [])
  end
  
end
