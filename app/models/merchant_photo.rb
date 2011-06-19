class MerchantPhoto < Photo
  has_attached_file :data, DEFAULT_PARAMS.merge(
    :path => '/merchant/:id/:style.:extension'
  )
end