<div>
 <div class="video-player">
  
  <div class="video-container">
     <iframe id="player" style="display:none" width="853" height="200" frameborder="0" allowfullscreen></iframe>
  </div>
  
   <div class="video-info">
     <template type="text/x-dust-template">
  	   <h1 title="{title}"><i class="fa fa-play"></i> {title}</h1>
  	   <div class="photo">
  	    <img src="{photo}"/>
  	   </div>
  	 <div class="author">
  	     <a>{channel.title}</a><br>
  	     <div class="subscribe">
  	     <span class="subscribe-button" data-translation="subscribe"></span>
  	     <span class="subscribe-count" title="{subscriberCount}">{subscriberCount}</span>
  	     </div>
  	 </div>
  	 <div class="views">
  	      <h1>{viewCount} <span data-translation="views"></span></h1>
  	      <div>
  	      <span class="like">{likeCount}</span>
  	      <span class="dislike">{dislikeCount}</span>
  	      </div>
  	 </div>
  	 </template>
  </div>
  
  
  <div class="video-metadata">
    <template type="text/x-dust-template">
  	 <h1><span data-translation="published-on"></span> {publishedAt}</h1>
  	 <p>{description|s}</p>
  	</template>
  </div>
  
  <div class="video-comments">
    <template type="text/x-dust-template">
  	 <h1><span data-translation="comments"></span> - {commentCount}</h1>
  	 <div class="input">
  	   <img src="${images}/user-64.png"/>
  	   <textarea data-translation="add-comment"></textarea>
  	 </div>
  	 <select>
  	    <option data-translation="top-comments"></option>
  	    <option data-translation="newest"></option>
  	 </select>
  	 {#comments}
  	 <div class="video-comment">
  	     <img src="{photo}"/>
  	     <div>
  	        <span>{author} <span>{date}</span></span>
         	<p>{text|s}</p>
         	<div>
         	  <a data-translation="reply"></a>
         	  <span class="like">{likeCount}</span>
  	      	  <span class="dislike">{dislikeCount}</span>
         	</div>
         	<hr/>
         	{#replies}
		  	 <div class="video-comment">
		  	     <img src="{photo}"/>
		  	     <div>
		  	        <span>{author} <span>{date}</span></span>
		         	<p>{text|s}</p>
		         	<div>
		         	  <a data-translation="reply"></a>
		         	  <span class="like">{likeCount}</span>
		  	      	  <span class="dislike">{dislikeCount}</span>
		         	</div>
		         </div>
		  	 </div>
  	       {/replies}
         </div>
  	 </div>
  	 {/comments}
  	 <div class="load-more"><span data-translation="loading-comments"></span></div>
  	  <a class="show-more" data-translation="show-more"></a>
  	</template>
  </div>
  
  <div class="comments-disabled"><span data-translation="comments-disabled"></span></div>
  
  <div class="channel">
    <template type="text/x-dust-template">
      <div class="photo">
  	    <img src="{photo}"/>
  	   </div>
  	  <h1>{title}</h1>
      <div class="image-card">
      	<img src="{image}"/>
      </div>
      <h1 data-translation="latest"></h1>
      <div class="videos">
       {#videos}
	    <div class="video">
		  <a id="{id}" title="{title}">
		   <div class="thumbnail">
		      <img src="https://i.ytimg.com/vi/{id}/mqdefault.jpg"/>  		   	     
		     <span class="duration">{duration}</span>
		   </div>  		   
		   <div class="description">
		   	<p class="view-count"><span>{viewCount}</span> <span data-translation="views"></span></p>
		    <p class="title"><span>{title}</span></p>
		   </div>
		 </a>
	    </div>
	  {/videos}	
	 </div>
    </template>	   
  </div> 
  
  </div>
  
  <div class="thumbnails">
    <template type="text/x-dust-template">
      <h1><span data-translation="up-next"></span> <i class="fa fa-step-forward"></i></h1>
      <span><i class="fa fa-play"></i> <span data-translation="autoplay"></span>
       <div class="autoplay">  
      <input type="checkbox" value="None" id="autoplay" name="check" checked />
      <label for="autoplay"></label>
    </div>
      </span>
       {#.}
  		<div>
  		  <a id="{id}" title="{title}">
  		   <div class="thumbnail" style="background-image:url(https://i.ytimg.com/vi/{id}/mqdefault.jpg);background-position:center;background-size:contain;background-repeat:no-repeat;background-color:#000">
  		     <span class="index">{index}</span>  		   
  		     <span>{duration}</span>
  		   </div>  		   
  		   <div class="description">
  		     <span>{title}</span>
  		     <span>{channel}</span>
  		     <span>{viewCount}</span>
  		     <span data-translation="views"></span>
  		   </div>
  		 </a>
       </div>
       {/.}
      <div class="load-more"><span data-translation="loading-videos"></span></div>
      <a class="show-more" data-translation="show-more"></a>
    </template>
  </div>
  
 </div>

 <!-- watch js file include -->
 
 <script src="${js}/watch.js"></script> 
 
<script>
document.addEventListener("DOMContentLoaded", () => {
   if("${id}"!= "videos") {
	   localStorage.removeItem("videos");
   	   display("${id}");
   }else {
	   var videos = JSON.parse(localStorage.getItem("videos"));
	   display(videos[0].id);
   }
});
</script> 