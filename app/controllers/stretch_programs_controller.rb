class StretchProgramsController < ApplicationController

  def new
    @stretch_program = StretchProgram.new
  end
  
  def create
    @stretch_program = StretchProgram.new(stretch_program_params)
    @stretch_program.user_id = current_user.id
    
    if @stretch_program.save
      #tag_ids = params[:stretch_program][:tag_ids]
      #tag_ids&.each do |tag_id|
      #  tag = StretchTag.find_by(id: tag_id)
      #  @stretch_program.stretch_tags << tag if tag
      #end
      #new_tag_names = params[:stretch_program][:tag_names]
      #new_tag_names.split(',').each do |name|
      #  tag = StretchTag.find_or_create_by(name: name.strip)
      #  @stretch_program.stretch_tags << tag
      #end
  
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
      #@stretch_program.stretch_tags.clear  # 既存のタグを一旦削除
      #tag_ids = params[:stretch_program][:stretch_tag_ids]
      #tag_ids&.each do |tag_id|
      #  tag = StretchTag.find_by(id: tag_id)
      #  @stretch_program.stretch_tags << tag if tag
      #end
  
      #new_tag_names = params[:stretch_program][:tag_names]
      #new_tag_names.split(',').each do |name|
      #  tag = StretchTag.find_or_create_by(name: name.strip)
      #  @stretch_program.stretch_tags << tag
      #end
  
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
