$(document).ready(function(){
    $('div.post_users').click(function () {
        location.href = $(this).find('a').attr('href');
    });

    $('.toggle_status').on('click',(function () {
        console.log("cliked");
        let id = $(this).data('tweet-id');
        $(this).toggleClass('cliped');
        $.ajax({
            url: `/tweets/${id}/clip`,
            type: 'PATCH',
            data: id
        });
    }));
});




