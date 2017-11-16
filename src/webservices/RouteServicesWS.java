package webservices;

import hibernate.config.NMMUMobileDAOManager;
import hibernate.location.LocationDAOInterface;
import hibernate.route.RouteDAOInterface;
import hibernate.security.SecurityDAOInterface;

import java.io.IOException;
import java.util.ArrayList;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.MediaType;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jettison.json.JSONException;

import common.location.LocationENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;

import tools.AMSException;
import tools.QRBarcodeGen;

@Path("GetRouteWS")
public class RouteServicesWS {

	@GET
	@Path("/GetRoutesForUserAndParent")
	@Produces("application/json")
	public String getRoutesForUserAndParent(@QueryParam("userName") String userName,@QueryParam("parentId") long parentId) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getRouteDAO().getRoutesForUserAndParent(userName, parentId));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}

	private static RouteDAOInterface getRouteDAO() {
		return NMMUMobileDAOManager.getRouteDAOInterface();
	}
}
