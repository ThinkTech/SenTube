<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>SenTube</title>
    <base href="${path}"/>
    <!-- Metamorphosis css -->
    <link href="css/metamorphosis.css" rel="stylesheet"/> 
    <!-- Template css -->
    <link href="templates/modern/css/template.css" rel="stylesheet"/> 
    <!-- Module css -->
    <link href="${css}/module.css" rel="stylesheet"/> 
    <!-- Favicon -->
    <link rel="shortcut icon" href="templates/modern/images/favicon_32.png"  sizes="32x32"/>
    
    <s:if test="%{!watch}">
     <meta property="og:site_name" content="Sentube">
     <meta property="og:type" content="website">
     <meta property="og:url" content="${baseUrl}">
    <meta property="og:title" content="Welcome to Sentube">
    <meta property="og:image" content="${baseUrl}/images/sentube.jpg">
    <meta property="og:description" content="Platform for watching videos">  
    </s:if>
     <s:if test="%{watch}">
     <meta property="og:url" content="${baseUrl}/watch?v=${id}">
    <meta property="og:title" content="${info.items[0].snippet.title}">
    <meta property="og:image" content="https://i.ytimg.com/vi/${id}/hqdefault.jpg">
     <meta property="og:image:width" content="256">
     <meta property="og:image:height" content="256">
    <meta property="og:description" content="${info.items[0].snippet.description}">  
     <meta property="og:type" content="video">
     <meta property="og:video:url" content="http://www.youtube.com/v/${id}?version=3&amp;autohide=1">
        <meta property="og:video:secure_url" content="https://www.youtube.com/v/${id}?version=3&amp;autohide=1">
        <meta property="og:video:type" content="application/x-shockwave-flash">
        <meta property="og:video:width" content="1280">
        <meta property="og:video:height" content="720">
    </s:if>
  </head>
<body>
 
  <!-- scroll to top  -->   
  <a class="scrollToTop" href="#"><i class="fa fa-angle-up"></i></a>
  
  <!-- start navbar -->
  <nav class="navbar-fixed-top" role="navigation">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="aside-toggle collapsed" data-target="#navbar" aria-expanded="false" aria-controls="navbar" onclick="${watch ? 'return toggleAside();' : 'return showMainFull();'}">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="${path}">Sen<span>Tube</span></a>
        <!-- <a class="navbar-brand" href="index.html"><img src="images/logo.png" alt="logo"></a> -->
      </div>
       <form id="search" action="search" method="GET">
        <input  name="search_query"  type="text" data-translation="search" placeholder="Search..."/>
        <input type="submit" value=""/>
       </form>
      <div id="navbar" class="navbar-collapse collapse navbar_area">          
        <ul class="nav navbar-nav navbar-right custom_nav">
          <li><a class="upload">&nbsp;</a></li>
          <li><a  class="signin" data-translation="signIn"></a></li>                 
        </ul>
      </div><!--/.nav-collapse -->
    </div>
  </nav>
  <!-- End navbar -->
 
 <aside style="${watch ? 'display:none' : 'opacity:1'}">
   <div>
    <ol>
     <li data-translation="home"></li>
     <li data-translation="trending"></li>
     <li data-translation="history"></li>
    </ol>
   </div>
   <hr/>
   <h3 data-translation="best-of"></h3>
    <div>
     <span class="active">
     <img src="//i.ytimg.com/i/-9-kyTW8ZkZNDHQJ6FgpwQ/1.jpg" height="20"  width="20" data-ytimg="1" aria-hidden="true" alt=""/>
     <span data-translation="music"></span>
     </span>
     <span>
     <img src="//i.ytimg.com/i/Egdi0XIXXZ-qJOFPf4JSKw/1.jpg" height="20"  width="20" data-ytimg="1" aria-hidden="true" alt=""/>
     <span data-translation="sports"></span>
     </span>
     <span>
     <img src="//i.ytimg.com/i/OpNcN46UbXVtpKMrmU4Abg/1.jpg" height="20"  width="20" data-ytimg="1" aria-hidden="true" alt=""/>
     <span data-translation="gaming"></span>
     </span>
     <span>
     <img src="//i.ytimg.com/i/lgRkhTL3_hImCAmdLfDE4g/1.jpg" height="20" width="20" data-ytimg="1" aria-hidden="true" alt=""/>
      <span data-translation="movies"></span>
     </span>
     <span>
     <img src="//i.ytimg.com/i/YfdidRxbB8Qhf0Nx7ioOYw/1.jpg" height="20"  width="20" data-ytimg="1" aria-hidden="true" alt=""/>
      <span data-translation="news"></span>
     </span>
     <span>
     <img src="//i.ytimg.com/i/4R8DWoMoI7CAwX8_LjQHig/1.jpg" data-ytimg="1"  aria-hidden="true" width="20" alt="" height="20">
      <span data-translation="live"></span>
     </span>
     <span>
     <img src="//i.ytimg.com/i/zuqhhs6NWbgTzMuM09WKDQ/1.jpg" data-ytimg="1"  aria-hidden="true" width="20" alt="" height="20">
      <span data-translation="360"></span>
     </span>
   </div>
   <hr/>
   <div>
    <span>
     <img src="templates/modern/images/add-20.png" height="20"  width="20" data-ytimg="1" aria-hidden="true" alt=""/>
      <span data-translation="browse"></span>
     </span>
   </div>
   <hr/>
   <p data-translation="sign-in-text"></p>
   <a  class="signin" data-translation="signIn"></a>
 </aside>
 <main style="${watch ? 'width:100%' : 'opacity:1'}">
   <tiles:insertAttribute name="content"/>
 </main>   
  <!-- start footer -->
  <footer id="footer">
     <div class="language">
		<select id="select">
		     <option id="english" value="en" data-translation="english">English</option>
		    <option id="french" value="fr" data-translation="french">French</option>
		</select>
	  </div>
    <div class="developer">
         <p data-translation="design-by"></p>
    </div>
  </footer>
  <!-- End footer -->

  <!-- jQuery Library -->
  
  <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
 
  <!-- metamorphosis js file include -->
 
 <script src="js/metamorphosis.js"></script> 
 
  <!-- template js file include -->
  <script src="templates/modern/js/template.js"></script>  
  
  <script>
       app.ready(function(){
          page.translate("i18n/app","${request.locale.language}",function(){
        	  $("body").animate({opacity : 1},10);
        	  $("div.language select").val(page.language);
          });
       });
     </script> 
   
  </body>
</html>