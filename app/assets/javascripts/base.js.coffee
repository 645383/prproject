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
    $("#height").val(newValue)

  $("#weight_slider").change ->
    newValue = $("#weight_slider").val()
    $("#weight").val(newValue)

  $("#next").click ->
    $(".notice").hide()
    current = $(".current").removeClass("current").hide().next().show().addClass("current")

    switch current.attr("id")
      when "id_height"
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
          else
            $("#current_gender").text I18n.translate('answer.female')

      when "id_weight"
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

      when "id_color_hair"
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

    $("#next").attr "disabled", true  if $(".current").hasClass("last")
    $("#prev").attr "disabled", null

  $("#prev").click ->
    $(".current").removeClass("current").hide().prev().show().addClass "current"
    $("#prev").attr "disabled", true  if $(".current").hasClass("first")
    $("#next").attr "disabled", null
    $(".notice").hide()