package hibernate.location;

import hibernate.config.BaseHibernateDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import tools.AMSException;

import common.location.LocationENT;
import common.location.PathENT;

public class LocationDataManagement extends BaseHibernateDAO {

	private static void updateAllDescriptions() {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> all = dao.getAllLocationsForUser("NMMU", "3,5",
				null);
		for (int i = 0; i < all.size(); i++) {
			LocationENT ent = all.get(i);
			String res = "";

			// UPDATE DESCRIPTION

			String descString = ent.getDescription();
			System.out.println(descString);
			if (descString != null) {
				String[] tmpSentence = descString.split(" ");
				for (int j = 0; j < tmpSentence.length; j++) {
					if (tmpSentence[j].length() <= 1)
						continue;
					tmpSentence[j] = tmpSentence[j].toLowerCase();
					// .toUpperCase()
					if (j < tmpSentence.length)
						res += tmpSentence[j].substring(0, 1).toUpperCase()
								+ tmpSentence[j].substring(1) + " ";
				}
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

	private static void updateAllGPS() {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> all = dao.getAllLocationsForUser("NMMU", "3,5",
				null);
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
			String bottomLeft, String BottomRight) {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> ents = dao.getAllLocationsForUser("NMMU", "3,5",
				"360");
		for (int i = 0; i < ents.size(); i++) {
			LocationENT ent = ents.get(i);
			String[] gps = ent.getGps().split(",");
			double lat = Double.parseDouble(gps[0]);
			double lng = Double.parseDouble(gps[1]);
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
		LocationDAO dao = new LocationDAO();
		LocationDataManagement daomng = new LocationDataManagement();
		ArrayList<PathENT> paths = dao.getAllPaths("NMMU");
		for (int i = 0; i < paths.size(); i++) {
			PathENT p = paths.get(i);
			if(p.getPathId() == 1910){
				double dis = LocationDAO.calculateDistance(paths.get(i)
						.getDeparture().getGps(), paths.get(i).getDestination()
						.getGps(), paths.get(i).getPathRoute());
				p.setDistance(dis);
			}
			
//			if (paths.get(i).getDistance() != p.getDistance())
//			if(p.getPathId() == 1910)
//				System.out.println("before " + paths.get(i).getDistance()
//						+ "  >> After: " + dis);
//			try {
//				daomng.updateAPathLength(p);
//			} catch (AMSException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
		}
	}
}
