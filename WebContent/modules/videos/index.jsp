<div class="page-title">
<a>Music</a>
</div>
<div>
<div class="videos">
 <template type="text/x-dust-template">
 <h1><i class="fa fa-music"></i> {title}<a title="Previous" class="video-nav-left" href="#"><i class="fa fa-angle-left"></i></a><a title="Next" class="video-nav-right" href="#"><i class="fa fa-angle-right"></i></a></h1>
 <span class="actions">
 <select>
  	<option>All</option>
  	<option>New</option>
  </select>
 <a href="videos/watch?v=videos" class="playall" title="Play all" href="#"><i class="fa fa-play"></i></a></span>
 <span class="status">1/21</span>
  {#videos}
    <div class="video">
	  <a href="videos/watch?v={id}" title="{title}">
	   <div class="thumbnail"> 		
	     <img src="https://i.ytimg.com/vi/{id}/mqdefault.jpg"/>  
	     <span class="index">{index}</span> 	     
	     <span class="duration">{duration}</span>
	   </div>  		   
	   <div class="description">
	   	<p class="view-count"><span>{viewCount} views</span></p>
	    <p class="title"><span>{title}</span></p>
	   </div>
	 </a>
    </div>
  {/videos}
  </template>	
 </div>
 
 <div class="videos">
 <template type="text/x-dust-template">
 <h1><i class="fa fa-globe"></i> {title}<a title="Previous" class="video-nav-left" href="#"><i class="fa fa-angle-left"></i></a><a title="Next" class="video-nav-right" href="#"><i class="fa fa-angle-right"></i></a></h1>
 <span class="actions">
 <select>
    <option>All</option>
  	<option>New</option>
  </select>
 <a href="videos/watch?v=videos" class="playall" title="Play all" href="#"><i class="fa fa-play"></i></a></span>
 <span class="status">1/21</span>
  {#videos}
    <div class="video">
	  <a href="videos/watch?v={id}" title="{title}">
	   <div class="thumbnail">
	     <img src="https://i.ytimg.com/vi/{id}/mqdefault.jpg"/>
	      <span class="index">{index}</span>   		   	     
	     <span class="duration">{duration}</span>
	   </div>  		   
	   <div class="description">
	   	<p class="view-count"><span>{viewCount} views</span></p>
	    <p class="title"><span>{title}</span></p>
	   </div>
	 </a>
    </div>
  {/videos}
  </template>	
 </div>
 </div>
 
  <!-- index js file include -->
 
 <script src="${js}/index.js"></script>