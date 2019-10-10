$(document).ready(function(){
    $('#tweets').infiniteScroll({
        path: 'nav.pagination a[rel=next]',
        append: '.tweet',
        prefill: true,
        history: false,
        hideNav: '.pagination'
    });
    $('.modal').modal();
    $('select').formSelect();
    const lightbox = lity();
    $('.content>img').click(function(e) {
        if (e.target.src) {
            lightbox(e.target.src);
        }
    });

    $('div.post_users').click(function () {
        location.href = $(this).find('a').attr('href');
    });
});

document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.sidenav');
    var instances = M.Sidenav.init(elems, {});
});

