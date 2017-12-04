package hibernate.route;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.StringJoiner;

import org.jgrapht.UndirectedGraph;
import org.jgrapht.alg.DijkstraShortestPath;
import org.jgrapht.graph.DefaultWeightedEdge;

import common.location.LocationENT;
import common.location.LocationLightENT;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import graph.management.GraphGenerator;
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

	public PathENT savePath(PathENT path, Connection conn) {
		try {
			boolean isnew = false;
			if (conn == null)
				try {
					conn = getConnection();
					conn.setAutoCommit(false);
					isnew = true;
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
			LocationDAO ldao = new LocationDAO();
			if (path.getPathId() <= 0) {
				query = "select path_id from paths order by path_id desc limit 1";
				ps = conn.prepareStatement(query);
				ResultSet rs = ps.executeQuery();
				while (rs.next())
					path.setPathId(rs.getLong("path_id"));
			}
			path = savePathTypes(path, conn);
			path.setDeparture(ldao.getLocationENT(new LocationENT(path
					.getDeparture().getLocationID()), conn));
			path.setDestination(ldao.getLocationENT(new LocationENT(path
					.getDestination().getLocationID()), conn));
			ps.close();
			if (isnew) {
				conn.commit();
				conn.close();
			}
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
			boolean isnew = false;
			if (conn == null)
				try {
					conn = getConnection();
					conn.setAutoCommit(false);
					isnew = true;
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
			if (isnew)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return path;
	}

	public boolean deletePath(PathENT ent, Connection conn) throws AMSException {
		try {
			boolean isNewCon = false;
			if (conn == null)
				try {
					conn = getConnection();
					conn.setAutoCommit(false);
					isNewCon = true;
				} catch (AMSException e) {
					e.printStackTrace();
				}
			String query = "";
			query = "delete from path_path_type where path_id = "
					+ ent.getPathId();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.execute();
			ps.close();
			query = "delete from paths where path_id = ?";
			ps = conn.prepareStatement(query);
			ps.setLong(1, ent.getPathId());
			ps.execute();
			ps.close();
			if (isNewCon) {
				conn.commit();
				conn.close();
			}
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw getAMSException("", e);
		}
	}

	public PathENT getAPath(PathENT ent, Connection conn) {
		try {
			boolean isNewCon = false;
			if (conn == null)
				try {
					conn = getConnection();
					conn.setAutoCommit(false);
					isNewCon = true;
				} catch (AMSException e) {
					e.printStackTrace();
				}
			String query = "";
			query = "select * from paths where path_id = " + ent.getPathId();
			if (ent.getDeparture() != null
					&& ent.getDeparture().getLocationID() > 0
					&& ent.getDestination() != null
					&& ent.getDestination().getLocationID() > 0)
				query = "select * from paths where (departure_location_id = "
						+ ent.getDeparture().getLocationID()
						+ " and destination_location_id = "
						+ ent.getDestination().getLocationID()
						+ ") or (destination_location_id = "
						+ ent.getDeparture().getLocationID()
						+ " and departure_location_id = "
						+ ent.getDestination().getLocationID() + ")";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			LocationDAO dao = new LocationDAO();
			while (rs.next()) {
				LocationENT dep = dao.getLocationENT(
						new LocationENT(rs.getLong("departure_location_id")),
						conn);
				LocationENT des = dao.getLocationENT(
						new LocationENT(rs.getLong("destination_location_id")),
						conn);
				ent = new PathENT(dep, des);
				ent.setPathRoute(rs.getString("path_route"));
				ent.setPathId(rs.getLong("path_id"));
				ent.setPathTypes(getPathTypesOfAPath(rs.getLong("path_id"),
						conn));
				ent.setWidth(rs.getDouble("width"));
				ent.setPathName(rs.getString("path_Name"));
				ent.setDescription(rs.getString("description"));
			}
			ps.close();
			if (isNewCon) {
				conn.commit();
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ent;
	}

	private ArrayList<PathTypeENT> getPathTypesOfAPath(long pathId,
			Connection conn) {
		ArrayList<PathTypeENT> res = new ArrayList<PathTypeENT>();
		boolean isNewCon = false;
		if (conn == null)
			try {
				conn = getConnection();
				isNewCon = true;
			} catch (AMSException e) {
				e.printStackTrace();
			}
		String query = "select ppt.*, p.path_type from path_path_type ppt "
				+ " left join path_type p on p.path_type_id = ppt.path_type_id "
				+ " where path_id = " + pathId;
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				res.add(new PathTypeENT(rs.getInt("path_type_id"), rs
						.getString("path_type")));
			}
			ps.close();
			if (isNewCon)
				conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return res;
	}

	public ArrayList<PathENT> getShortestPath(long dep, long dest,
			int pathTypeId, String clientName, int areaId) {
		UndirectedGraph<Long, DefaultWeightedEdge> graph = null;
		GraphGenerator g = new GraphGenerator();
		if (g.fetchGraph(clientName, areaId, pathTypeId) == null)
			g.generateGraph(clientName, areaId, pathTypeId);
		graph = g.fetchGraph(clientName, areaId, pathTypeId);
		DijkstraShortestPath dsp = new DijkstraShortestPath<Long, DefaultWeightedEdge>(
				graph, dep, dest);
		List<DefaultWeightedEdge> shortest_path = dsp.findPathBetween(graph,
				dep, dest);
		ArrayList<PathENT> res = new ArrayList<PathENT>();
		if (shortest_path == null)
			shortest_path = new ArrayList<DefaultWeightedEdge>();
		for (int i = 0; i < shortest_path.size(); i++) {
			long source = graph.getEdgeSource(shortest_path.get(i));
			long target = graph.getEdgeTarget(shortest_path.get(i));
			PathENT tmpPath = getAPath(new PathENT(new LocationENT(source),
					new LocationENT(target)), null);
			LocationLightENT srcLoc = tmpPath.getDepL();
			LocationLightENT tarLoc = tmpPath.getDesL();
			String pathRoute = tmpPath.getPathRoute();
			String resPathRoute = "";
			if (i == 0 && source != dep) {
				long tmp = source;
				source = target;
				target = tmp;
				LocationLightENT tmpLoc = srcLoc;
				srcLoc = tarLoc;
				tarLoc = tmpLoc;
				if (pathRoute != null && pathRoute.length() > 0) {
					String[] tmpPathRoute = pathRoute.split("_");
					for (int j = tmpPathRoute.length - 1; j >= 0; j--) {
						if (j != 0)
							resPathRoute += tmpPathRoute[j] + "_";
						else
							resPathRoute += tmpPathRoute[j];
					}
				}
			} else if (i > 0)
				if (source != res.get(i - 1).getDesL().getId()) {
					long tmp = source;
					source = target;
					target = tmp;
					LocationLightENT tmpLoc = srcLoc;
					srcLoc = tarLoc;
					tarLoc = tmpLoc;
					if (pathRoute != null && pathRoute.length() > 0) {
						String[] tmpPathRoute = pathRoute.split("_");
						for (int j = tmpPathRoute.length - 1; j >= 0; j--) {
							if (j != 0)
								resPathRoute += tmpPathRoute[j] + "_";
							else
								resPathRoute += tmpPathRoute[j];
						}
					}
				}
			if (resPathRoute.length() > 0)
				tmpPath.setPathRoute(resPathRoute);
			tmpPath.setDesL(tarLoc);
			tmpPath.setDepL(srcLoc);
			res.add(tmpPath);
		}
		return res;
	}

	public ArrayList<PathENT> createAPointOnPath(long pathId, String pointGPS,
			int index) {
		ArrayList<PathENT> res = new ArrayList<PathENT>();
		Connection conn = null;
		final PathENT p = getAPath(new PathENT(pathId), null);
		final long depId = p.getDeparture().getLocationID();
		final long desId = p.getDestination().getLocationID();
		LocationENT ent = new LocationENT();
		ent.setGps(pointGPS);
		ent.setLocationName("Intersection");
		ent.setLocationType(new LocationTypeENT(5));
		ent.setClientName(p.getDeparture().getClientName());
		ent.setParentId(p.getDeparture().getParentId());
		LocationDAO dao = new LocationDAO();
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			ent = dao.saveUpdateLocation(ent, conn);
			String[] points = p.getPathRoute().split("_");
			StringJoiner firstRoute = new StringJoiner("_");
			StringJoiner secondRoute = new StringJoiner("_");
			for (int i = 0; i < points.length; i++) {
				if (i < index - 1)
					firstRoute.add(points[i]);
				else
					secondRoute.add(points[i]);
			}
			PathENT path = p;
			path.setPathId(0);
			path.setDeparture(new LocationENT(depId));
			path.setDestination(new LocationENT(ent.getLocationID()));
			path.setPathRoute(firstRoute.toString());
			path = savePath(path, conn);
			res.add(getAPath(new PathENT(path.getPathId()), conn));
			path.setPathId(0);
			path.setDeparture(new LocationENT(ent.getLocationID()));
			path.setDestination(new LocationENT(desId));
			path.setPathRoute(secondRoute.toString());
			path = savePath(path, conn);
			res.add(getAPath(new PathENT(path.getPathId()), conn));
			deletePath(new PathENT(pathId), conn);
			conn.commit();
			conn.close();
		} catch (AMSException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

}