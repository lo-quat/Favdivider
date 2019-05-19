$('div.post_users').click(function () {
    location.href = $(this).find('a').attr('href');
});

$('.toggle_status').click(function () {
    let id = $(this).data('tweet-id');
    let status = $(this).data('status');
    console.log(status);
});

if(status){
    $(this).addClass('cliped');
}else{
    $(this).removeClass('cliped');
}
$.ajax({
    url: `/tweets/${id}/clip`,
    type: 'PATCH',
    data: id
})
