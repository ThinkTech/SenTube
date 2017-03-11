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
  	     <span class="subscribe-button">Subscribe</span>
  	     <span class="subscribe-count" title="{subscriberCount}">{subscriberCount}</span>
  	     </div>
  	 </div>
  	 <div class="views">
  	      <h1>{viewCount} views</h1>
  	      <div>
  	      <span class="like">{likeCount}</span>
  	      <span class="dislike">{dislikeCount}</span>
  	      </div>
  	 </div>
  	 </template>
  </div>
  
  
  <div class="video-metadata">
    <template type="text/x-dust-template">
  	 <h1>Published on {publishedAt}</h1>
  	 <p>{description|s}</p>
  	</template>
  </div>
  
  <div class="video-comments">
    <template type="text/x-dust-template">
  	 <h1>COMMENTS - {commentCount}</h1>
  	 <div class="input">
  	   <img src="${images}/user-64.png"/>
  	   <textarea placeholder="Add a public comment..."></textarea>
  	 </div>
  	 <select>
  	    <option>Top Comments</option>
  	    <option>Newest first</option>
  	 </select>
  	 {#comments}
  	 <div class="video-comment">
  	     <img src="{photo}"/>
  	     <div>
  	        <span>{author} <span>{date}</span></span>
         	<p>{text|s}</p>
         	<div>
         	  <a>Reply</a>
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
		         	  <a>Reply</a>
		         	  <span class="like">{likeCount}</span>
		  	      	  <span class="dislike">{dislikeCount}</span>
		         	</div>
		         </div>
		  	 </div>
  	       {/replies}
         </div>
  	 </div>
  	 {/comments}
  	 <div class="load-more"><span>loading more comments...</span></div>
  	  <a class="show-more">Show more</a>
  	</template>
  </div>
  
  <div class="comments-disabled"><span>Comments are disabled for this video.</span></div>
  
  <div class="channel">
    <template type="text/x-dust-template">
      <div class="photo">
  	    <img src="{photo}"/>
  	   </div>
  	  <h1>{title}</h1>
      <div class="image-card">
      	<img src="{image}"/>
      </div>
      <h1>Latest Videos</h1>
      <div class="videos">
       {#videos}
	    <div class="video">
		  <a id="{id}" title="{title}">
		   <div class="thumbnail">
		      <img src="https://i.ytimg.com/vi/{id}/mqdefault.jpg"/>  		   	     
		     <span class="duration">{duration}</span>
		   </div>  		   
		   <div class="description">
		   	<p class="view-count"><span>{viewCount} views</span></p>
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
      <h1>Up next <i class="fa fa-step-forward"></i></h1>
      <span><i class="fa fa-play"></i> Autoplay
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
  		     <span>{viewCount} views</span>
  		   </div>
  		 </a>
       </div>
       {/.}
      <div class="load-more"><span>loading more videos...</span></div>
      <a class="show-more">Show more</a>
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