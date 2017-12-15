package webservices;

import hibernate.config.NMMUMobileDAOManager;
import hibernate.location.LocationDAOInterface;
import hibernate.route.PathDAOInterface;
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

@Path("GetLocationWS")
public class LocationServicesWS {

	@GET
	@Path("/CreateTFCEntrance")
	@Produces("application/json")
	public String createTFCEntrance(
			@QueryParam("locationName") String locationName,
			@QueryParam("coordinate") String grpsString,
			@QueryParam("locationType") String parentLocationIds,
			@QueryParam("username") String userName,
			@QueryParam("parentId") long parentId) {
		ObjectMapper mapper = new ObjectMapper();

		int locationid = 0;
		String json = "";

		try {

			LocationENT ent = new LocationENT(userName);
			if (locationName.equalsIgnoreCase("Entrance"))
				ent.setLocationType(new LocationTypeENT(10));
			ent.setBoundary(null);
			ent.setLocationName(locationName);
			ent.setGps(grpsString);
			ent.setParentId(parentId);
			ent.setIcon(null);
			ent.setPlan(null);
			ent.setDescription(null);
			json = mapper.writeValueAsString(getLocationDAO()
					.saveUpdateLocation(ent, null));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return json;
	}

	@GET
	@Path("/CreateTFCLevels")
	@Produces("application/json")
	public String createTFCLevels(
			@QueryParam("locationName") String locationName,
			@QueryParam("locationType") String parentLocationIds,
			@QueryParam("username") String userName,
			@QueryParam("parentId") long parentId) {
		ObjectMapper mapper = new ObjectMapper();

		int locationid = 0;
		String json = "";

		try {

			LocationENT ent = new LocationENT(userName);
			if (locationName.equalsIgnoreCase("Level"))
				ent.setLocationType(new LocationTypeENT(4));
			ent.setBoundary(null);
			ent.setLocationName(locationName);

			ent.setParentId(parentId);
			ent.setIcon(null);
			ent.setPlan(null);
			ent.setDescription(null);

			json = mapper.writeValueAsString(getLocationDAO()
					.saveUpdateLocation(ent, null));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return json;
	}

	@GET
	@Path("/GetAllLocationsForUser")
	@Produces("application/json")
	public String getAllLocationsForUser(
			@QueryParam("userName") String userName,
			@QueryParam("locationTypeId") String locationTypeIds,
			@QueryParam("parentLocationId") String parentLocationIds) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			if (parentLocationIds.equalsIgnoreCase("0"))
				parentLocationIds = null;
			json = mapper.writeValueAsString(getLocationDAO()
					.getAllLocationsForUser(userName, locationTypeIds,
							parentLocationIds));
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
	public String searchForALocation(
			@QueryParam("clientName") String clientName,
			@QueryParam("locationType") String locationType,
			@QueryParam("locationName") String locationName) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			LocationENT search = new LocationENT();
			search.setLocationName(locationName);
			search.setLocationType(new LocationTypeENT(0, locationType));
			search.setClientName(clientName);
			search.setLocationID(360);
			// LocationLST ls = new LocationLST();
			// ls.setSearchLocation(search);
			// try {
			// json = mapper.writeValueAsString(getLocationDAO()
			// .searchForLocations(ls).getLocationENTs());
			json = mapper.writeValueAsString(getLocationDAO()
					.getLocationWithChildren(search));
			System.out.println(json);
			// } catch (AMSException e) {
			// // TODO Auto-generated catch block
			// e.printStackTrace();
			// }
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
					.getAllLocationTypeChildren(new LocationTypeENT(1)));
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
	@Path("/GetADirectionFromTo")
	@Produces("application/json")
	public String getADirectionFromTo(
			@QueryParam("clientName") String clientName,
			@QueryParam("from") String from, @QueryParam("to") String to,
			@QueryParam("pathType") int pathType,
			@QueryParam("destinationId") long destinationId,
			@QueryParam("departureId") long departureId) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			LocationENT destENT = new LocationENT();
			if (destinationId <= 0) {
				destENT = getLocationDAO().findClosestLocation(to, "11,3,5",
						null, "NMMU");
				destinationId = destENT.getLocationID();
			}
			// building and external intersection
			if (departureId <= 0) {
				destENT = getLocationDAO().getLocationENT(
						new LocationENT(destinationId), null);
				String parentId = destENT.getParentId() + "";
				if (destENT.getParentId() == 369
						|| destENT.getParentId() == 371)
					parentId = "369,371";
				departureId = getLocationDAO().findClosestLocation(from,
						"11,3,5", parentId, "NMMU").getLocationID();
			}
			ArrayList<PathENT> res = getPathDAO().getShortestPath(departureId,
					destinationId, pathType, clientName, pathType);
			if (res.size() == 0)
				getLocationDAO().saveTrip(departureId, destinationId);
			json = mapper.writeValueAsString(res);

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
	@Path("/FindClosestBuilding")
	@Produces("application/json")
	public String findClosestBuilding(@QueryParam("from") String from) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getLocationDAO()
					.getLocationENTAncestors(
							getLocationDAO().findClosestLocation(from, "3,5",
									null, "NMMU").getLocationID()));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}

	@POST
	@Path("/SaveUpdateLocation")
	@Produces("application/json")
	@Consumes({ MediaType.TEXT_PLAIN, MediaType.APPLICATION_JSON,
			MediaType.APPLICATION_FORM_URLENCODED })
	public String saveUpdateLocation(@FormParam("icon") String icon,
			@FormParam("locationId") long locationId,
			@FormParam("locationTypeId") String locationTypeId,
			@FormParam("locationName") String locationName,
			@FormParam("userName") String userName,
			@FormParam("coordinate") String coordinate,
			@FormParam("description") String description,
			@FormParam("boundary") String boundary,
			@FormParam("plan") String plan, @FormParam("parentId") long parentId) {
		LocationENT ent = new LocationENT(locationId, userName,
				new LocationTypeENT(Integer.parseInt(locationTypeId)),
				coordinate, locationName);
		ent.setParentId(parentId);
		ent.setDescription(description);
		ent.setBoundary(boundary);
		ent.setPlan(plan);
		ent.setIcon(icon);
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(getLocationDAO()
					.saveUpdateLocation(ent, null));
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
	@Path("/GetAPath")
	@Produces("application/json")
	public String getAPath(@QueryParam("pathId") long pathId) {
		String json = "[]";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getPathDAO().getAPath(
					new PathENT(pathId), null));
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
	@Path("/GetALocation")
	@Produces("application/json")
	public String getALocation(@QueryParam("locationId") long locationId) {
		String json = "[]";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getLocationDAO().getLocationENT(
					new LocationENT(locationId), null));
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
			if(getLocationDAO().deleteLocation(
					new LocationENT(locationId))){
				json= "{\"errorMSG\": null}";
			}else{
				json = "{\"errorMSG\": \"Problem while removing the location\"}";
			}
		} catch (AMSException e) {
			e.printStackTrace();
			return "{\"errorMSG\": \"Please remove the path first\"}";
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

	private static PathDAOInterface getPathDAO() {
		return NMMUMobileDAOManager.getPathDAOInterface();
	}
}
