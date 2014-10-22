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
    url: "http://morning-springs-9631.herokuapp.com/"
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
    start: 2,
    step: 1,
    connect: "lower",
    range:
      'min': 1,
      'max': 3

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
        valueBodyType = I18n.t("bodies.slim")
      else if (parseInt $('#what-body_type').val()) == 2
        valueBodyType = I18n.t("bodies.normal")
      else
        valueBodyType = I18n.t("bodies.fat")

      $('#slider_body_type').html(valueBodyType)
      $('.step-nav__item.step-nav__item_4 a').html(valueBodyType)
      $('#what-body_type-input').val(parseInt $('#what-body_type').val())

  $('#gender1').click ->
    $('.step-nav__item.step-nav__item_3 a').html(I18n.translate("gender.female"))
  $('#gender2').click ->
    $('.step-nav__item.step-nav__item_3 a').html(I18n.translate("gender.male"))

  $(".btn.btn_color.block_left").hide() if $(".height").hasClass("current")

  $(".btn.btn_color.block_right").click ->
    $(".current").removeClass("current").hide().next().slideDown().addClass("current")
    hideButton()

  $(".btn.btn_color.block_left").click ->
    $(".current").removeClass("current").hide().prev().slideDown().addClass "current"
    hideButton()

  $('.step-nav__item a').click ->
    this.href = "javascript:void(0)"
    $(".current").removeClass("current").hide()
    id_name = this.id
    $("." + id_name).slideDown().addClass("current")
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


########################################################################################################################

