package hibernate.location;

import hibernate.config.BaseHibernateDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;

import tools.AMSException;

import common.location.LocationENT;
import common.location.PathENT;

public class DataManagementLocation extends BaseHibernateDAO {

	private static void updateAllDescriptions() {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> all = dao.getAllLocationsForUser("NMMU", "3,5",
				null);
		for (int i = 0; i < all.size(); i++) {
			LocationENT ent = all.get(i);
			

			// UPDATE DESCRIPTION

			String descString = ent.getLocationName();
			final String res = StringEscapeUtils.unescapeXml(descString+ " &") ;
			if (ent.getLocationName().contains("401"))
				System.out.println(res);

			// if (descString != null) {
			// String[] tmpSentence = descString.split(" ");
			// for (int j = 0; j < tmpSentence.length; j++) {
			// if (tmpSentence[j].length() <= 3)
			// continue;
			// tmpSentence[j] = tmpSentence[j].toLowerCase();
			// // .toUpperCase()
			// if (j < tmpSentence.length)
			// res += tmpSentence[j].substring(0, 1).toUpperCase()
			// + tmpSentence[j].substring(1) + " ";
			// }
			// }

			ent.setDescription(res);
			if (res.length() <= 1)
				ent.setDescription(null);
			if (ent.getIcon() != null && ent.getIcon().length() < 5)
				ent.setIcon(null);
			// try {
			// dao.saveUpdateLocation(ent);
			// } catch (AMSException e) {
			// // TODO Auto-generated catch block
			// e.printStackTrace();
			// }
		}
	}

	private static void updateAllGPS() {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> all = dao.getAllLocationsForUser("NMMU", "",
				"");
		for (int i = 0; i < all.size(); i++) {
			LocationENT ent = all.get(i);
			String res = "";

			// UPDATE GPS
			String descString = ent.getGps();
			System.out.println(descString);
			if (descString != null) {
				String[] tmpSentence = descString.split(",");
				// for (int j = 0; j < tmpSentence.length; j++) {
				double x = Double.parseDouble(tmpSentence[0]);
				double y = (double) Double.parseDouble(new DecimalFormat(
						".#######").format(x));
				res += y;
				x = Double.parseDouble(tmpSentence[1]);
				y = (double) Double.parseDouble(new DecimalFormat(".#######")
						.format(x));
				res += "," + y;
				// }
			}
			System.out.println(res);
			// ent.setDescription(res);
			ent.setGps(res);
			if (res.length() <= 1)
				ent.setDescription(null);
			if (ent.getIcon() != null && ent.getIcon().length() < 5)
				ent.setIcon(null);
			try {
				dao.saveUpdateLocation(ent);
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private static void updateAllGPSParents(String topLeft, String topRight,
			String bottomRight, String BottomLeft) {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> ents = dao.getAllLocationsForUser("NMMU", "3,5",
				"");
		double latTL = Double.parseDouble(topLeft.split(",")[0]);
		double lngTL = Double.parseDouble(topLeft.split(",")[1]);
		double latBL = Double.parseDouble(BottomLeft.split(",")[0]);
		double lngBL = Double.parseDouble(BottomLeft.split(",")[1]);
		double latTR = Double.parseDouble(topRight.split(",")[0]);
		double lngTR = Double.parseDouble(topRight.split(",")[1]);
		double latBR = Double.parseDouble(bottomRight.split(",")[0]);
		double lngBR = Double.parseDouble(bottomRight.split(",")[1]);
		for (int i = 0; i < ents.size(); i++) {
			LocationENT ent = ents.get(i);
			if (ent.getLocationID() == 360)
				continue;
			String[] gps = ent.getGps().split(",");
			double lat = Double.parseDouble(gps[0]);
			double lng = Double.parseDouble(gps[1]);
			if (lat < latTL && lng > lngTL && lat < latTR && lng < lngTR
					&& lat > latBL && lng > lngBL && lat > latBR && lng < lngBR) {
				ent.setParentId(367);
				System.out.println(ent.getLocationName() + " "
						+ ent.getLocationID());
				try {
					dao.saveUpdateLocation(ent);
				} catch (AMSException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void updateAPathLength(PathENT path) throws AMSException {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "update paths set distance = " + path.getDistance()
					+ " where path_id = " + path.getPathId();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		updateAllGPS();
		// updateAllDescriptions();

		// NORTH CAMPUS NMMU
		// updateAllGPSParents("-33.996924, 25.665436",
		// "-33.9972578,25.6763445",
		// "-34.0045724,25.6792518", "-34.0053476,25.6648867");

		// 2ndAVE
		// updateAllGPSParents("-33.986996,25.651153", "-33.984546,25.664695",
		// "-33.990612,25.665772", "-33.991390,25.654094");

		// Bird Street
		// updateAllGPSParents("-33.964712,25.615733", "-33.964339,25.618636",
		// "-33.966208,25.619162", "-33.966277,25.616377");

		// Missionvale
		// updateAllGPSParents("-33.870589,25.549132", "-33.870016,25.555359",
		// "-33.874217,25.556063", "-33.875109,25.549600");

		// George Campus
		// updateAllGPSParents("-33.9438158,22.5002528",
		// "-33.9420745,22.5411127",
		// "-33.987197,22.5592594", "-33.991323,22.5072237");

		//

		// LocationDAO dao = new LocationDAO();
		// LocationDataManagement daomng = new LocationDataManagement();
		// ArrayList<PathENT> paths = dao.getAllPaths("NMMU");
		// for (int i = 0; i < paths.size(); i++) {
		// PathENT p = paths.get(i);
		// // if (p.getPathId() == 1910) {
		// double dis = LocationDAO.calculateDistance(paths.get(i)
		// .getDeparture().getGps(), paths.get(i).getDestination()
		// .getGps(), paths.get(i).getPathRoute());
		// p.setDistance(dis);
		// // }
		//
		// if (paths.get(i).getDistance() != p.getDistance())
		// if(p.getPathId() == 1910)
		// System.out.println("before " + paths.get(i).getDistance()
		// + "  >> After: " + dis);
		// try {
		// daomng.updateAPathLength(p);
		// } catch (AMSException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// }

//		updateAllDescriptions();
	}
}
