class ModuleAction extends ActionSupport {

	def watch()  {
	    def id = getParameter("v")
	    def watch = false
	    if(id) {
	       def location = "https://www.googleapis.com/youtube/v3/videos?id=${id}&key=AIzaSyBaYaWQcSP8P1Dau3kxDitRo7W9VA4EOPg&part=snippet"
	       def connection = new URL(location).openConnection() as HttpURLConnection
	       if(connection.responseCode == 200) { 
		   def info = parse(connection.inputStream)
		   def description = info.items[0].snippet.description as String
		   if(description.length() > 500) description = description.substring(0,500)
		   info.items[0].snippet.description = description.replace("\"", "").replace("\n", " ")
		   request.setAttribute("info",info)
		   request.setAttribute("id",id)
		   response.setHeader("Cache-Control", "private, max-age=7200")
		   watch = true
	       }
	     }
	     watch ? SUCCESS : ERROR 
	}
	
	def search()  {
	    def query = getParameter("search_query") as String
	    query?.trim() ? SUCCESS : ERROR
	}
	
}