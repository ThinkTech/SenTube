import org.metamorphosis.core.ActionSupport

class VideoAction extends ActionSupport {

	def id
	def query
	def watch = false
	
	def watch()  {
	    id = request.getParameter("v")
	    watch = true
	    id ? SUCCESS : response.sendRedirect(request.contextPath+"/")
	}
	
	def search()  {
	    query = request.getParameter("search_query")
	    query ? SUCCESS : response.sendRedirect(request.contextPath+"/")
	}
	
}

new VideoAction()