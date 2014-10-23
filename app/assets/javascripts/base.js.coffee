$(document).ready ->

  addBordersOverlay = (map, bounds) ->
    encodedPolygon = new google.maps.Polygon(
      clickable: false
      fillColor: "blue"
      fillOpacity: 0.2
      geodesic: false
      map: map
      strokeColor: "#000000"
      strokeOpacity: 0.6
      strokeWeight: 2
      zIndex: 10
      paths: eval(bounds)
    )
    encodedPolygon

  google.maps.Polygon::getBounds = ->
    bounds = new google.maps.LatLngBounds()
    paths = @getPaths()
    path = undefined
    i = 0

    while i < paths.getLength()
      path = paths.getAt(i)
      ii = 0

      while ii < path.getLength()
        bounds.extend path.getAt(ii)
        ii++
      i++
    bounds

  initialize = (bounds) ->
    mapCanvas = document.getElementById('map_canvas')
    mapOptions = {
      center: new google.maps.LatLng(50.5403, 15.5463),
      zoom: 9,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(mapCanvas, mapOptions)
    poly = addBordersOverlay(map ,bounds)
    map.fitBounds(poly.getBounds());

  $.ajax
    url: "country_overlay"
    dataType: 'json'
    type: "GET"
    data:
      name: $('.main_country').attr("data-attribute")
    success: (data) ->
      google.maps.event.addDomListener(window, 'load', initialize(data.bound))

  $("#show-countries").click ->
    $(".more-countries").toggle()

#  $(".link-wiki").click ->
#    $(".country-wiki").toggle()

$(document).on "page:change", ->
  locale = window.location.href.toString().split('?locale=')[1]
  if locale == 'ru'
    I18n.locale = 'ru'
  else if locale == 'en'
    I18n.locale = 'en'
  else
    I18n.locale = 'ru'

  $(".social-likes").socialLikes
    url: "http://prproject.herokuapp.com/"
    counters: true
    zeroes: false

  $('#what-growth').noUiSlider
    start: 150,
    step: 1
    connect: "lower",
    range:
      'min': 100,
      'max': 250

  $('#what-weight').noUiSlider
    start: 70,
    step: 1
    connect: "lower",
    range:
      'min': 30,
      'max': 150

  $('#what-foot_size').noUiSlider
    start: 38,
    step: 1
    connect: "lower",
    range:
      'min': 35,
      'max': 45

  $('#what-body_type').noUiSlider
    start: 3,
    step: 1,
    connect: "lower",
    range:
      'min': 1,
      'max': 5

  $('#what-growth .noUi-handle.noUi-handle-lower').html "<div id='slider_growth'>150</div>"
  $('#what-weight .noUi-handle.noUi-handle-lower').html("<div id='slider_weight'>70</div>")
  $('#what-foot_size .noUi-handle.noUi-handle-lower').html("<div id='slider_foot_size'>38</div>")
  $('#what-body_type .noUi-handle.noUi-handle-lower').html("<div id='slider_body_type'></div>")
  $('#slider_body_type').html(I18n.t("bodies.normal"))

  initialize


  $('#what-growth').on
    slide: ->
      valueGrowth = parseInt $('#what-growth').val()
      $('#slider_growth').html(valueGrowth)
      $('.step-nav__item.step-nav__item_5 a').html(valueGrowth)
      $('#what-growth-input').val(valueGrowth)

  $('#what-weight').on
    slide: ->
      valueWeight = parseInt $('#what-weight').val()
      $('#slider_weight').html(valueWeight)
      $('.step-nav__item.step-nav__item_1 a').html(valueWeight)
      $('#what-weight-input').val(valueWeight)

  $('#what-foot_size').on
    slide: ->
      valueFootSize = parseInt $('#what-foot_size').val()
      $('#slider_foot_size').html(valueFootSize)
      $('.step-nav__item.step-nav__item_2 a').html(valueFootSize)
      $('#what-foot_size-input').val(valueFootSize)

  $('#what-body_type').on
    slide: ->
      if (parseInt $('#what-body_type').val()) == 1
        valueBodyType = I18n.translate("bodies.very_slim")
      else if (parseInt $('#what-body_type').val()) == 2
        valueBodyType = I18n.translate("bodies.slim")
      else if (parseInt $('#what-body_type').val()) == 3
        valueBodyType = I18n.translate("bodies.normal")
      else if (parseInt $('#what-body_type').val()) == 4
        valueBodyType = I18n.translate("bodies.heavy_set")
      else
        valueBodyType = I18n.translate("bodies.fat")

      $('#slider_body_type').html(valueBodyType)
      $('.step-nav__item.step-nav__item_4 a').html(valueBodyType)
      $('#what-body_type-input').val(parseInt $('#what-body_type').val())

  $('#gender1').click ->
    $('.step-nav__item.step-nav__item_3 a').html(I18n.translate("gender.female"))
  $('#gender2').click ->
    $('.step-nav__item.step-nav__item_3 a').html(I18n.translate("gender.male"))

  $(".btn.btn_color.block_left").hide() if $(".height").hasClass("current")

  $(".btn.btn_color.block_right").click ->
    $(".current").removeClass("current").hide().next().show().addClass("current")
#    $(".current").removeClass("current").hide().next().slideDown().addClass("current")
    hideButton()

  $(".btn.btn_color.block_left").click ->
    $(".current").removeClass("current").hide().prev().show().addClass "current"
#    $(".current").removeClass("current").hide().prev().slideDown().addClass "current"
    hideButton()

  $('.step-nav__item a').click ->
    this.href = "javascript:void(0)"
    $(".current").removeClass("current").hide()
    id_name = this.id
#    $("." + id_name).slideDown().addClass("current")
    $("." + id_name).show().addClass("current")
    hideButton()


  hideButton = ->
    numberOfQuests()
    if $(".height").hasClass("current")
      $(".btn.btn_color.block_left").hide()
      $(".btn.btn_color.block_right").show()
    else if $(".submit").hasClass("current")
      $('.num_question').hide()
      $(".btn.btn_color.block_right").hide()
      $(".btn.btn_color.block_left").show()
    else
      $(".btn.btn_color.block_right").show()
      $(".btn.btn_color.block_left").show()

  numberOfQuests = ->
    $.each $('form').children(), (index, value) ->
      $('.num_question').text "- " + index + "/6 -" if value.className.indexOf("current") >= 0
      $('.num_question').show()

  initialize = ->
    $('.num_question').text "- 1/6 -"
