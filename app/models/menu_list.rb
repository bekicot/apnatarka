class MenuList < ApplicationRecord
  has_attached_file :menu_file, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :menu_file, :content_type => ["application/pdf", "application/zip", "application/msword", "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/x-zip"]
  before_post_process :skip_for_zip

  def skip_for_zip
    ! %w(application/zip application/x-zip).include?(menu_file_content_type)
  end
end
