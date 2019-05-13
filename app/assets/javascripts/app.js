$('div.well').click(function () {
    location.href = $(this).find('a').attr('href');
});