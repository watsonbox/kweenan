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
  
  $('#merchant_postcode').change ->
    if $(this).val().substring(0,3) == '750'
      $('#merchant_city').val('Paris')
  
  $('#merchant_closed_for_lunch').change ->
    if $('#merchant_closed_for_lunch').is(':checked')
      $('table.business_hours div.break_times').show()
      $('table.business_hours tr').each ->
        if $(this).find('input.closed_check') && !$(this).find('input.closed_check').is(':checked')
          $(this).find('input.end_time2').val($(this).find('input.end_time').val())
          $(this).find('input.start_time2').val('13:00')
          $(this).find('input.end_time').val('12:00')
    else
      $('table.business_hours tr').each ->
        if $(this).find('input.closed_check') && !$(this).find('input.closed_check').is(':checked')
          $(this).find('input.end_time').val($(this).find('input.end_time2').val())
      $('table.business_hours div.break_times').hide()
      $('table.business_hours div.break_times input').val('')
  
  $('table.business_hours .closed_check').change ->
    hours_row = $(this).closest('tr').find('td.hours')
    
    if $(this).is(':checked')
      hours_row.find('.open').hide()
      hours_row.find("input[type='text']").val('')
      hours_row.find('.closed').show()
    else
      hours_row.find('.open').show()
      hours_row.find('.closed').hide()
  
  $('#merchant_description').cleditor
    controls: 'bold italic underline | undo redo | cut copy paste pastetext',
    width: '600px',
    bodyStyle: 'margin: 4px; color: #444; font-size: 16px; font-family: helvetica neue, arial, helvetica, lucida grande, sans-serif; cursor:text'
  
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
        # Needed to do this in order to un-escape HTML from server
        $('#photo_container').replaceWith $('<div/>').html(data['html']).text()
        doColorBox()

qq.UploadHandlerXhr.isSupported = ->
  return false

doColorBox = ->
  $("a[rel='merchant_photos']").colorbox
    maxHeight: '100%',
    maxWidth: '100%'