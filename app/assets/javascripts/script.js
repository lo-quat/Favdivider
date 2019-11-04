document.addEventListener('turbolinks:load', function(){
    $('#tweets').infiniteScroll({
        path: 'nav.pagination a[rel=next]',
        append: '.tweet',
        prefill: true,
        history: false,
        hideNav: '.pagination',
        onInit: function() {
            this.on( 'append', function() {
                $('.popup-image').magnificPopup({
                    delegate : 'a',
                    type : 'image',
                    mainClass : 'mfp-img-mobile',
                    gallery : {
                        enabled : true, // ギャラリー表示を有効化
                        navigateByImgClick : true, // 画像クリックで次画像へ遷移
                        preload : [ 0, 1 ] // いっこ前(0)と後(1)を事前読み込み
                    },
                    image : {
                        verticalFit : true // ブラウザ縦幅に合わせる
                    }
                });
                $('.popup-movie').magnificPopup({
                    type : 'iframe',
                    mainClass : 'mfp-img-mobile',
                });
            });
        }
    });
    $('.sidenav').sidenav();
    $('.modal').modal();
    $('select').formSelect();

    $('div.post_users').click(function () {
        location.href = $(this).find('a').attr('href');
    });
    $('.popup-image').magnificPopup({
        delegate : 'a',
        type : 'image',
        mainClass : 'mfp-img-mobile',
        gallery : {
            enabled : true, // ギャラリー表示を有効化
            navigateByImgClick : true, // 画像クリックで次画像へ遷移
            preload : [ 0, 1 ] // いっこ前(0)と後(1)を事前読み込み
        },
        image : {
            verticalFit : true // ブラウザ縦幅に合わせる
        }
    });
    $('.popup-movie').magnificPopup({
        type : 'iframe',
        mainClass : 'mfp-img-mobile',
    });
});

document.addEventListener('turbolinks:before-visit', function() {
    elem = document.querySelector('#slide-out');
    instance = M.Sidenav.getInstance(elem);
    if (instance){
        instance.destroy();
    }
});

