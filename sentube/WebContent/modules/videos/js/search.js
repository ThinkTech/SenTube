const search = query => {
	app.get("https://www.googleapis.com/youtube/v3/search?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&q="+query+"&type=video&part=snippet&order=date&maxResults=50",result => {
		const videos = new Array();
		var length = result.items.length, id = "",i;
		const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
	    for(i=0;i<length;i++) {
			const item = result.items[i];
			id += i < length-1 ? item.id.videoId +"," : item.id.videoId;
			const video = {id : item.id.videoId, title : item.snippet.title,channel : item.snippet.channelTitle};
			video.index = i+1;
			video.publishedAt = new Date(item.snippet.publishedAt).toLocaleDateString("en-US",options);	
			video.description = item.snippet.description;
			videos.push(video);
		}
		app.get("https://www.googleapis.com/youtube/v3/videos?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&id="+id+"&part=contentDetails,statistics", result => {
			for(i=0;i<length;i++) {
				if(result.items[i]) {
		   	 		const duration = result.items[i].contentDetails.duration.substring(2, result.items[i].contentDetails.duration.length).toLowerCase();
		    		const minutes = duration.substring(0, duration.indexOf('m'));
		    		const index = duration.indexOf('s');
					const seconds = index > 0 ? duration.substring(duration.indexOf('m')+1, index) : 0;
		    		videos[i].duration = (minutes.length  ? minutes : ("0"+minutes)) + " : " + (seconds.length > 1 ? seconds : ("0"+seconds));
		    		videos[i].viewCount = result.items[i].statistics.viewCount.replace(/\B(?=(\d{3})+\b)/g, ",");
				}
	    	}
	   	 	const div = $(".videos");
	   	 	const limit = 10;
		    page.render(div,{count : length,videos : videos.slice(0,limit)},() => {
		    	div.fadeTo(1000,1);
		    	$("button",div).click(() => $(".filters",div).toggle());
		    	const pager = $(".pager",div);
		    	const pages = length/10;
		    	for(i=0;i<pages;i++) {
		    		const link = $("<a/>").html(i+1);
		    		pager.append(link);
		    		if(i==0) link.addClass("active");
		    		link.bind("click",{index : i},function(event){
		    			const index = event.data.index;
		    			if(!$(this).hasClass("active")) {
		    				$("a",pager).removeClass("active");
		    				$(this).addClass("active");
		    				const container = $("<div/>");
		    				$('html, body').animate({scrollTop : 0},800,() => {
		    					page.render(div,{videos : videos.slice((index*limit),((index+1)*limit))},false,container,() => {
			    	    	    	$(".video",div).remove();
			    	    	    	$(".video",container).insertBefore(pager);
			    	    	    });
		    				});
		    			}
		    		});
		    	}
		    });
		},true);
	},true);
	$("#search input[type=text]").val(query);
};