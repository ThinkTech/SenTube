<div class="page-title">
<a data-translation="music"></a>
</div>
<div>
<div class="videos">
 <template type="text/x-dust-template">
 <h1><i class="fa fa-music"></i> <span data-translation="{title}"></span><a title="Previous" class="video-nav-left" href="#"><i class="fa fa-angle-left"></i></a><a title="Next" class="video-nav-right" href="#"><i class="fa fa-angle-right"></i></a></h1>
 <span class="actions">
 <select>
  	<option data-translation="all"></option>
  	<option data-translation="new"></option>
  </select>
 <a href="watch?v=videos" class="playall"  href="#"><i class="fa fa-play"></i></a></span>
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
	   	<p class="view-count"><span>{viewCount}</span> <span data-translation="views"></span></p>
	    <p class="title"><span>{title}</span></p>
	   </div>
	 </a>
    </div>
  {/videos}
  </template>	
 </div>
 
 <div class="videos">
 <template type="text/x-dust-template">
 <h1><i class="fa fa-globe"></i> <span data-translation="{title}"></span><a title="Previous" class="video-nav-left" href="#"><i class="fa fa-angle-left"></i></a><a title="Next" class="video-nav-right" href="#"><i class="fa fa-angle-right"></i></a></h1>
 <span class="actions">
 <select>
    <option data-translation="all"></option>
  	<option data-translation="new"></option>
  </select>
 <a href="watch?v=videos" class="playall"  href="#"><i class="fa fa-play"></i></a></span>
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
	   	<p class="view-count"><span>{viewCount}</span> <span data-translation="views"></span></p>
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
 <style>
 #wait {padding-left: 0px;padding-top: 17.5%;}
 #loader {margin : auto;}
 </style>