$('div.post_users').click(function () {
    location.href = $(this).find('a').attr('href');
});