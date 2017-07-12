package webservices;

import hibernate.config.NMMUMobileDAOManager;
import hibernate.location.LocationDAOInterface;
import hibernate.security.SecurityDAOInterface;

import java.io.IOException;
import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Application;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import common.location.LocationENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;

import tools.AMSException;
import tools.QRBarcodeGen;

@Path("GetLocationWS")
public class LocationServicesWS {

	@GET
	@Path("/GetAllLocationsForUser")
	@Produces("application/json")
	public String getAllLocationsForUser(
			@QueryParam("userName") String userName,
			@QueryParam("locationTypeId") int locationTypeId,
			@QueryParam("parentLocationId") long parentLocationId) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getLocationDAO()
					.getAllLocationsForUser(userName, locationTypeId,
							parentLocationId));
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
	@Path("/SearchForALocation")
	@Produces("application/json")
	public String searchForALocation(@QueryParam("userName") String userName,
			@QueryParam("locationType") String locationType,
			@QueryParam("locationName") String locationName) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			LocationENT search = new LocationENT();
			search.setLocationName(locationName);
			search.setUserName(userName);
			search.setLocationType(new LocationTypeENT(0, locationType));
			search.setUserName(userName);
			LocationLST ls = new LocationLST();
			ls.setSearchLocation(search);
			try {
				json = mapper.writeValueAsString(getLocationDAO()
						.searchForLocations(ls).getLocationENTs());
				System.out.println(json);
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
	@Path("/GetAllLocationTypes")
	@Produces("application/json")
	public String getAllLocationTypes() {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getLocationDAO()
					.getAllLocationTypeChildren(null));
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
	@Path("/GetParentLocationsOfaType")
	@Produces("application/json")
	public String getLocationsOfaType(@QueryParam("typeId") int typeId) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getLocationDAO()
					.getParentLocationsOfaType(typeId).getLocationLightENTs());
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
	@Path("/GetAllPathTypes")
	@Produces("application/json")
	public String getAllPathTypes() {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper
					.writeValueAsString(getLocationDAO().getAllPathTypes());
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
			json = mapper.writeValueAsString(getLocationDAO().getAllPaths(
					userName));
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
	@Path("/GetADirectionFromTo")
	@Produces("application/json")
	public String getADirectionFromTo(@QueryParam("from") String from,
			@QueryParam("to") String to, @QueryParam("pathType") int pathType,
			@QueryParam("destinationId") long destinationId,
			@QueryParam("departureId") long departureId) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			if(destinationId <=0)
				destinationId =	getLocationDAO().findClosestLocation(to).getLocationID();
			if(departureId <=0)
				departureId =	getLocationDAO().findClosestLocation(from).getLocationID();
			json = mapper.writeValueAsString(getLocationDAO().getShortestPath(departureId, destinationId, pathType));
			System.out.println(json);
			// tmp = "{ \"distance\": " + currentPage + ", \"recordsTotal\":" +
			// totalItems
			// + ", \"recordsFiltered\":" + totalItems;
			// tmp += ", \"successm\":\"" + success+"\"";
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
	@Path("/SaveUpdateLocation")
	@Produces("application/json")
	public String saveUpdateLocation(@QueryParam("locationId") long locationId,
			@QueryParam("locationType") int locationType,
			@QueryParam("locationName") String locationName,
			@QueryParam("userName") String userName,
			@QueryParam("address") String address,
			@QueryParam("coordinate") String coordinate,
			@QueryParam("parentId") long parentId) {
		LocationENT ent = new LocationENT(locationId, userName,
				new LocationTypeENT(locationType), address, coordinate,
				locationName);
		ent.setParentId(parentId);
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
		getLocationDAO().savePath(ent);
		return json;
	}

	@GET
	@Path("/GetAPath")
	@Produces("application/json")
	public String getAPath(@QueryParam("pathId") long pathId) {
		String json = "[]";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getLocationDAO().getAPath(
					new PathENT(pathId)));
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
	@Path("/RemoveAPath")
	@Produces("application/json")
	public String removeAPath(@QueryParam("pathId") long pathId) {
		String json = "[]";
		try {
			getLocationDAO().deletePath(new PathENT(pathId));
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/GetALocation")
	@Produces("application/json")
	public String getALocation(@QueryParam("locationId") long locationId) {
		String json = "[]";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getLocationDAO().getLocationENT(
					new LocationENT(locationId)));
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
	@Path("/RemoveALocation")
	@Produces("application/json")
	public String removeALocation(@QueryParam("locationId") long locationId) {
		String json = "[]";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getLocationDAO().deleteLocation(
					new LocationENT(locationId)));
		} catch (AMSException e) {
			e.printStackTrace();
			return "{\"errorMSG\": \"Please remove the path first\"}";
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
	@Path("/GetBarcodeForLocation")
	@Produces("application/json")
	public String getBarcodeForLocation(
			@QueryParam("locationId") long locationId) {
		return getLocationDAO().getQRCodeForLocationENT(locationId);
	}

	@GET
	@Path("/GetBarcodeInTripInfo")
	@Produces("application/json")
	public String getBarcodeinTripInfo(@QueryParam("barcodeId") long barcodeId,
			@QueryParam("destinationId") long destinationId,
			@QueryParam("pathType") int pathType) {
		String json = "[]";
		// ObjectMapper mapper = new ObjectMapper();
		// // try {
		// ArrayList<PathENT> shortestPathToDest = getLocationDAO()
		// .getShortestPath(barcodeId, destinationId, pathType);
		// ArrayList<PathENT> allPathsforADest = getLocationDAO()
		// .getAllPathsForOnePoint(barcodeId, pathType);

		// } catch (JsonGenerationException e) {
		// e.printStackTrace();
		// } catch (JsonMappingException e) {
		// e.printStackTrace();
		// } catch (IOException e) {
		// e.printStackTrace();
		// }
		return json;
	}

	@GET
	@Path("/StartTrip")
	@Produces("application/json")
	public String startTrip(@QueryParam("from") long from,
			@QueryParam("to") long to) {
		String json = "[]";
		json = "[{\"tripId\" : \"" + getLocationDAO().saveTrip(from, to)
				+ "\"}]";
		return json;
	}

	@GET
	@Path("/RemoveTrip")
	@Produces("application/json")
	public String removeTrip(@QueryParam("tripId") long tripId) {
		String json = "[]";
		getLocationDAO().deleteTrip(tripId);
		return json;
	}

	private static LocationDAOInterface getLocationDAO() {
		return NMMUMobileDAOManager.getLocationDAOInterface();
	}
}
