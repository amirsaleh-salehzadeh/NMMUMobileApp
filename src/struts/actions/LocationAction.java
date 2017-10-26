/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package struts.actions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import hibernate.config.NMMUMobileDAOManager;
import hibernate.location.LocationDAOInterface;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import tools.AMSErrorHandler;
import tools.AMSException;
import tools.AMSUtililies;

import common.MessageENT;
import common.PopupENT;
import common.location.LocationENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;

public class LocationAction extends Action {
	private String success = "";
	private String error = "";

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		ActionForward af = null;
		String reqCode = request.getParameter("reqCode");
		if (reqCode.equalsIgnoreCase("searchLocations")) {
			af = mapping.findForward(reqCode);
		} else if (reqCode.equalsIgnoreCase("mapView")) {
			setAllLocationTypes(request);
			setAllPathTypes(request);
			af = mapping.findForward(reqCode);
		} else if (reqCode.equalsIgnoreCase("pathManagement")) {
			setAllLocationTypes(request);
			setAllPathTypes(request);
			af = mapping.findForward(reqCode);
		} else if (reqCode.equalsIgnoreCase("cameraNavigation")) {
			af = mapping.findForward(reqCode);
		}
		if (reqCode.equalsIgnoreCase("login")) {
			af = mapping.findForward(reqCode);
		}
		if (reqCode.equalsIgnoreCase("locationManagement")) {
			return locationManagement(request, mapping);
		} else if (reqCode.equals("locationEdit")) {
			return editLocation(request, mapping, form);
		} else if (reqCode.equals("saveUpdateLocation")) {
			return saveUpdateLocation(request, mapping);
		}
		
