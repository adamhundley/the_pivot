var i = 1

if (i++ < 5) {
$(document).on('click', '.another-pic', function (e) {
    e.preventDefault();

    $('.image-upload').parent('div.parent').append($('.parent').children('

    ').html());
});
} else {
  $(document).off('click', ".another-pic")
};
