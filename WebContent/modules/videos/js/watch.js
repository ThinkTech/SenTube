String.prototype.linkify = function() {

    // http://, https://, ftp://
    var urlPattern = /\b(?:https?|ftp):\/\/[a-z0-9-+&@#\/%?=~_|!:,.;]*[a-z0-9-+&@#\/%=~_|]/gim;

    // www. sans http:// or https://
    var pseudoUrlPattern = /(^|[^\/])(www\.[\S]+(\b|$))/gim;

    // Email addresses
    var emailAddressPattern = /[\w.]+@[a-zA-Z_-]+?(?:\.[a-zA-Z]{2,6})+/gim;

    return this.replace(urlPattern, '<a target="_blank" href="$&">$&</a>')
        .replace(pseudoUrlPattern, '$1<a target="_blank" href="http://$2">$2</a>')
        .replace(emailAddressPattern, '<a target="_blank" href="mailto:$&">$&</a>');
};

const display = function(videoId,cache){
	page.language = localStorage.getItem("language") ? localStorage.getItem("language") : "en";
	const video = {};
    const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
	app.get("https://www.googleapis.com/youtube/v3/videos?id="+videoId+"&key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&part=snippet,statistics",function(info){
		video.videoId = videoId;
		video.title = info.items[0].snippet.title;
		document.title = video.title;
		console.log(page.language);
		video.publishedAt = new Date(info.items[0].snippet.publishedAt).toLocaleDateString(page.language,options);
		video.description = info.items[0].snippet.description;
		video.description = video.description.linkify();
		video.viewCount = info.items[0].statistics.viewCount.replace(/\B(?=(\d{3})+\b)/g, ",");
		video.commentCount = info.items[0].statistics.commentCount ? info.items[0].statistics.commentCount.replace(/\B(?=(\d{3})+\b)/g, ",") : 0;
		video.likeCount = info.items[0].statistics.likeCount ? info.items[0].statistics.likeCount.replace(/\B(?=(\d{3})+\b)/g, ",") : "";
		video.dislikeCount = info.items[0].statistics.dislikeCount ? info.items[0].statistics.dislikeCount.replace(/\B(?=(\d{3})+\b)/g, ",") : "";
		if(!cache) getVideos(info.items[0].snippet.channelId);
		getChannelInfo(video,info.items[0].snippet.channelId,cache);
		$(".video-container iframe").attr("src","//www.youtube.com/embed/"+video.videoId+"?enablejsapi=1").show();
		$(document).scroll(function(e){
		    var scrollAmount = $(window).scrollTop();
		    var documentHeight = $(document).height();
		    var scrollPercent = (scrollAmount / documentHeight) * 100;
		    if(scrollPercent > 9 && !video.showComments) {
		    	video.showComments = true;
		    	getComments(video,options);
		    }
		});
	},true);
}; 

const getChannelInfo = function(video,channelId,cache){
	app.get("https://www.googleapis.com/youtube/v3/channels?id="+channelId+"&key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&part=snippet,statistics,brandingSettings",function(result) {
		video.photo = result.items[0].snippet.thumbnails.medium.url;
		video.subscriberCount = result.items[0].statistics.subscriberCount.replace(/\B(?=(\d{3})+\b)/g, ",");
		video.channel = {id : channelId,photo : result.items[0].snippet.thumbnails.medium.url,title : result.items[0].snippet.title,image : result.items[0].brandingSettings.image.bannerImageUrl};
		page.render($(".video-info"),video);
		page.render($(".video-metadata"),video);
		if(!$(".channel").is(":hidden")) {
			$(document).scroll(function(e){
			    var scrollAmount = $(window).scrollTop();
			    var documentHeight = $(document).height();
			    var scrollPercent = (scrollAmount / documentHeight) * 100;
			    if(scrollPercent > 10 && !video.channel.showLatestVideos && !cache) {
			    	video.channel.showLatestVideos = true;
			    	getLatestVideos(video.channel);
			    }
			});
		}
	},true);	
};

const getVideos = function(channelId) {
	var videos = JSON.parse(localStorage.getItem("videos"));
	if(!videos) {
		app.get("https://www.googleapis.com/youtube/v3/search?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&channelId="+channelId+"&type=video&part=snippet&order=viewCount&maxResults=10", function(result) {
			videos = new Array();
			var length = result.items.length, id = "",i;
		    for(i=0;i<length;i++) {
				const item = result.items[i];
				id += i < length-1 ? item.id.videoId +"," : item.id.videoId;
				videos.push({index : i+1,id : item.id.videoId, title : item.snippet.title,channel : item.snippet.channelTitle});
			}
		    var token = result.nextPageToken;
		    app.get("https://www.googleapis.com/youtube/v3/videos?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&id="+id+"&part=contentDetails,statistics", function(result) {
		      length = result.items.length;	
		      for(i=0;i<length;i++) {
		    	const duration = result.items[i].contentDetails.duration.substring(2, result.items[i].contentDetails.duration.length).toLowerCase();
			    const minutes = duration.substring(0, duration.indexOf('m'));
			    const index = duration.indexOf('s');
				const seconds = index > 0 ? duration.substring(duration.indexOf('m')+1, index) : 0;
			    videos[i].duration = (minutes.length  ? minutes : ("0"+minutes)) + " : " + (seconds.length > 1 ? seconds : ("0"+seconds));	
		    	videos[i].viewCount = result.items[i].statistics.viewCount.replace(/\B(?=(\d{3})+\b)/g, ",");
		      }
			  page.render($(".thumbnails"),videos,function(thumbnail) {
				  $("a",thumbnail).click(function(){
					 const id = $(this).attr("id");
					 display(id,true);
					 history.pushState({id:id},null,"videos/watch?v="+id);
					 $('html, body').animate({scrollTop : 0},800);
					 return false;
				  });
				  if(!token || length<10) {
					 $(".thumbnails a.show-more").hide();
				  }else {
					 $(".thumbnails a.show-more").one("click",function(){
						 getMoreVideos(channelId,token);				 
					 });
				  }
			  });
		   },true);
		},true);
	}else {
		if(!$(".thumbnails .thumbnail").length) {
			 page.render($(".thumbnails"),videos,function(thumbnail){
				  $(".thumbnails a.show-more").hide();
				  $("a",thumbnail).click(function(){
					 const id = $(this).attr("id");
					 display(id);
					 history.pushState({id:id},null,"videos/watch?v="+id);
					 $('html, body').animate({scrollTop : 0},800);
					 return false;
				  });
			  });
		}
	}
};

const getMoreVideos = function(channelId,token){
	$(".thumbnails a.show-more").hide();
	$(".thumbnails .load-more").show();
	const index = parseInt($(".thumbnails > div:last .thumbnail span:eq(0)").html());
	app.get("https://www.googleapis.com/youtube/v3/search?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&channelId="+channelId+"&pageToken="+token+"&type=video&part=snippet&order=viewCount&maxResults=10",function(result) {
		const videos = new Array();
		var length = result.items.length, id = "",i;
	    for(i=0;i<length;i++) {
			const item = result.items[i];
			id += i < length-1 ? item.id.videoId +"," : item.id.videoId;
			videos.push({index : index +(i+1), id : item.id.videoId, title : item.snippet.title,channel : item.snippet.channelTitle});
		}
	    if(length==0) {
	    	$(".thumbnails .load-more").hide();
	    	$(".thumbnails a.show-more").hide();
	    	return false;
	    }
	    var newToken = result.nextPageToken;
	    var count = $(".thumbnails .thumbnail").length;
	    app.get("https://www.googleapis.com/youtube/v3/videos?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&id="+id+"&part=contentDetails,statistics", function(result) {
	      length = result.items.length;	
	      for(i=0;i<length;i++) {
	    	const duration = result.items[i].contentDetails.duration.substring(2, result.items[i].contentDetails.duration.length).toLowerCase();
		    const minutes = duration.substring(0, duration.indexOf('m'));
		    const index = duration.indexOf('s');
			const seconds = index > 0 ? duration.substring(duration.indexOf('m')+1, index) : 0;
			videos[i].index = count+(i+1);
		    videos[i].duration = (minutes.length  ? minutes : ("0"+minutes)) + " : " + (seconds.length > 1 ? seconds : ("0"+seconds));	
	    	videos[i].viewCount = result.items[i].statistics.viewCount.replace(/\B(?=(\d{3})+\b)/g, ",");
	      }
	      $(".thumbnails .load-more").hide();
	      if(length) {
		      var container = $("<div/>");
		      $(".thumbnails .load-more").remove();
			  page.render($(".thumbnails"),videos,false,container, function(thumbnail){
				  $("a",thumbnail).click(function(){
					 const id = $(this).attr("id");
					 display(id,true);
					 history.pushState({id:id},null,"videos/watch?v="+id);
					 $('html, body').animate({scrollTop : 0},800);
					 return false;
				  });
				  $("> div",container).insertAfter($(".thumbnails > div:last"));
				  if(newToken) {
					 $(".thumbnails a.show-more").show().one("click",function(){
						 getMoreVideos(channelId,newToken);				 
					 });
				   }
			  });
	      }else {
	    	  $(".thumbnails a.show-more").hide();
	      }
	   },true);
	},true);
};

const getComments = function(video,options){
	app.get("https://www.googleapis.com/youtube/v3/commentThreads?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&videoId="+video.videoId+"&part=snippet,replies&maxResults=3",function(result) {
	  var comments = new Array();
  	  var length = result.items.length;
  	  for(var i=0;i<length;i++) {
  		      const comment = {author : result.items[i].snippet.topLevelComment.snippet.authorDisplayName, 
  			    	  date : new Date(result.items[i].snippet.topLevelComment.snippet.publishedAt).toLocaleDateString(page.language,options),
  			    	  photo : result.items[i].snippet.topLevelComment.snippet.authorProfileImageUrl,
  			    	  text : result.items[i].snippet.topLevelComment.snippet.textDisplay};
  		      const replies = new Array();
  		      if(result.items[i].replies){
  		    	  for(var j =0;j<result.items[i].replies.comments.length;j++) {
  		    		  const reply = {author : result.items[i].replies.comments[j].snippet.authorDisplayName, 
	  			    	  date : new Date(result.items[i].replies.comments[j].snippet.publishedAt).toLocaleDateString(page.language,options),
	  			    	  photo : result.items[i].replies.comments[j].snippet.authorProfileImageUrl,
	  			    	  text : result.items[i].replies.comments[j].snippet.textDisplay};
  		    		  replies.push(reply);
  		    	  }
  		      }
  		      comment.replies = replies; 
		      comments.push(comment);
	  }
  	  var token = result.nextPageToken;
  	  if(!token) video.commentCount = length;
  	  $(".comments-disabled").hide();
	  $(".video-comments").show();
  	  page.render($(".video-comments"),{commentCount : video.commentCount,comments:comments}, function(){
	    	  if(!token) {
	    		  $(".video-comments a.show-more").hide();
	    	  }else {
	    		  $(".video-comments a.show-more").click(function(){
	    			  $(".video-comments a.show-more").hide();
	    			  $(".video-comments .load-more").show();
	    			  app.get("https://www.googleapis.com/youtube/v3/commentThreads?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&videoId="+video.videoId+"&pageToken="+token+"&part=snippet,replies&maxResults=10",function(result) {
	    				  comments = new Array();
				    	  length = result.items.length;
				    	  for(i=0;i<length;i++) {
				  		      const comment = {author : result.items[i].snippet.topLevelComment.snippet.authorDisplayName, 
				  			    	  date : new Date(result.items[i].snippet.topLevelComment.snippet.publishedAt).toLocaleDateString(page.language,options),
				  			    	  photo : result.items[i].snippet.topLevelComment.snippet.authorProfileImageUrl,
				  			    	  text : result.items[i].snippet.topLevelComment.snippet.textDisplay};
				  		      const replies = new Array();
				  		      if(result.items[i].replies){
				  		    	  for(var j =0;j<result.items[i].replies.comments.length;j++) {
				  		    		  const reply = {author : result.items[i].replies.comments[j].snippet.authorDisplayName, 
					  			    	  date : new Date(result.items[i].replies.comments[j].snippet.publishedAt).toLocaleDateString(page.language,options),
					  			    	  photo : result.items[i].replies.comments[j].snippet.authorProfileImageUrl,
					  			    	  text : result.items[i].replies.comments[j].snippet.textDisplay};
				  		    		  replies.push(reply);
				  		    	  }
				  		      }
				  		      comment.replies = replies; 
						      comments.push(comment);
					      }
				    	  token = result.nextPageToken;
				    	  const container = $("<div/>");
				    	  $(".video-comments .load-more").hide();
				    	  page.render($(".video-comments"),{commentCount : video.commentCount,comments:comments},
				    	      false,container, function(){
				    		  $("> .video-comment",container).insertBefore($(".video-comments .load-more"));
				    	  });
				    	  $(".video-comments a.show-more").show();
				    	  if(!token) $(".video-comments a.show-more").hide();
	    			  },true);
	    		  });
	    	  }
  	  });
	  },true, function(data) {
		  $(".video-comments").hide();
		  video.showComments = true;
		  const response = JSON.parse(data.responseText);
		  const code = response.error.code;
		  if(code == "403") $(".comments-disabled").show();
	  });
};

const getLatestVideos = function(channel) {
	app.get("https://www.googleapis.com/youtube/v3/search?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&channelId="+channel.id+"&type=video&part=snippet&order=date&maxResults=12",function(result) {
		const videos = new Array();
		var length = result.items.length, id = "";
	    for(var i=0;i<length;i++) {
			const item = result.items[i];
			id += i < length-1 ? item.id.videoId +"," : item.id.videoId;
			videos.push({index : i+1,id : item.id.videoId, title : item.snippet.title,channel : item.snippet.channelTitle});
		}
	    app.get("https://www.googleapis.com/youtube/v3/videos?key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&id="+id+"&part=contentDetails,statistics",function(result) {
	      length = result.items.length;	
	      for(i=0;i<length;i++) {
	    	const duration = result.items[i].contentDetails.duration.substring(2, result.items[i].contentDetails.duration.length).toLowerCase();
		    const minutes = duration.substring(0, duration.indexOf('m'));
		    const index = duration.indexOf('s');
			const seconds = index > 0 ? duration.substring(duration.indexOf('m')+1, index) : 0;
		    videos[i].duration = (minutes.length  ? minutes : ("0"+minutes)) + " : " + (seconds.length > 1 ? seconds : ("0"+seconds));	
	    	videos[i].viewCount = result.items[i].statistics.viewCount.replace(/\B(?=(\d{3})+\b)/g, ",");
	      }
		  channel.videos = videos;
		  page.render($(".channel"),channel,function(thumbnail){
			  if(channel.image.indexOf("default_banner")!=-1) $(".channel img").remove();
			  $("a",thumbnail).click(function(){
				 const id = $(this).attr("id");
				 display(id,true);
				 history.pushState({id:id},null,"videos/watch?v="+id);
				 $('html, body').animate({scrollTop : 0},800);
				 return false;
			 });
		  });
	   },true);
	},true);	
};
window.addEventListener('popstate', function(e) {
	   const state = e.state;
	   if(state && state.id) {
	       display(state.id,true);
	 	   $('html, body').animate({scrollTop : 0},800);
	   } 
});