<div class="page-title">
<a data-translation="search-results"></a>
</div>
<div class="search-results">
<div class="videos">
 <template type="text/x-dust-template">
  <span class="result-count">{count} <span data-translation="results"></span></span>
  {#videos}
    <div class="video">
	  <a href="watch?v={id}">
	   <div class="thumbnail">
	     <img src="https://i.ytimg.com/vi/{id}/mqdefault.jpg"/>  
	     <span class="index">{index}</span>  		   	     
	     <span class="duration">{duration}</span>
	   </div>  		   
	   <div class="description">
	    <p class="title"><span>{title}</span></p>
	    <p class="channel"><span>{channel}</span></p>
	   	<p><span class="publishedAt">{publishedAt}</span> - <span class="view-count">{viewCount} views</span></p>
	   	<p class="video-description"><span>{description}</span></p>
	   </div>
	 </a>
    </div>
  {/videos}
  <div class="pager">
  </div>
  </template>	
 </div>
 </div>
 <!-- search js file include -->
 
 <script src="${js}/search.js"></script>
  
 <script>
document.addEventListener("DOMContentLoaded", function() {
	search("${query}");
});
 </script> 