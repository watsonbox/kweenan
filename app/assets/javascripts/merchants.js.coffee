$ ->
  $('#merchant_brand_tokens').tokenInput(
    '/brands.json',
    {
      crossDomain: false,
      prePopulate: $('#marchant_brand_tokens').data('pre'),
      theme: 'facebook'
    }
  )
  
  $("a.delete_photo")
    .live("ajax:success", (event, data, status, xhr) ->
      $('#photo_container').replaceWith(data['html'])
      $("a[rel='merchant_photos']").colorbox()
    )
    .live("ajax:beforeSend", -> $("#photo_delete_spinner").show())
    .live("ajax:complete", -> $("#photo_delete_spinner").hide())
  
  $(".photo").live "mouseover mouseout", (event) ->
    if ( event.type == "mouseover" )
      $(this).find('a.delete_photo').stop().animate({"opacity": "0.8"}, "slow")
    else
      $(this).find('a.delete_photo').stop().animate({"opacity": "0"}, "slow")
  
  $("a[rel='merchant_photos']").colorbox()

@photoUpload = (path, authToken, buttonText, dragDropText, messages = {}) ->
  uploader = new qq.FileUploader({
    element: document.getElementById('file-uploader'),
    allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    action: path,
    params: { authenticity_token: authToken },
    template: '<div class="qq-uploader">' +
        '<div class="qq-upload-drop-area"><span>' + dragDropText + '</span></div>' +
        '<div class="qq-upload-button">' + buttonText + '</div>' +
        '<ul class="qq-upload-list"></ul>' +
      '</div>',
    messages: messages,
    onComplete: (id, fileName, data) ->
      $('#photo_container').replaceWith(data['html']) unless data['error']
      $("a[rel='merchant_photos']").colorbox()
  });