package webservices;

import hibernate.config.NMMUMobileDAOManager;
import hibernate.location.LocationDAOInterface;
import hibernate.security.SecurityDAOInterface;

import java.io.IOException;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Application;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import common.location.LocationENT;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;

import tools.AMSException;

@Path("GetLocationWS")
public class LocationServicesWS {

	@GET
	@Path("/GetAllLocationsForUser")
	@Produces("application/json")
	public String getAllLocationsForUser(@QueryParam("userName") String userName) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getLocationDAO()
					.getAllLocationsForUser(userName));
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
	@Path("/GetAllPathsForUser")
	@Produces("application/json")
	public String getAllPathsForUser(@QueryParam("userName") String userName) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getLocationDAO()
					.getAllPaths(userName));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println(json);
		return json;
	}

	@GET
	@Path("/SaveUpdateLocation")
	@Produces("application/json")
	public String saveUpdateLocation(@QueryParam("locationId") long locationId,
			@QueryParam("locationType") int locationType,
			@QueryParam("locationName") String locationName,
			@QueryParam("userName") String userName,
			@QueryParam("address") String address,
			@QueryParam("coordinate") String coordinate) {
		LocationENT ent = new LocationENT(locationId, userName,
				new LocationTypeENT(locationType), address, coordinate,
				locationName);
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getLocationDAO()
					.saveUpdateLocation(ent));
		} catch (AMSException e) {
			e.printStackTrace();
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
			@QueryParam("pathType") int pathType) {
		PathENT ent = new PathENT(new LocationENT(fLocationId),
				new LocationENT(tLocationId), new PathTypeENT(pathType));
		String json = "[]";
			getLocationDAO()
					.savePath(ent);
		return json;
	}

	private static LocationDAOInterface getLocationDAO() {
		return NMMUMobileDAOManager.getLocationDAOInterface();
	}
}
