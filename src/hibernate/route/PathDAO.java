package hibernate.route;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import common.location.LocationENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import hibernate.config.BaseHibernateDAO;
import hibernate.location.LocationDAO;
import tools.AMSException;

public class PathDAO extends BaseHibernateDAO implements PathDAOInterface {

	public ArrayList<PathENT> getRoutesForUserAndParent(String username,
			long parentId) {
		ArrayList<PathENT> res = new ArrayList<PathENT>();
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		try {
			String query = "Select p.*, pt.*, GROUP_CONCAT(ppt.path_type_id) as pathtypeString from paths p "
					+ "inner join location lf on lf.location_id = p.destination_location_id "
					+ " inner join path_path_type ppt on ppt.path_id = p.path_id"
					+ " inner join path_type pt on pt.path_type_id = ppt.path_type_id"
					+ " where lf.client_name = '"
					+ username
					+ "' and lf.parent_id = "
					+ parentId
					+ " group by p.path_id";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			LocationDAO ldao = new LocationDAO();
			while (rs.next()) {
				PathENT ent = new PathENT(ldao.getLocationENT(new LocationENT(
						rs.getLong("departure_location_id")), conn),
						ldao.getLocationENT(
								new LocationENT(rs
										.getLong("destination_location_id")),
								conn), rs.getDouble("distance"),
						rs.getString("pathtypeString"), rs.getLong("path_id"),
						rs.getString("path_route"), rs.getDouble("width"),
						rs.getString("path_Name"), rs.getString("description"));
				res.add(ent);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public PathENT savePath(PathENT path) {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
				conn.setAutoCommit(false);
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			query = "insert into paths (destination_location_id, departure_location_id, distance, path_route, path_name, description, width)"
					+ " values (?, ?, ?, ?, ?, ?, ?)";
			if (path.getPathId() > 0)
				query = "update paths set destination_location_id = ?, departure_location_id = ?, "
						+ "distance = ?, path_route = ?,  path_name = ?, description = ?, width = ?"
						+ " where path_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setLong(1, path.getDestination().getLocationID());
			ps.setLong(2, path.getDeparture().getLocationID());
			ps.setDouble(3,
					reEvaluateDistance(path.getDistance(), path.getPathTypes()));
			ps.setString(4, path.getPathRoute());
			ps.setString(5, path.getPathName());
			ps.setString(6, path.getDescription());
			ps.setDouble(7, path.getWidth());
			if (path.getPathId() > 0)
				ps.setLong(8, path.getPathId());
			ps.execute();
			ps.close();
			if (path.getPathId() <= 0) {
				query = "select path_id from paths order by path_id desc limit 1";
				ps = conn.prepareStatement(query);
				ResultSet rs = ps.executeQuery();
				while (rs.next())
					path.setPathId(rs.getLong("path_id"));
			}
			path = savePathTypes(path, conn);
			ps.close();
			conn.commit();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return path;
	}

	public static double calculateDistanceBetweenTwoPoints(String gps,
			String gps2) {
		final int R = 6371;
		double latDistance = Math
				.toRadians(Double.parseDouble(gps2.split(",")[0])
						- Double.parseDouble(gps.split(",")[0]));
		double lonDistance = Math
				.toRadians(Double.parseDouble(gps2.split(",")[1])
						- Double.parseDouble(gps.split(",")[1]));
		double a = Math.sin(latDistance / 2)
				* Math.sin(latDistance / 2)
				+ Math.cos(Math.toRadians(Double.parseDouble(gps.split(",")[0])))
				* Math.cos(Math.toRadians(Double.parseDouble(gps2.split(",")[0])))
				* Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		double outp = (double) Double.parseDouble(new DecimalFormat(".##")
				.format(R * c * 1000));
		return outp;
	}

	public static double calculateDistance(String departure,
			String destination, String pathRoute) {
		double outp = 0;
		if (pathRoute != null && pathRoute.length() > 1) {
			String[] points = pathRoute.split("_");
			if (points.length > 1) {
				for (int i = 0; i < points.length; i++) {
					if (i == 0)
						outp += calculateDistanceBetweenTwoPoints(departure,
								points[i]);
					else
						outp += calculateDistanceBetweenTwoPoints(
								points[i - 1], points[i]);
				}
				outp += calculateDistanceBetweenTwoPoints(destination,
						points[points.length - 1]);
			} else {
				outp += calculateDistanceBetweenTwoPoints(departure, pathRoute);
				outp += calculateDistanceBetweenTwoPoints(pathRoute,
						destination);
			}
		} else {
			outp = calculateDistanceBetweenTwoPoints(destination, departure);
		}
		outp = (double) Double.parseDouble(new DecimalFormat(".##")
				.format(outp));
		return outp;
	}

	public ArrayList<PathTypeENT> getRoutesForUserAndParent(
			ArrayList<PathTypeENT> pathTypeENTs, Connection conn) {
		// TODO Auto-generated method stub
		return null;
	}

	private double reEvaluateDistance(double distance,
			ArrayList<PathTypeENT> pathTypes) {
		for (int i = 0; i < pathTypes.size(); i++) {
			int pathTypeId = pathTypes.get(i).getPathTypeId();
			if (pathTypeId == 6)// stairways
				distance += 2.00;
		}
		return distance;
	}

	public PathENT savePathTypes(PathENT path, Connection conn) {
		try {
			if (conn == null)
				try {
					conn = getConnection();
					conn.setAutoCommit(false);
				} catch (AMSException e) {
					e.printStackTrace();
				}
			String query = "";
			query = "delete from path_path_type where path_id = "
					+ path.getPathId();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.execute();
			ps.close();
			query = "insert into path_path_type (path_id, path_type_id)"
					+ " values (? , ?)";
			for (int i = 0; i < path.getPathTypes().size(); i++) {
				ps = conn.prepareStatement(query);
				ps.setLong(1, path.getPathId());
				ps.setLong(2, path.getPathTypes().get(i).getPathTypeId());
				ps.execute();
				ps.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return path;
	}

}