		if (reqCode.equalsIgnoreCase("register")){
			af = mapping.findForward(reqCode);
		}
		return af;
	}

	private ActionForward saveUpdateLocation(HttpServletRequest request,
			ActionMapping mapping) {
		LocationENT locationENT = getLocationENT(request);
		try {
			locationENT = getLocationDAO().saveUpdateLocation(locationENT);
			success = "The location '" + locationENT.getLocationName()
					+ "' saved successfully";
		} catch (AMSException e) {
			error = AMSErrorHandler.handle(request, this, e, "", "");
		}
		request.setAttribute("locationENT", locationENT);
		MessageENT m = new MessageENT(success, error);
		request.setAttribute("message", m);
		return mapping.findForward("locationEdit");
	}

	private ActionForward editLocation(HttpServletRequest request,
			ActionMapping mapping, ActionForm form) {
		LocationENT locationENT = new LocationENT();
		int locationId = 0;
		if (request.getParameter("locationID") != null)
			locationId = Integer.parseInt(request.getParameter("locationID"));
		else {
			request.setAttribute("locationENT", locationENT);
			return mapping.findForward("locationEdit");
		}
		locationENT.setLocationID(locationId);
//		try {
			request.setAttribute("locationENT", getLocationDAO()
					.getLocationENT(locationENT));
//		} catch (AMSException e) {
//			error = e.getMessage();
//			e.printStackTrace();
//		}
		MessageENT m = new MessageENT(success, error);
		request.setAttribute("message", m);
		return mapping.findForward("locationEdit");
	}

	private ActionForward locationManagement(HttpServletRequest request,
			ActionMapping mapping) {
//		try {
			createMenusForLocation(request);
			LocationLST locationLST = getLocationLST(request);
			request.setAttribute("locationLST", locationLST);
			ObjectMapper mapper = new ObjectMapper();
			String json = "";
			try {
				json = mapper.writeValueAsString(locationLST.getLocationENTs());
			} catch (JsonGenerationException e) {
				e.printStackTrace();
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			json = AMSUtililies.prepareTheJSONStringForDataTable(
					locationLST.getCurrentPage(), locationLST.getTotalItems(), json,
					"locationID", success, error);
			request.setAttribute("json", json);
			if (request.getParameter("reqCodeGrid") != null
					&& request.getParameter("reqCodeGrid").equals("gridJson"))
				return mapping.findForward("gridJson");
//		} catch (AMSException e) {
//			e.printStackTrace();
//		}
		MessageENT m = new MessageENT(success, error);
		request.setAttribute("message", m);
		return mapping.findForward("locationManagement");
	}

	private LocationLST getLocationLST(HttpServletRequest request) {
		String search = request.getParameter("searchLocation.locationName");
		if (search == null)
			search = "";
		int pageNo = 1;
		int pageSize = 10;
		int parentID = 0;
		int locationTypeId = 0;
		String Gps = "";
		String Address = "";
		if (request.getParameter("currentPage") != null)
			pageNo = Integer.parseInt(request.getParameter("currentPage"));
		if (request.getParameter("pageSize") != null)
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if (request.getParameter("parentID") != null
				&& !request.getParameter("parentID").equals(""))
			parentID = Integer.parseInt(request.getParameter("parentID"));
		if (request.getParameter("Gps") != null)
			Gps = request.getParameter("Gps");
		if (request.getParameter("Address") != null)
			Address = request.getParameter("Address");
		if (request.getParameter("locationTypeId") != null)
			locationTypeId = Integer.parseInt(request.getParameter("locationTypeId"));
		LocationTypeENT locationTypeENT = new LocationTypeENT(locationTypeId);
		LocationENT locationENT = new LocationENT(0, search,locationTypeENT  , Address, Gps, search);
		LocationLST locationLST = new LocationLST(locationENT, pageNo, pageSize, true,
				"location_name");
//		try {
//			locationLST = null;//getLocationDAO().getLocationLST(locationLST);
//		} catch (AMSException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		return locationLST;
	}

	private LocationENT getLocationENT(HttpServletRequest request) {
		LocationENT locationENT = new LocationENT();
		if (request.getParameter("locationID") != null)
			locationENT.setLocationID(Integer.parseInt(request
					.getParameter("locationID")));
		if (request.getParameter("loctionName") != null)
			locationENT.setLocationName(request.getParameter("locationName"));
		else
			locationENT.setLocationName("");
		locationENT.setGps(request.getParameter("Gps"));
		locationENT.setUserName(request.getParameter("userName"));
		//locationENT.setLocationType(request.getParameter("locationType"));
		locationENT.setParentId(Integer.parseInt(request.getParameter("parentId")));
		return locationENT;
	}
	private void createMenusForLocation(HttpServletRequest request) {
		List<PopupENT> popupEnts = new ArrayList<PopupENT>();
		popupEnts.add(new PopupENT("hide-filters", "displaySearch();", "Show/Hide Search",
				"#"));
		popupEnts.add(new PopupENT("new-item",
				"callAnAction(\"location.do?reqCode=locationEdit\");",
				"New Group", "#"));
		popupEnts.add(new PopupENT("delete-item", "deleteSelectedItems(\"deleteLocation\");",
				"Delete Selected", "#"));
		List<PopupENT> popupGridEnts = new ArrayList<PopupENT>();
		popupGridEnts
				.add(new PopupENT(
						"edit-item",
						"callAnAction(\"location.do?reqCode=locationEdit&locationID=REPLACEME\");",
						"Location Group", "#"));
		popupGridEnts.add(new PopupENT("delete-item",
				"deleteAnItem(REPLACEME, \"deleteLocation\");", "Remove", "#")); //
		request.setAttribute("settingMenuItem", popupEnts);
		request.setAttribute("gridMenuItem", popupGridEnts);
	} 

	private void setAllPathTypes(HttpServletRequest request) {
		request.setAttribute("pathTypes", getLocationDAO().getAllPathTypes());

	}

	private void setAllLocationTypes(HttpServletRequest request) {
		LocationTypeENT ent = getLocationDAO().getAllLocationTypeChildren(null);
		String dropDownToolBar = "";
		dropDownToolBar += createLocationTypeNavBar(ent, ent.getChildren());
		request.setAttribute("locationTypes", dropDownToolBar);
	}

	private String createLocationTypeNavBar(LocationTypeENT ent,
			ArrayList<LocationTypeENT> children) {
		String res = "";
		if (children == null)
			return "";
		else {
			res = "<select name='selectLocationType'></select>";
			for (int i = 0; i < children.size(); i++) {
				res += "<option value='" + children.get(i).getLocationTypeId()
						+ "'>" + children.get(i).getLocationType()
						+ "</option>";
			}
		}
		res = "<select name='selectLocationType'><option value=''></option></select>";
		return res;
	}

	private static LocationDAOInterface getLocationDAO() {
		return NMMUMobileDAOManager.getLocationDAOInterface();
	}

}