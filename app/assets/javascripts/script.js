$(document).ready(function(){

    $('div.post_users').click(function () {
        location.href = $(this).find('a').attr('href');
    });

    $('.toggle_status').on('click',(function () {
        let id = $(this).data('tweet-id');
        localStorage.setItem('tweet-id',id);
        $.ajax({
            url: `/tweets/${id}/clip`,
            type: 'PATCH',
            dataType: 'json'
        }).done((data)=>{
            console.log(data);
            if(data.status==='default'){
                $(this).css('filter','opacity(100%)');
                console.log('unclip');
            }else{
                $(this).css('filter','opacity(20%)');
                console.log('clip');
            }
        });
    }));
});



