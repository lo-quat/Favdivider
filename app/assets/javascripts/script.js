$(document).ready(function(){
    $('.modal').modal();
    const lightbox = lity();
    $('.content>img').click(function(e) {
        if (e.target.src) {
            lightbox(e.target.src);
        }
    });

    $('div.post_users').click(function () {
        location.href = $(this).find('a').attr('href');
    });

    $('.toggle_status').on('click',(function () {
        let id = $(this).data('tweet-id');
        localStorage.setItem('tweet-id',id);
        $.ajax({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
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
document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.autocomplete');
    var instances = M.Autocomplete.init(elems, options);
});

