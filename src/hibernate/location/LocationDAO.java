package hibernate.location;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
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
import common.location.LocationLightENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import hibernate.config.BaseHibernateDAO;
import hibernate.config.HibernateSessionFactory;
import tools.AMSException;
import tools.QRBarcodeGen;

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
			query = "insert into location (country, address, post_box, gps, location_name, username, location_type, parent_id)"
					+ " values (?, ?, ?, ?, ?, ?, ?, ?)";
			if (ent.getLocationID() > 0)
				query = "update location set country = ?, address = ?, post_box = ?, gps= ?, location_name = ?, username = ?, location_type = ? , parent_id = ? where location_id = ?";
			PreparedStatement ps = conn.prepareStatement(query,
					Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, ent.getCountry());
			ps.setString(2, ent.getAddress());
			ps.setString(3, ent.getPostBox());
			ps.setString(4, ent.getGps());
			ps.setString(5, ent.getLocationName());
			ps.setString(6, ent.getUserName());
			ps.setInt(7, ent.getLocationType().getLocationTypeId());
			ps.setLong(8, ent.getParentId());
			if (ent.getLocationID() > 0)
				ps.setLong(9, ent.getLocationID());
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				ent.setLocationID(rs.getLong(1));
			}
			ps.close();
			conn.close();
			ent = getLocationENT(ent);
			if (ent.getLocationType().getLocationTypeId() == 3) {
				ent.setParentId(ent.getLocationID());
				ent.setLocationID(0);
				ent.setLocationName("Ground");
				ent.setLocationType(new LocationTypeENT(4));
				try {
					saveUpdateLocation(ent);
				} catch (AMSException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				ent.setParentId(ent.getLocationID());
				ent.setLocationID(0);
				ent.setLocationName("Entrance");
				ent.setLocationType(new LocationTypeENT(10));
				try {
					saveUpdateLocation(ent);
				} catch (AMSException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
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

	public ArrayList<LocationENT> getAllLocationsForUser(String username,
			int locationTypeId, long parentLocationId) {
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
					+ " left join location_type lt on lt.location_type_id = l.location_type";
			query += " where l.username = '" + username + "' ";
			if (parentLocationId > 0)
				query += " and l.parent_id = " + parentLocationId;
			else if (locationTypeId > 0)
				query += " and l.location_type = " + locationTypeId;
			query += " order by l.location_name asc";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				locationENTs.add(new LocationENT(rs.getInt("location_id"), rs
						.getString("username"), new LocationTypeENT(rs
						.getInt("location_type"), rs.getString("locaName")), rs
						.getString("address"), rs.getString("post_box"), rs
						.getString("gps"), rs.getString("location_name"), rs
						.getLong("parent_id"), null));

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

	public LocationTypeENT getAllLocationTypeChildren(LocationTypeENT parent) {
		LocationTypeENT ent = null;
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			if (parent == null)
				parent = new LocationTypeENT(1);
			query = "select lt.* from location_type lt"
					+ " where lt.location_type_id = "
					+ parent.getLocationTypeId()
					+ " order by lt.location_type asc";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ent = new LocationTypeENT(rs.getInt("location_type_id"),
						rs.getString("location_type"), new LocationTypeENT(
								rs.getInt("parent_id")));
				ArrayList<LocationTypeENT> tmp = getLocationTypeTree(ent);
				ent.setChildren(tmp);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ent;
	}

	private ArrayList<LocationTypeENT> getLocationTypeTree(LocationTypeENT ent) {
		ArrayList<LocationTypeENT> res = new ArrayList<LocationTypeENT>();
		try {
			Connection conn = null;
			conn = getConnection();
			String query = "";
			query = "select lt.* from location_type lt"
					+ " where lt.parent_id = " + ent.getLocationTypeId()
					+ " order by lt.location_type asc";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			boolean end = false;
			while (rs.next()) {
				end = true;
				ent = new LocationTypeENT(rs.getInt("location_type_id"),
						rs.getString("location_type"), null, null);
				ent.setChildren(getLocationTypeTree(ent));
				res.add(ent);
			}
			ps.close();
			conn.close();
			if (!end)
				return null;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (AMSException e) {
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

	public ArrayList<PathENT> getAllPathsForOnePoint(long locationId, int type) {
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
				query = "Select * from paths where path_type != " + type
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
		ArrayList<LocationENT> points = dao
				.getAllLocationsForUser("NMMU", 0, 0);
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


	public ArrayList<PathENT> getShortestPath(long dep, long dest,
			int pathTypeId) {
		// if (graph == null)
		UndirectedGraph<Long, DefaultWeightedEdge> graph = createGraph(pathTypeId);
		// + System.currentTimeMillis());
		DijkstraShortestPath dsp = new DijkstraShortestPath<Long, DefaultWeightedEdge>(
				graph, dep, dest);
		List<DefaultWeightedEdge> shortest_path = dsp.findPathBetween(graph,
				dep, dest);
		ArrayList<PathENT> res = new ArrayList<PathENT>();
		for (int i = 0; i < shortest_path.size(); i++) {
			long source = graph.getEdgeSource(shortest_path.get(i));
			long target = graph.getEdgeTarget(shortest_path.get(i));
			if (i == 0 && source != dep) {
				long tmp = source;
				source = target;
				target = tmp;
			} else if (i > 0)
				if (source != res.get(i - 1).getDestination().getLocationID()) {
					long tmp = source;
					source = target;
					target = tmp;
				}
			res.add(new PathENT(getLocationENT(new LocationENT(source)),
					getLocationENT(new LocationENT(target))));
		}
		return res;
	}

	private static UndirectedGraph<Long, DefaultWeightedEdge> createGraph(
			int pathTypeId) {
		SimpleWeightedGraph<Long, DefaultWeightedEdge> g = new SimpleWeightedGraph<Long, DefaultWeightedEdge>(
				DefaultWeightedEdge.class);
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> points = dao
				.getAllLocationsForUser("NMMU", 0, 0);
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
		LocationENT from = findClosestLocation(fromCoordinate);
		LocationENT to = findClosestLocation(toCoordinate);
		return getShortestPath(from.getLocationID(), to.getLocationID(),
				pathTypeId);
	}

	public static void main(String[] args) {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> ent = dao.getAllLocationsForUser("NMMU", 3, 0);
		for (int i = 0; i < ent.size(); i++) {
			ent.get(i).setParentId(ent.get(i).getLocationID());
			ent.get(i).setLocationID(0);
			ent.get(i).setLocationName("Ground");
			ent.get(i).setLocationType(new LocationTypeENT(4));
			try {
				dao.saveUpdateLocation(ent.get(i));
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ent.get(i).setParentId(ent.get(i).getLocationID());
			ent.get(i).setLocationID(0);
			ent.get(i).setLocationName("Entrance");
			ent.get(i).setLocationType(new LocationTypeENT(10));
			try {
				dao.saveUpdateLocation(ent.get(i));
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
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

	public long saveTrip(long deptLocationId, long destLocationId) {
		long res = 0;
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			query = "insert into trips (departure_location_id, destination_location_id)"
					+ " values (?, ?)";
			PreparedStatement ps = conn.prepareStatement(query,
					Statement.RETURN_GENERATED_KEYS);
			ps.setLong(1, deptLocationId);
			ps.setLong(2, destLocationId);
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				res = rs.getLong(1);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public void deleteTrip(long tripId) {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "delete from trips where trip_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setLong(1, tripId);
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public PathENT getTrip(long tripId) {
		PathENT res = new PathENT();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "Select * from trips where trip_id = " + tripId;
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				res = new PathENT(getLocationENT(new LocationENT(
						rs.getLong("departure_location_id"))),
						getLocationENT(new LocationENT(rs
								.getLong("destination_location_id"))));
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public String getQRCodeForLocationENT(long locationId) {
		LocationLightENT qrent = null;
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			query = "SELECT GetFnLocationAncestors(" + locationId + ") as res";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			String[] concatParents = null;
			while (rs.next()) {
				concatParents = rs.getString("res").split(",");
			}
			query = "select l.location_name, l.location_id, l.parent_id, lt.location_type as locaTypeName, l.gps from location l "
					+ " left join location_type lt on lt.location_type_id = l.location_type"
					+ " where l.location_id = " + locationId;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				qrent = new LocationLightENT(rs.getLong("location_id"),
						rs.getString("locaTypeName"),
						rs.getString("location_name"), rs.getString("gps"),
						null);
				LocationLightENT tmp = getQRLocationENTTree(qrent,
						rs.getLong("parent_id"), concatParents);
				qrent.setP(tmp);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			qrent.setG(QRBarcodeGen.createQrCode(locationId + "", 666, "png"));
			json = mapper.writeValueAsString(qrent);
			// QRBarcodeGen barcodeGen = new QRBarcodeGen();
			// json = "{\"image\":\""
			// + QRBarcodeGen.createQrCode(locationId+"", 666, "png") + "\"}";
			System.out.println(json);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}

	private LocationLightENT getQRLocationENTTree(LocationLightENT ent,
			long parentId, String[] concatParents) {
		if (parentId <= 0) {
			ent.setP(null);
			return ent;
		}
		try {
			Connection conn = null;
			conn = getConnection();
			String query = "";
			query = "select l.location_name, l.location_id, l.parent_id, lt.location_type as locaTypeName from location l "
					+ " left join location_type lt on lt.location_type_id = l.location_type"
					+ " where l.location_id = " + parentId;
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				long tmpPID = rs.getLong("parent_id");
				ent = new LocationLightENT(rs.getLong("location_id"),
						rs.getString("locaTypeName"),
						rs.getString("location_name"), "", null);
				if (tmpPID > 0)
					ent.setP(getQRLocationENTTree(ent, tmpPID, Arrays
							.copyOfRange(concatParents, 0,
									concatParents.length - 1)));
				else
					return ent;
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return ent;
	}

	public LocationLST getParentLocationsOfaType(int locationTypeId) {
		LocationLST res = new LocationLST();
		try {
			Connection conn = null;
			conn = getConnection();
			String query = "";
			query = "select l.location_name, l.location_id, ltt.location_type from location_type lt"
					+ " inner join location l on lt.parent_id = l.location_type"
					+ " left join location_type ltt on ltt.location_type_id = lt.parent_id"
					+ " where lt.location_type_id ="
					+ locationTypeId
					+ " order by l.location_name asc";
			PreparedStatement ps = conn.prepareStatement(query);
			ArrayList<LocationLightENT> ents = new ArrayList<LocationLightENT>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				LocationLightENT ent = new LocationLightENT(
						rs.getLong("location_id"),
						rs.getString("location_type"),
						rs.getString("location_name"), "", null);
				ents.add(ent);
			}
			ps.close();
			conn.close();
			res.setLocationLightENTs(ents);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return res;
	}

}
