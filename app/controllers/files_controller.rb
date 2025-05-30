class FilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_file, only: [:destroy]

  def index
    @file_upload = FileUpload.new
    @file_uploads = current_user.file_uploads.order(created_at: :desc)
  end

  def create
    @file_upload = current_user.file_uploads.build(file_upload_params)
    
    if @file_upload.save
      redirect_to files_path, notice: 'File uploaded successfully!'
    else
      @file_uploads = current_user.file_uploads.order(created_at: :desc)
      flash.now[:alert] = 'Please fix the errors below.'
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    if @file.destroy
      respond_to do |format|
        format.html { redirect_to files_path, notice: 'File deleted successfully!' }
        format.json { render json: { success: true, message: 'File deleted successfully!' } }
      end
    else
      respond_to do |format|
        format.html { redirect_to files_path, alert: 'Failed to delete file.' }
        format.json { render json: { success: false, message: 'Failed to delete file.' } }
      end
    end
  end

  private

  def find_file
    @file = current_user.file_uploads.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to files_path, alert: 'File not found.' }
      format.json { render json: { success: false, message: 'File not found.' } }
    end
  end

  def file_upload_params
    params.require(:file_upload).permit(:title, :uploaded_file)
  end
end