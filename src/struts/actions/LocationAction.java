/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package struts.actions;

import hibernate.config.NMMUMobileDAOManager;
import hibernate.location.LocationDAOInterface;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tools.AMSException;

import common.location.LocationLST;

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
//			LocationLST lst = new LocationLST();
//			try {
//				lst = getLocationDAO().getLocationLST(new LocationLST());
//			} catch (AMSException e) {
//				e.printStackTrace();
//			}
//			request.setAttribute("locations", lst);
			af = mapping.findForward(reqCode);
		} else if (reqCode.equalsIgnoreCase("pathCreation")) {
			setAllLocationTypes(request);
			setAllPathTypes(request);
			af = mapping.findForward(reqCode);
		}
		return af;
	}

	private void setAllPathTypes(HttpServletRequest request) {
		request.setAttribute("pathTypes", getLocationDAO().getAllPathTypes());

	}

	private void setAllLocationTypes(HttpServletRequest request) {
		request.setAttribute("locationTypes", getLocationDAO()
				.getAllLocationTypes());
	}

	private static LocationDAOInterface getLocationDAO() {
		return NMMUMobileDAOManager.getLocationDAOInterface();
	}

}