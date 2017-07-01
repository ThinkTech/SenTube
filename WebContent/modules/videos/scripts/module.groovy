import org.metamorphosis.core.ActionSupport
import groovy.json.JsonSlurper

class ModuleAction extends ActionSupport {

	def id
	def query
	def watch
	
	def watch()  {
	    id = getParameter("v")
	    if(id) {
	       watch = true
	       def location = "https://www.googleapis.com/youtube/v3/videos?id=${id}&key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&part=snippet"
	       def connection = new URL(location).openConnection() as HttpURLConnection
	       connection.setRequestProperty('User-Agent','groovy')
	       connection.setRequestProperty('Accept','application/json')
	       if(connection.responseCode == 200) { 
		      def info = new JsonSlurper().parseText(connection.inputStream.text)
		      def description = info.items[0].snippet.description as String
		      if(description.length() > 500) description = description.substring(0,500)
		      info.items[0].snippet.description = description.replace("\"", "").replace("\n", " ")
		      setAttribute("info",info)
		      SUCCESS
		   } else {
			  redirect(contextPath)
		   }
			
		}
	    else {
	     redirect(contextPath)
	    }
	}
	
	def search()  {
	    query = getParameter("search_query") as String
	    query?.trim() ? SUCCESS : redirect(contextPath)
	}
	
}

new ModuleAction()