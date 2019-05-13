$('div.well-sm').click(function () {
    location.href = $(this).find('a').attr('href');
});