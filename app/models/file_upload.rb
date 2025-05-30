class FileUpload < ApplicationRecord
  belongs_to :user
  has_one_attached :uploaded_file
  
  validates :uploaded_file, presence: true
  validates :title, presence: true
  
  before_validation :set_default_title
  
  private
  
  def set_default_title
    if title.blank? && uploaded_file.attached?
      self.title = uploaded_file.filename
    end
  end
end