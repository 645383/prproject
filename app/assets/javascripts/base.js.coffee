$(document).ready ->
  $("#next").click ->
    current = $(".current").removeClass("current").hide().next().show().addClass("current")
    switch current.attr("id")
      when "id_height"
        if $("#current_gender").text() is ""
          if $("input:radio").is(":checked")
            gender = (if $("input:radio:checked").val() is "male" then "Мужчина" else "Женщина")
            $("<p class=\"list\" id=\"current_gender\"> Вы " + gender + "</p>").appendTo $(".result")
          else
            $("<p class=\"list\" id=\"current_gender\"> Вы " + "?" + "</p>").appendTo $(".result")
        else
          gender = (if $("input:radio:checked").val() is "male" then "Мужчина" else "Женщина")
          $("#current_gender").text "Вы " + gender
      when "id_weight"
        if $("#current_height").text() is ""
          $("<p class=\"list\" id=\"current_height\"> Ваш рост " + $("#height").val() + "</p>").appendTo $(".result")
        else
          $("#current_height").text "Ваш рост " + $("#height").val()
      when "id_body_type"
        if $("#current_weight").text() is ""
          $("<p class=\"list\" id=\"current_weight\"> Ваш вес " + $("#weight").val() + "</p>").appendTo $(".result")
        else
          $("#current_weight").text "Ваш вес " + $("#weight").val()
      when "id_color_heir"
        if $("#current_body").text() is ""
          $("<p class=\"list\" id=\"current_body\"> Ваше телосложение " + $("#body_type").val() + "</p>").appendTo $(".result")
        else
          $("#current_body").text "Ваше телосложение " + $("#body_type").val()
      else
        if $("#current_color").text() is ""
          $("<p class=\"list\" id=\"current_color\"> Цвет ваших волос " + $("#hair_color").val() + "</p>").appendTo $(".result")
        else
          $("#current_color").text "Цвет ваших волос " + $("#hair_color").val()
    $("#next").attr "disabled", true  if $(".current").hasClass("last")
    $("#prev").attr "disabled", null

  $("#prev").click ->
    $(".current").removeClass("current").hide().prev().show().addClass "current"
    $("#prev").attr "disabled", true  if $(".current").hasClass("first")
    $("#next").attr "disabled", null

