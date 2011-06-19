class ProfilePhoto < Photo
  has_attached_file :data, DEFAULT_PARAMS.merge(
    :path => '/profile/:id/:style.:extension'
  )
end