#$(document).ready ->
#  locale = window.location.href.toString().split('?locale=')[1]
#  if locale == 'ru'
#    I18n.locale = 'ru'
#  else if locale == 'en'
#    I18n.locale = 'en'
#  else
#    I18n.locale = 'ru'
#
#  $("#height_slider").change ->
#    newValue = $("#height_slider").val()
#    oldValue = $("#height").val()
#    $("#height").val(newValue)
#    #    unless Math.pow((oldValue - newValue), 2) is 1
#    #      oldValue = $("#height").val()
#    if oldValue > newValue
##      $("img").height($("img").height() - 5)
##    else if oldValue == newValue
#      #NOP
#      $("img").height($("img").height() - (oldValue - newValue) * 5)
#    else
#      $("img").height($("img").height() + (newValue - oldValue) * 5)
#
#
#  $("#weight_slider").change ->
#    newValue = $("#weight_slider").val()
#    oldValue = $("#weight").val()
#    $("#weight").val(newValue)
#    if oldValue > newValue
#      $("img").width($("img").width() - (oldValue - newValue) * 3)
#    else
#      $("img").width($("img").width() + (newValue - oldValue) * 3)
#
#  $("#next").click ->
#    $(".notice").hide()
#    current = $(".current").removeClass("current").hide().next().slideDown().addClass("current")
#
#    switch current.attr("id")
#      when "id_height"
#        $("#height").val($("#height_slider").val())
#        document.body.style.backgroundColor = "#E2E2E2"
#        gender = $("input:radio:checked").val()
#        if $("#current_gender").text() is ""
#          $("<p class=\"list\" id=\"current_gender\"> sadf </p>").appendTo $(".result")
#          $("<p class='passed' id='gender_pass'>Ok</p>").appendTo $(".result")
#        if !$("input:radio:checked").val()
#          $("<p class=\"notice\" id=\"current_notice\"> " + I18n.translate("warn.who") + " </p>").appendTo $(".result")
#          $('#gender_pass').removeClass('passed').addClass('failed').text "Fail"
#          $("#current_gender").text I18n.translate("answer.who")
#        else
#          $('#gender_pass').removeClass('failed').addClass('passed').text "Ok"
#          if gender == '1'
#            $("#current_gender").text I18n.translate("answer.male")
#            $("#girl").hide(2000)
#            $("#boy").show(1000)
#          else
#            $("#current_gender").text I18n.translate('answer.female')
#            $("#boy").hide(2000)
#            $("#girl").show(1000)
#
#      when "id_weight"
#        $("#weight").val($("#weight_slider").val())
#        document.body.style.backgroundColor = "#CCCCCC"
#        if $("#current_height").text() is ""
#          $("<p class=\"list\" id=\"current_height\"> Ваш рост " + $("#height").val() + "</p>").appendTo $(".result")
#          $("<p class='passed' id='height_pass'>Ok</p>").appendTo $(".result")
#        if !$("input#height").val()
#          $("<p class=\"notice\" id=\"current_notice\">" + I18n.translate("warn.height") + "</p>").appendTo $(".result")
#          $('#height_pass').removeClass('passed').addClass('failed').text "Fail"
#          $("#current_height").text I18n.translate("answer.height") + $("#height").val()
#        else
#          $('#height_pass').removeClass('failed').addClass('passed').text "Ok"
#          $("#current_height").text I18n.translate("answer.height") + $("#height").val()
#
#      when "id_body_type"
#        $("#normal").off('mouseenter mouseleave');
#        $("#fat").off('mouseenter mouseleave');
#        $("#slim").off('mouseenter mouseleave');
#        document.body.style.backgroundColor = "#B3B3B3"
#        if $("#current_weight").text() is ""
#          $("<p class=\"list\" id=\"current_weight\"> Ваш вес " + $("#weight").val() + "</p>").appendTo $(".result")
#          $("<p class='passed' id='weight_pass'>Ok</p>").appendTo $(".result")
#        if !$("input#weight").val()
#          $("<p class=\"notice\" id=\"current_notice\">" + I18n.translate("warn.weight") + "</p>").appendTo $(".result")
#          $('#weight_pass').removeClass('passed').addClass('failed').text "Fail"
#          $("#current_weight").text I18n.translate("answer.weight") + $("#weight").val()
#        else
#          $('#weight_pass').removeClass('failed').addClass('passed').text "Ok"
#          $("#current_weight").text I18n.translate("answer.weight") + $("#weight").val()
#
#        tip = I18n.translate("suggest")
#        if ($('#height').val() - $('#weight').val()) > 90 and ($('#height').val() - $('#weight').val()) < 110
#          $('#body_type').val(2)
#          $('#normal').hover (-> $(this).append $("<span></span>").text tip), -> $(this).find("span:last").remove()
#          $('#normal').css("background-color", "#eeeeee")
#          $('#fat').css("background-color", "")
#          $('#slim').css("background-color", "")
#        else if ($('#height').val() - $('#weight').val()) < 90
#          $('#body_type').val(3)
#          $('#fat').hover (-> $(this).append $("<span></span>").text tip), -> $(this).find("span:last").remove()
#          $('#fat').css("background-color", "#eeeeee")
#          $('#normal').css("background-color", "")
#          $('#slim').css("background-color", "")
#        else
#          $('#body_type').val(1)
#          $('#slim').hover (-> $(this).append $("<span></span>").text tip), -> $(this).find("span:last").remove()
#          $('#slim').css("background-color", "#eeeeee")
#          $('#normal').css("background-color", "")
#          $('#fat').css("background-color", "")
#
#      when "id_color_hair"
#        document.body.style.backgroundColor = "#999999"
#        if $("#body_type").val() == "1"
#          body = I18n.translate("answer.body") + I18n.translate("bodies.slim")
#        else if  $("#body_type").val() == "2"
#          body = I18n.translate("answer.body") + I18n.translate("bodies.normal")
#        else
#          body = I18n.translate("answer.body") + I18n.translate("bodies.fat")
#        if $("#current_body").text() is ""
#          $("<p class=\"list\" id=\"current_body\"> " + body + "</p>").appendTo $(".result")
#          $("<p class='passed' id='body_pass'>Ok</p>").appendTo $(".result")
#        else
#          $("#current_body").text body
#
#      else
#        document.body.style.backgroundColor = "#9F9F9F"
#        if $("#hair_color").val() == "1"
#          hair = I18n.translate("answer.hair") + I18n.translate("colors.black")
#        else if  $("#hair_color").val() == "2"
#          hair = I18n.translate("answer.hair") + I18n.translate("colors.b_w")
#        else if  $("#hair_color").val() == "3"
#          hair = I18n.translate("answer.hair") + I18n.translate("colors.brown")
#        else if  $("#hair_color").val() == "4"
#          hair = I18n.translate("answer.hair") + I18n.translate("colors.br_w")
#        else if  $("#hair_color").val() == "5"
#          hair = I18n.translate("answer.hair") + I18n.translate("colors.red")
#        else
#          hair = I18n.translate("answer.hair") + I18n.translate("colors.blond")
#        if $("#current_color").text() is ""
#          $("<p class=\"list\" id=\"current_color\"> " + hair + "</p>").appendTo $(".result")
#          $("<p class='passed' id='hair_pass'>Ok</p>").appendTo $(".result")
#        else
#          $("#current_color").text hair
#
#    $("#next").attr "disabled", true if $(".current").hasClass("last")
#    $("#prev").attr "disabled", null
#
#  $("#prev").click ->
#    $("#weight").val($("#weight_slider").val())
#    $("#height").val($("#height_slider").val())
#    $(".current").removeClass("current").hide().prev().slideDown().addClass "current"
#    $("#prev").attr "disabled", true  if $(".current").hasClass("first")
#    $("#next").attr "disabled", null
#    $(".notice").hide()
#


#    singleTitle: "Share it!"
#    zeroes: true
#    forceUpdate: true


#img_height = $("img").height()
#timer = imageGrow = (img_height) ->
#  unless document.getElementById("boy").height is img_height
##    alert(img_height)
#    document.getElementById("boy").height += 1
#    setTimeout(imageGrow(img_height), 10)
#  else
#    clearTimeout timer
#  return

