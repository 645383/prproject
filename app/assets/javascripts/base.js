$(document).ready(function () {
    $('#next').click(function () {
        var current = $('.current').removeClass('current').hide()
            .next().show().addClass('current');
        switch (current.attr('id')) {
            case "id_height":
                if ($('#current_gender').text() == '') {
                    if ($('input:radio').is(':checked')) {
                        var gender = $("input:radio:checked").val() == 'male' ? 'Мужчина' : 'Женщина'
                        $('<p class="list" id="current_gender"> Вы ' + gender + '</p>').appendTo($('.result'))
                    } else {
                        $('<p class="list" id="current_gender"> Вы ' + '?' + '</p>').appendTo($('.result'))
                    }
                } else {
                    var gender = $("input:radio:checked").val() == 'male' ? 'Мужчина' : 'Женщина'
                    $('#current_gender').text('Вы ' + gender)
                }
                break
            case 'id_weight':
                if ($('#current_height').text() == '') {
                    $('<p class="list" id="current_height"> Ваш рост ' + $('#height').val() + '</p>').appendTo($('.result'))
                } else {
                    $('#current_height').text('Ваш рост ' + $('#height').val())
                }
                break
            case "id_body_type":
                if ($('#current_weight').text() == '') {
                    $('<p class="list" id="current_weight"> Ваш вес ' + $('#weight').val() + '</p>').appendTo($('.result'))
                } else {
                    $('#current_weight').text('Ваш вес ' + $('#weight').val())
                }
                break
            case "id_color_heir":
                if ($('#current_body').text() == '') {
                    $('<p class="list" id="current_body"> Ваше телосложение ' + $('#body_type').val() + '</p>').appendTo($('.result'))
                } else {
                    $('#current_body').text('Ваше телосложение ' + $('#body_type').val())
                }
                break
            default :
                if ($('#current_color').text() == '') {
                    $('<p class="list" id="current_color"> Цвет ваших волос ' + $('#hair_color').val() + '</p>').appendTo($('.result'))
                } else {
                    $('#current_color').text('Цвет ваших волос ' + $('#hair_color').val())
                }
        }

        if ($('.current').hasClass('last')) {
            $('#next').attr('disabled', true);
        }
        $('#prev').attr('disabled', null);
    });

    $('#prev').click(function () {
        $('.current').removeClass('current').hide()
            .prev().show().addClass('current');
        if ($('.current').hasClass('first')) {
            $('#prev').attr('disabled', true);
        }
        $('#next').attr('disabled', null);
    });
})

