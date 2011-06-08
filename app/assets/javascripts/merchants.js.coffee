$ ->
  $('#merchant_brand_tokens').tokenInput(
    '/brands.json',
    {
      crossDomain: false,
      prePopulate: $('#marchant_brand_tokens').data('pre'),
      theme: 'facebook'
    }
  )