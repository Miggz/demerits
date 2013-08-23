(function( $ ) {

  function sizeElements(){

    var windowHeight = $(window).height(),
      windowWidth = $(window).width(),
      smallSize = Math.min( windowHeight, windowWidth ),
      tSize = smallSize * 0.65,
      footerHeight = (windowHeight * 0.17) - 20
      ;

    $('.demerit-target').css( "width", tSize );
    $('.demerit-target').css( "height", tSize );
    $('.demerit-target').css( "margin-top", -( tSize / 2 ));
    $('.demerit-target').css( "margin-left", -( tSize / 2));
    $('.demerit-target').css( "border-width", ( tSize / 15));

    $('.demerit-count').css( "height", footerHeight);
    $('.demerit-count').css( "line-height", footerHeight + 'px');
    $('.demerit-count').css( "font-size", footerHeight * 0.8);

  }

  $(function () {
    sizeElements();
  });

  $(window).resize(function() {
    sizeElements();
  });

}( jQuery ));
