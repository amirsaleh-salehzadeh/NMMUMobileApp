package webservices;

import hibernate.config.NMMUMobileDAOManager;
import hibernate.route.PathDAOInterface;

import java.io.IOException;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import common.location.LocationENT;
import common.location.PathENT;
import common.location.PathTypeENT;

@Path("GetPathWS")
public class PathServicesWS {

	@GET
	@Path("/GetPathsForUserAndParent")
	@Produces("application/json")
	public String getPathsForUserAndParent(@QueryParam("userName") String userName,@QueryParam("parentId") long parentId) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getPathDAO().getRoutesForUserAndParent(userName, parentId));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@GET
	@Path("/SavePath")
	@Produces("application/json")
	public String savePath(@QueryParam("fLocationId") long fLocationId,
			@QueryParam("tLocationId") long tLocationId,
			@QueryParam("pathRoute") String pathRoute,
			@QueryParam("pathType") int pathType) {
		PathENT ent = new PathENT(new LocationENT(fLocationId),
				new LocationENT(tLocationId), new PathTypeENT(pathType));
		ent.setPathRoute(pathRoute);
		String json = "[]";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getPathDAO().savePath(ent));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}

	private static PathDAOInterface getPathDAO() {
		return NMMUMobileDAOManager.getPathDAOInterface();
	}
}
