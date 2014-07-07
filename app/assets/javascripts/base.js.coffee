$(document).ready ->
  locale = window.location.href.toString().split('?locale=')[1]
  if locale == 'ru'
    I18n.locale = 'ru'
  else if locale == 'en'
    I18n.locale = 'en'
  else
    I18n.locale = 'ru'

  $("#height_slider").change ->
    newValue = $("#height_slider").val()
    oldValue = $("#height").val()
    $("#height").val(newValue)
    #    unless Math.pow((oldValue - newValue), 2) is 1
    #      oldValue = $("#height").val()
    if oldValue > newValue
#      $("img").height($("img").height() - 5)
#    else if oldValue == newValue
      #NOP
      $("img").height($("img").height() - (oldValue - newValue) * 5)
    else
      $("img").height($("img").height() + (newValue - oldValue) * 5)


  $("#weight_slider").change ->
    newValue = $("#weight_slider").val()
    oldValue = $("#weight").val()
    $("#weight").val(newValue)
    if oldValue > newValue
      $("img").width($("img").width() - (oldValue - newValue) * 3)
    else
      $("img").width($("img").width() + (newValue - oldValue) * 3)

  $("#next").click ->
    $(".notice").hide()
    current = $(".current").removeClass("current").hide().next().slideDown().addClass("current")

    switch current.attr("id")
      when "id_height"
        $("#height").val($("#height_slider").val())
        document.body.style.backgroundColor = "#E2E2E2"
        gender = $("input:radio:checked").val()
        if $("#current_gender").text() is ""
          $("<p class=\"list\" id=\"current_gender\"> sadf </p>").appendTo $(".result")
          $("<p class='passed' id='gender_pass'>Ok</p>").appendTo $(".result")
        if !$("input:radio:checked").val()
          $("<p class=\"notice\" id=\"current_notice\"> " + I18n.translate("warn.who") + " </p>").appendTo $(".result")
          $('#gender_pass').removeClass('passed').addClass('failed').text "Fail"
          $("#current_gender").text I18n.translate("answer.who")
        else
          $('#gender_pass').removeClass('failed').addClass('passed').text "Ok"
          if gender == '1'
            $("#current_gender").text I18n.translate("answer.male")
            $("#girl").hide(2000)
            $("#boy").show(1000)
          else
            $("#current_gender").text I18n.translate('answer.female')
            $("#boy").hide(2000)
            $("#girl").show(1000)

      when "id_weight"
        $("#weight").val($("#weight_slider").val())
        document.body.style.backgroundColor = "#CCCCCC"
        if $("#current_height").text() is ""
          $("<p class=\"list\" id=\"current_height\"> Ваш рост " + $("#height").val() + "</p>").appendTo $(".result")
          $("<p class='passed' id='height_pass'>Ok</p>").appendTo $(".result")
        if !$("input#height").val()
          $("<p class=\"notice\" id=\"current_notice\">" + I18n.translate("warn.height") + "</p>").appendTo $(".result")
          $('#height_pass').removeClass('passed').addClass('failed').text "Fail"
          $("#current_height").text I18n.translate("answer.height") + $("#height").val()
        else
          $('#height_pass').removeClass('failed').addClass('passed').text "Ok"
          $("#current_height").text I18n.translate("answer.height") + $("#height").val()

      when "id_body_type"
        $("#normal").off('mouseenter mouseleave');
        $("#fat").off('mouseenter mouseleave');
        $("#slim").off('mouseenter mouseleave');
        document.body.style.backgroundColor = "#B3B3B3"
        if $("#current_weight").text() is ""
          $("<p class=\"list\" id=\"current_weight\"> Ваш вес " + $("#weight").val() + "</p>").appendTo $(".result")
          $("<p class='passed' id='weight_pass'>Ok</p>").appendTo $(".result")
        if !$("input#weight").val()
          $("<p class=\"notice\" id=\"current_notice\">" + I18n.translate("warn.weight") + "</p>").appendTo $(".result")
          $('#weight_pass').removeClass('passed').addClass('failed').text "Fail"
          $("#current_weight").text I18n.translate("answer.weight") + $("#weight").val()
        else
          $('#weight_pass').removeClass('failed').addClass('passed').text "Ok"
          $("#current_weight").text I18n.translate("answer.weight") + $("#weight").val()

        tip = I18n.translate("suggest")
        if ($('#height').val() - $('#weight').val()) > 90 and ($('#height').val() - $('#weight').val()) < 110
          $('#body_type').val(2)
          $('#normal').hover (-> $(this).append $("<span></span>").text tip), -> $(this).find("span:last").remove()
          $('#normal').css("background-color", "#eeeeee")
          $('#fat').css("background-color", "")
          $('#slim').css("background-color", "")
        else if ($('#height').val() - $('#weight').val()) < 90
          $('#body_type').val(3)
          $('#fat').hover (-> $(this).append $("<span></span>").text tip), -> $(this).find("span:last").remove()
          $('#fat').css("background-color", "#eeeeee")
          $('#normal').css("background-color", "")
          $('#slim').css("background-color", "")
        else
          $('#body_type').val(1)
          $('#slim').hover (-> $(this).append $("<span></span>").text tip), -> $(this).find("span:last").remove()
          $('#slim').css("background-color", "#eeeeee")
          $('#normal').css("background-color", "")
          $('#fat').css("background-color", "")

      when "id_color_hair"
        document.body.style.backgroundColor = "#999999"
        if $("#body_type").val() == "1"
          body = I18n.translate("answer.body") + I18n.translate("bodies.slim")
        else if  $("#body_type").val() == "2"
          body = I18n.translate("answer.body") + I18n.translate("bodies.normal")
        else
          body = I18n.translate("answer.body") + I18n.translate("bodies.fat")
        if $("#current_body").text() is ""
          $("<p class=\"list\" id=\"current_body\"> " + body + "</p>").appendTo $(".result")
          $("<p class='passed' id='body_pass'>Ok</p>").appendTo $(".result")
        else
          $("#current_body").text body

      else
        document.body.style.backgroundColor = "#9F9F9F"
        if $("#hair_color").val() == "1"
          hair = I18n.translate("answer.hair") + I18n.translate("colors.black")
        else if  $("#hair_color").val() == "2"
          hair = I18n.translate("answer.hair") + I18n.translate("colors.b_w")
        else if  $("#hair_color").val() == "3"
          hair = I18n.translate("answer.hair") + I18n.translate("colors.brown")
        else if  $("#hair_color").val() == "4"
          hair = I18n.translate("answer.hair") + I18n.translate("colors.br_w")
        else if  $("#hair_color").val() == "5"
          hair = I18n.translate("answer.hair") + I18n.translate("colors.red")
        else
          hair = I18n.translate("answer.hair") + I18n.translate("colors.blond")
        if $("#current_color").text() is ""
          $("<p class=\"list\" id=\"current_color\"> " + hair + "</p>").appendTo $(".result")
          $("<p class='passed' id='hair_pass'>Ok</p>").appendTo $(".result")
        else
          $("#current_color").text hair

    $("#next").attr "disabled", true if $(".current").hasClass("last")
    $("#prev").attr "disabled", null

  $("#prev").click ->
    $("#weight").val($("#weight_slider").val())
    $("#height").val($("#height_slider").val())
    $(".current").removeClass("current").hide().prev().slideDown().addClass "current"
    $("#prev").attr "disabled", true  if $(".current").hasClass("first")
    $("#next").attr "disabled", null
    $(".notice").hide()

  $(".social-likes").socialLikes
    url: "http://auto.ria.ua"
    counters: true
    zeroes: true


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

