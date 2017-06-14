package hibernate.location;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.jgrapht.UndirectedGraph;
import org.jgrapht.alg.DijkstraShortestPath;
import org.jgrapht.graph.DefaultWeightedEdge;
import org.jgrapht.graph.SimpleWeightedGraph;

import com.mysql.jdbc.Statement;

import common.DropDownENT;
import common.location.CountryENT;
import common.location.LocationENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import hibernate.config.BaseHibernateDAO;
import hibernate.config.HibernateSessionFactory;
import tools.AMSException;

public class LocationDAO extends BaseHibernateDAO implements
		LocationDAOInterface {

	public LocationENT saveUpdateLocation(LocationENT ent) throws AMSException {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			query = "insert into location (country, address, post_box, gps, location_name, username, location_type)"
					+ " values (?, ?, ?, ?, ?, ?, ?)";
			if (ent.getLocationID() > 0)
				query = "update location set country = ?, address = ?, post_box = ?, location_name = ?, username = ?, location_type = ? where location_id = ?";
			PreparedStatement ps = conn.prepareStatement(query,
					Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, ent.getCountry());
			ps.setString(2, ent.getAddress());
			ps.setString(3, ent.getPostBox());
			ps.setString(4, ent.getGps());
			ps.setString(5, ent.getLocationName());
			ps.setString(6, ent.getUserName());
			ps.setInt(7, ent.getLocationType().getLocationTypeId());
			if (ent.getLocationID() > 0)
				ps.setLong(8, ent.getLocationID());
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				ent.setLocationID(rs.getLong(1));
			}
			ps.close();
			conn.close();
			ent = getLocationENT(ent);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ent;
	}

	public LocationLST getLocationLST(LocationLST lst) throws AMSException {
		ArrayList<LocationENT> locationENTs = new ArrayList<LocationENT>();
		Query q = null;
		String username = lst.getSearchLocation().getUserName();
		try {
			String query = "from LocationENT where state like :state or street like :street or area like :area "
					+ "or cell like :cell or email like :email  ";
			if (username != null && !username.equalsIgnoreCase(""))
				query += "and userName = " + username;
			query += " order by " + lst.getSortedByField();
			if (lst.isAscending())
				query += " Asc";
			else
				query += " Desc";
			q = getSession().createQuery(query);
			lst.setTotalItems(q.list().size());
			q.setFirstResult(lst.getFirst());
			q.setMaxResults(lst.getPageSize());
			locationENTs = (ArrayList<LocationENT>) q.list();
			lst.setLocationENTs(locationENTs);
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
			throw getAMSException("", ex);
		}
		return lst;
	}

	public LocationENT getLocationENT(LocationENT ent) {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			query = "select l.*, lt.location_type as locaTypeName from location l "
					+ " left join location_type lt on lt.location_type_id = l.location_type"
					+ " where l.location_id = " + ent.getLocationID();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ent = new LocationENT(rs.getInt("location_id"),
						rs.getString("username"), new LocationTypeENT(
								rs.getInt("location_type"),
								rs.getString("locaTypeName")),
						rs.getString("address"), rs.getString("gps"),
						rs.getString("location_name"));
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ent;
	}

	public boolean deleteLocation(LocationENT ent) throws AMSException {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "delete from location where location_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setLong(1, ent.getLocationID());
			ps.execute();
			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw getAMSException("", e);
		}
	}

	public ArrayList<DropDownENT> getAllCountrirs() {
		ArrayList<DropDownENT> res = new ArrayList<DropDownENT>();
		try {
			Session s = getSession4Query();
			s.beginTransaction();
			List<CountryENT> dropdowns = getSession4Query().createQuery(
					"from CountryENT").list();
			for (CountryENT dropdown : dropdowns) {
				res.add(new DropDownENT(dropdown.getCountryID() + "", dropdown
						.getCountryName()
						+ " ("
						+ dropdown.getCountryCode()
						+ ")", null));
			}
			s.close();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return res;
	}

	public ArrayList<LocationENT> getAllLocationsForUser(String username) {
		ArrayList<LocationENT> locationENTs = new ArrayList<LocationENT>();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			query = "select l.*, lt.location_type as locaName from location l "
					+ " left join location_type lt on lt.location_type_id = l.location_type"
					+ " where l.username = '" + username + "'";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				locationENTs.add(new LocationENT(rs.getInt("location_id"), rs
						.getString("username"), new LocationTypeENT(rs
						.getInt("location_type"), rs.getString("locaName")), rs
						.getString("address"), rs.getString("gps"), rs
						.getString("location_name")));
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return locationENTs;
	}

	public ArrayList<PathTypeENT> getAllPathTypes() {
		ArrayList<PathTypeENT> res = new ArrayList<PathTypeENT>();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "Select * from path_type";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				PathTypeENT p = new PathTypeENT(rs.getInt("path_type_id"),
						rs.getString("path_type"));
				res.add(p);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public ArrayList<LocationTypeENT> getAllLocationTypes() {
		ArrayList<LocationTypeENT> res = new ArrayList<LocationTypeENT>();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "Select * from location_type";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				LocationTypeENT l = new LocationTypeENT(
						rs.getInt("location_type_id"),
						rs.getString("location_type"));
				res.add(l);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public ArrayList<PathENT> getAllPaths(String username) {
		ArrayList<PathENT> res = new ArrayList<PathENT>();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "Select p.*, pt.* from paths p "
					+ "inner join location lf on lf.location_id = p.destination_location_id "
					+ " left join path_type pt on pt.path_type_id = p.path_type"
					+ " where lf.username = '" + username + "'";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				PathENT p = new PathENT(getLocationENT(new LocationENT(
						rs.getLong("departure_location_id"))),
						getLocationENT(new LocationENT(rs
								.getLong("destination_location_id"))),
						rs.getDouble("distance"), new PathTypeENT(
								rs.getInt("path_type_id"),
								rs.getString("pt.path_type")),
						rs.getLong("path_id"));
				res.add(p);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	private ArrayList<PathENT> getAllPathsForOnePoint(long locationId, int type) {
		ArrayList<PathENT> res = new ArrayList<PathENT>();
		Connection conn = null;
		try {
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			if (type == 0)
				query = "Select * from paths "
						+ "where destination_location_id = '" + locationId
						+ "' or departure_location_id = '" + locationId + "'";
			else
				query = "Select * from paths " + "where path_type != " + type
						+ " and (destination_location_id = '" + locationId
						+ "' or departure_location_id = '" + locationId + "')";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				PathENT p = new PathENT(getLocationENT(new LocationENT(
						rs.getLong("departure_location_id"))),
						getLocationENT(new LocationENT(rs
								.getLong("destination_location_id"))),
						rs.getDouble("distance"), new PathTypeENT(
								rs.getInt("path_type")), rs.getLong("path_id"));
				res.add(p);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			try {
				conn.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return res;
	}

	public void savePath(PathENT path) {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			path.setDestination(getLocationENT(new LocationENT(path
					.getDestination().getLocationID())));
			path.setDeparture(getLocationENT(new LocationENT(path
					.getDeparture().getLocationID())));
			String query = "";
			query = "insert into paths (destination_location_id, departure_location_id, distance, path_type)"
					+ " values (?, ?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setLong(1, path.getDestination().getLocationID());
			ps.setLong(2, path.getDeparture().getLocationID());
			double distance = calculateDistance(path.getDestination().getGps(),
					path.getDeparture().getGps());
			distance = reEvaluateDistance(distance, path.getPathType()
					.getPathTypeId());
			ps.setDouble(3, distance);
			ps.setInt(4, path.getPathType().getPathTypeId());
			ps.execute();
			ps.close();
			query = "select path_id from paths order by path_id desc limit 1";
			ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				path.setPathId(rs.getLong("path_id"));
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private double reEvaluateDistance(double distance, int pathTypeId) {
		if (pathTypeId == 6)// stairways
			distance += 2.00;
		return distance;
	}

	private static double calculateDistance(String gps, String gps2) {
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

	public LocationENT findClosestLocation(String GPSCoordinates) {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> points = dao.getAllLocationsForUser("admin");
		int closest = -1;
		double[] distances = new double[points.size()];
		for (int i = 0; i < points.size(); i++) {
			distances[i] = calculateDistance(points.get(i).getGps(),
					GPSCoordinates);
			if (closest == -1 || distances[i] < distances[closest]) {
				closest = i;
			}
		}
		return points.get(closest);
	}

	private ArrayList<PathENT> getShortestPath(long dep, long dest,
			int pathTypeId) {
		System.out.println(">>>> graph >>>> " + System.currentTimeMillis());
		UndirectedGraph<Long, DefaultWeightedEdge> graphOfPaths = createGraph(pathTypeId);
		System.out.println(">>>> graph >>>> " + System.currentTimeMillis());
		System.out.println(">>>> shortest path object >>>> "
				+ System.currentTimeMillis());
		DijkstraShortestPath dsp = new DijkstraShortestPath<Long, DefaultWeightedEdge>(
				graphOfPaths, dep, dest);
		System.out.println(">>>> spath object >>>> "
				+ System.currentTimeMillis());
		List<DefaultWeightedEdge> shortest_path = dsp.findPathBetween(
				graphOfPaths, dep, dest);
		System.out.println(">>>> create paths >>>> "
				+ System.currentTimeMillis());
		ArrayList<PathENT> res = new ArrayList<PathENT>();
		for (int i = 0; i < shortest_path.size(); i++) {
			long source = graphOfPaths.getEdgeSource(shortest_path.get(i));
			long target = graphOfPaths.getEdgeTarget(shortest_path.get(i));
			res.add(new PathENT(getLocationENT(new LocationENT(source)),
					getLocationENT(new LocationENT(target))));
		}
		System.out.println(">>>> create paths >>>> "
				+ System.currentTimeMillis());
		return res;
	}

	private static UndirectedGraph<Long, DefaultWeightedEdge> createGraph(
			int pathTypeId) {
		SimpleWeightedGraph<Long, DefaultWeightedEdge> g = new SimpleWeightedGraph<Long, DefaultWeightedEdge>(
				DefaultWeightedEdge.class);
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> points = dao.getAllLocationsForUser("admin");
		for (int i = 0; i < points.size(); i++) {
			long depTMP = points.get(i).getLocationID();
			if (!g.containsVertex(depTMP))
				g.addVertex(depTMP);
			ArrayList<PathENT> ptz = dao.getAllPathsForOnePoint(depTMP,
					pathTypeId);
			for (int j = 0; j < ptz.size(); j++) {
				long destTMP = ptz.get(j).getDestination().getLocationID();
				depTMP = ptz.get(j).getDeparture().getLocationID();
				if (!g.containsVertex(destTMP)) {
					g.addVertex(destTMP);
				}
				if (!g.containsVertex(depTMP)) {
					g.addVertex(depTMP);
				}
				DefaultWeightedEdge edg = g.addEdge(depTMP, destTMP);
				if (edg != null)
					g.setEdgeWeight(edg, ptz.get(j).getDistance());
			}
		}
		return g;
	}

	public ArrayList<PathENT> getAPathFromTo(String fromCoordinate,
			String toCoordinate, int pathTypeId) {
		System.out.println(">>>> getAPathFromTo >>>> "
				+ System.currentTimeMillis());
		LocationENT from = findClosestLocation(fromCoordinate);
		LocationENT to = findClosestLocation(toCoordinate);
		System.out.println(">>>> getAPathFromTo >>>> "
				+ System.currentTimeMillis());
		return getShortestPath(from.getLocationID(), to.getLocationID(),
				pathTypeId);
	}

	public static void main(String[] args) {
		LocationDAO dao = new LocationDAO();
		// getShortestPath(61, 64);

	}

	public PathENT getAPath(PathENT ent) {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			query = "select * from paths where path_id = " + ent.getPathId();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ent = new PathENT(getLocationENT(new LocationENT(
						rs.getLong("departure_location_id"))),
						getLocationENT(new LocationENT(rs
								.getLong("destination_location_id"))),
						rs.getDouble("distance"), new PathTypeENT(
								rs.getInt("path_type")), rs.getLong("path_id"));
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ent;
	}

	public boolean deletePath(PathENT ent) throws AMSException {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "delete from paths where path_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setLong(1, ent.getPathId());
			ps.execute();
			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw getAMSException("", e);
		}
	}
}
