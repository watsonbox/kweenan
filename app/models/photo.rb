class Photo < ActiveRecord::Base
  belongs_to :photoable, :polymorphic => true
  
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 5.megabytes

  delegate :url, :to => :data
  
  DEFAULT_PARAMS = {
    :styles => { :small => "200x200#", :thumb => "100x100#" },
    :storage => :s3,
    :path => '/photos/:id/:style.:extension',
    :bucket => ENV['S3_BUCKET'] || "kweenan#{Rails.env}",
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'] || 'AKIAJQ5MGLZBPNEPXM7Q',
      :secret_access_key => ENV['S3_SECRET'] || '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'
    }
  }
  
  # Interpolation in paperclip causes use of model attribute not temp file original_filename
  #Paperclip.interpolates :data_file_name_extension  do |attachment, style|
  #  File.extname(attachment.instance.data_file_name).gsub(/^\.+/, "")
  #end
end