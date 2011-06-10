class Photo < ActiveRecord::Base
  belongs_to :merchant
  
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 5.megabytes
  
  has_attached_file :data,
    :styles => { :small => "200x200#", :thumb => "100x100#" },
    :storage => :s3,
    :path => '/merchant/:id/:style.:extension',
    :bucket => ENV['S3_BUCKET'] || "kweenan#{Rails.env}",
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'] || 'AKIAJQ5MGLZBPNEPXM7Q',
      :secret_access_key => ENV['S3_SECRET'] || '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'
    }
end