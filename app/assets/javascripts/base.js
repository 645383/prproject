$(document).ready(function () {
    $('#next').click(function () {
        var current = $('.current').removeClass('current').hide()
            .next().show().addClass('current');

        switch (current.attr('id')) {
            case "id_height":
                $('<p>' + $("input:radio:checked").val() + '</p>').appendTo($('#q'))
                break
            case 'id_weight':
                $('<p>' + $('#height').val() + '</p>').appendTo($('#q'))
                break
            case "id_bidy_type":
                $('<p>' + $('#weight').val() + '</p>').appendTo($('#q'))
                break
            case "id_color_heir":
                $('<p>' + $('#body_type').val() + '</p>').appendTo($('#q'))
                break
            default :
                $('<p>' + $('#hair_color').val() + '</p>').appendTo($('#q'))
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

