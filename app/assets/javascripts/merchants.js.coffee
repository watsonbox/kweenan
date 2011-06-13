$ ->
  $('#merchant_brand_tokens').tokenInput '/brands.json'
    crossDomain: false
    prePopulate: $('#marchant_brand_tokens').data('pre')
    theme: 'facebook'
  
  $("a.delete_photo")
    .live "ajax:success", (event, data, status, xhr) ->
      $('#photo_container').replaceWith(data['html'])
      doColorBox()
    .live "ajax:beforeSend", ->
      $("#photo_delete_spinner").show()
    .live "ajax:complete", ->
      $("#photo_delete_spinner").hide()
  
  $(".photo").live "mouseover mouseout", (event) ->
    if event.type == "mouseover"
      $(this).find('a.delete_photo').stop().animate opacity: 0.8, "slow"
    else
      $(this).find('a.delete_photo').stop().animate opacity: 0, "slow"
  
  doColorBox()

@photoUpload = (path, authToken, buttonText, dragDropText, messages = {}) ->
  new qq.FileUploader
    element: document.getElementById('file-uploader'),
    allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    limit: 5242880, # 5MB
    action: path,
    params:
      authenticity_token: authToken,
    template: "<div class='qq-uploader'>
      <div class='qq-upload-drop-area'><span>#{dragDropText}</span></div>
      <div class='qq-upload-button'>#{buttonText}</div>
      <ul class='qq-upload-list'></ul>
      </div>",
    messages: messages,
    onComplete: (id, fileName, data) ->
      unless data['error']
        $('#photo_container').replaceWith data['html']
        doColorBox()

doColorBox = ->
  $("a[rel='merchant_photos']").colorbox
    maxHeight: '100%',
    maxWidth: '100%'