package hibernate.location;

import hibernate.config.BaseHibernateDAO;
import hibernate.route.PathDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Random;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;

import tools.AMSException;

import common.location.EntranceIntersectionENT;
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
			final String res = StringEscapeUtils.unescapeXml(descString + " &");
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
		ArrayList<LocationENT> all = dao.getAllLocationsForUser("NMMU", "", "");
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
				dao.saveUpdateLocation(ent, null);
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
				ent.setParentId(371);
				System.out.println(ent.getLocationName() + " "
						+ ent.getLocationID());
				try {
					dao.saveUpdateLocation(ent, null);
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

	private void getAllPaths() throws AMSException {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		ArrayList<PathENT> res = new ArrayList<PathENT>();
		try {
			String query = "Select * from pathstmp";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			LocationDAO ldao = new LocationDAO();
			PathDAO dao = new PathDAO();
			while (rs.next()) {
				PathENT ent = new PathENT(ldao.getLocationENT(new LocationENT(
						rs.getLong("departure_location_id")), conn),
						ldao.getLocationENT(
								new LocationENT(rs
										.getLong("destination_location_id")),
								conn), rs.getDouble("distance"),
						rs.getString("path_type"), rs.getLong("path_id"),
						rs.getString("path_route"), 2, "", "");
				ent.setPathId(0);
				ent.setPathType(rs.getString("path_type"));
				dao.savePath(ent, conn);
				res.add(ent);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private static void updatePointsToBoundary() {
		LocationDAO dao = new LocationDAO();

		ArrayList<LocationENT> ents = dao.getAllLocationsForUser("NMMU", "3",
				"");
		for (int i = 0; i < ents.size(); i++) {
			float[] pXy = new float[2];
//			dao.saveEntrance(new EntranceIntersectionENT(ents.get(i)
//					.getLocationID(), ents.get(i).getParentId(), ents.get(i)
//					.getLocationName(), ents.get(i).getGps(), false), null);
			if (ents.get(i).getBoundary() != null
					&& ents.get(i).getBoundary().length() > 10) {
				ArrayList<EntranceIntersectionENT> rnt = dao
						.getEntrancesForALocation(ents.get(i), null);
				String[] tmp = ents.get(i).getBoundary().split(";")[0]
						.split("_");
				float[][] aXys = new float[tmp.length][2];
				for (int j = 0; j < aXys.length; j++) {
					aXys[j][0] = Float.parseFloat(tmp[j].split(",")[0]);
					aXys[j][1] = Float.parseFloat(tmp[j].split(",")[1]);
				}
				for (int j = 0; j < rnt.size(); j++) {
					pXy[0] = Float
							.parseFloat(rnt.get(j).getGps().split(",")[0]);
					pXy[1] = Float
							.parseFloat(rnt.get(j).getGps().split(",")[0]);
					System.out.println(ents.get(i).getLocationName());
					dao.saveEntrance(
							new EntranceIntersectionENT(ents.get(i)
									.getLocationID(), ents.get(i)
									.getLocationID(), ents.get(i)
									.getLocationName(), dao
									.getClosestPointOnLines(pXy, aXys), true),
							null);
				}
			}
		}
	}

	public static void main(String[] args) {
		// updateAllGPS();
		DataManagementLocation daomng = new DataManagementLocation();

		// try {
		// daomng.getAllPaths();
		// } catch (AMSException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
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
		updatePointsToBoundary();
		LocationDAO dao = new LocationDAO();

//		ArrayList<LocationENT> ents = dao.getAllLocationsForUser("NMMU", "5",
//				"");
//		for (int i = 0; i < ents.size(); i++) {
			// System.out.println(ents.get(i).getLocationName());
			// try {
			// dao.deleteLocation(ents.get(i));
			// } catch (AMSException e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			// }
//			float[] pXy = new float[2];
//			dao.saveEntrance(new EntranceIntersectionENT(ents.get(i)
//					.getLocationID(), ents.get(i).getParentId(), ents.get(i)
//					.getLocationName(), ents.get(i).getGps(), false), null);
//			if (ents.get(i).getBoundary() != null
//					&& ents.get(i).getBoundary().length() > 10) {
//				ArrayList<EntranceIntersectionENT> rnt = dao
//						.getEntrancesForALocation(ents.get(i), null);
//				String[] tmp = ents.get(i).getBoundary().split(";")[0]
//						.split("_");
//				float[][] aXys = new float[tmp.length][2];
//				for (int j = 0; j < aXys.length; j++) {
//					aXys[j][0] = Float.parseFloat(tmp[j].split(",")[0]);
//					aXys[j][1] = Float.parseFloat(tmp[j].split(",")[1]);
//				}
//				for (int j = 0; j < rnt.size(); j++) {
//					pXy[0] = Float
//							.parseFloat(rnt.get(j).getGps().split(",")[0]);
//					pXy[1] = Float
//							.parseFloat(rnt.get(j).getGps().split(",")[0]);
//					System.out.println(ents.get(i).getLocationName());
//					dao.saveEntrance(
//							new EntranceIntersectionENT(ents.get(i)
//									.getLocationID(), ents.get(i)
//									.getLocationID(), ents.get(i)
//									.getLocationName(), dao
//									.getClosestPointOnLines(pXy, aXys), true),
//							null);
//				}
//				// Ent
//			}
			// float[][] aXys = {
			// { (float) -34.0087283359749, (float) 25.669569075107574 },
			// { (float) -34.00872769326653, (float) 25.67026913166046 },
			// { (float) -34.00857650033025, (float) 25.670275837183 },
			// { (float) -34.008569830047456, (float) 25.67030668258667 },
			// { (float) -34.00852647319649, (float) 25.670305341482162 },
			// { (float) -34.00851202090791, (float) 25.670271813869476 },
			// { (float) -34.00843975942813, (float) 25.670273154973984 },
			// { (float) -34.008441982859196, (float) 25.66928744316101 },
			// { (float) -34.008619857155686, (float) 25.66927805542946 },
			// { (float) -34.0086131868763, (float) 25.669338405132294 },
			// { (float) -34.00872769326653, (float) 25.669342428445816 },
			// { (float) -34.00872324641931, (float) 25.669448375701904 },
			// { (float) -34.008783278837186, (float) 25.669453740119934 },
			// { (float) -34.00878550225925, (float) 25.669552981853485 } };
//		}
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

		// updateAllDescriptions();
	}
}
