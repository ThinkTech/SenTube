import org.metamorphosis.core.ActionSupport
import groovy.json.JsonSlurper

class VideoAction extends ActionSupport {

	def id
	def query
	def watch = false
	
	def watch()  {
	    id = request.getParameter("v")
	    watch = true
	    if(id) {
	       def location =  "https://www.googleapis.com/youtube/v3/videos?id="+id+"&key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&part=snippet"
	       def connection = new URL(location).openConnection() as HttpURLConnection
	       connection.setRequestProperty( 'User-Agent', 'groovy' )
	       connection.setRequestProperty( 'Accept', 'application/json' )
	       if(connection.responseCode == 200) { 
		      def info = new JsonSlurper().parseText(connection.inputStream.text)
		      String description = info.items[0].snippet.description
		      if(description.length() > 500) description = description.substring(0,500)
		      info.items[0].snippet.description = description.replace("\"", "").replace("\n", " ")
		      request.setAttribute("info",info)
		      SUCCESS
		   } else {
			  response.sendRedirect(request.contextPath+"/")
		   }
			
		}
	    else {
	     response.sendRedirect(request.contextPath+"/")
	    }
	}
	
	def search()  {
	    query = request.getParameter("search_query")
	    query ? SUCCESS : response.sendRedirect(request.contextPath+"/")
	}
	
}

new VideoAction()