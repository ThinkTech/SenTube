const toggleAside = function() {
    $("aside").addClass("toggled").toggle();
    return false;
};
     
const showMainFull = function() {
	const aside = $("aside"); 
	const main = $("main");
	const width = window.innerWidth;
	if(main.hasClass("full")) {
	    main.removeClass("full");
	    if(width>991) {
	 	  aside.show();
	    }else {
		 aside.addClass("toggled").toggle();
	    }
	}else {
		if(width>991) {
			aside.hide();
			$("main").addClass("full");
		}else {
			aside.addClass("toggled").toggle();
		}
	}
	return false;
};

 jQuery(function($){

	//Body click event
	
	$("body").click(function(event){
		const aside = $("aside");
		if(!$("button.aside-toggle").is($(event.target)) && !$("button.aside-toggle span.icon-bar").is($(event.target)) && aside.hasClass("toggled")) aside.hide();
	});
	
	//Check to see if the window is top if not then display button
	
	$(window).scroll(function(){
	  if ($(this).scrollTop() > 300) {
	    $('.scrollToTop').fadeIn();
	  } else {
	    $('.scrollToTop').fadeOut();
	  }
	});
	 
	//Click event to scroll to top
	
	$('.scrollToTop').click(function(){
	  $('html, body').animate({scrollTop : 0},800);
	  return false;
	});
	
	//Change event to retranslate the page
	
	$("div.language select").on("change",function(){
		page.retranslate($(this).val());
	});
	
	//search form
	
	const searchForm = $("#search");
	searchForm.submit(function(event){
		const input = $('input',searchForm);
        const val = input.val();
		if(val.trim() == '') {
			const message = i18n("enter-search");
			alert(message,function(){
				input.focus();
			});
		    return false;
		}
	});
	

});