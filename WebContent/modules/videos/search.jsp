<div class="page-title">
<a>Search Results</a>
</div>
<div class="search-results">
<div class="videos">
 <template type="text/x-dust-template">
  <button type="button">Filters <i class="fa fa-angle-down"></i></button>
  <span class="result-count">About {count} results</span>
  <div class="filters">
     <div class="filter-col">
        <h4>Upload date</h4>
        <ul>
          <li><a>Last hour</a></li>
          <li><a>Today</a></li>
          <li><a>This week</a></li>
          <li><a>This month</a></li>
          <li><a>This year</a></li>
        </ul>
     </div>
     <div class="filter-col">
        <h4>Type</h4>
        <ul>
          <li><a>Video</a></li>
          <li><a>Channel</a></li>
          <li><a>Playlist</a></li>
          <li><a>Movie</a></li>
          <li><a>Show</a></li>
        </ul>
     </div>
     <div class="filter-col">
        <h4>Duration</h4>
        <ul>
          <li><a>Short (&lt; 4 minutes)</a></li>
          <li><a>Long (&gt; 20 minutes)</a></li>
        </ul>
     </div>
     <div class="filter-col">
        <h4>Features</h4>
        <ul>
          <li><a>4K</a></li>
          <li><a>HD</a></li>
          <li><a>Subtitles/CC</a></li>
          <li><a>Creative Commons</a></li>
          <li><a>3D</a></li>
          <li><a>Live</a></li>
          <li><a>Purchased</a></li>
          <li><a>360°</a></li>
        </ul>
     </div>
     <div class="filter-col">
        <h4>Sort by</h4>
        <ul>
          <li><span>Relevance</span></li>
          <li><a>Upload date</a></li>
          <li><a>View count</a></li>
          <li><a>Rating</a></li>
        </ul>
     </div>
  </div>
  <hr/>
  {#videos}
    <div class="video">
	  <a href="videos/watch?v={id}">
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