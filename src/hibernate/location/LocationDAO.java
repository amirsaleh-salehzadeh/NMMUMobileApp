package hibernate.location;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javassist.bytecode.stackmap.BasicBlock.Catch;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.eclipse.jdt.internal.compiler.ast.ThrowStatement;
import org.jgrapht.UndirectedGraph;
import org.jgrapht.alg.DijkstraShortestPath;
import org.jgrapht.graph.DefaultWeightedEdge;
import org.jgrapht.graph.SimpleWeightedGraph;

import com.mysql.jdbc.Statement;

import common.DropDownENT;
import common.location.EntranceIntersectionENT;
import common.location.LevelENT;
import common.location.LocationENT;
import common.location.LocationLightENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import graph.management.GraphGenerator;
import hibernate.config.BaseHibernateDAO;
import hibernate.route.PathDAO;
import tools.AMSException;
import tools.QRBarcodeGen;

public class LocationDAO extends BaseHibernateDAO implements
		LocationDAOInterface {

	public LocationENT saveUpdateLocation(LocationENT ent, Connection conn)
			throws AMSException {
		try {
			boolean isnew = false;
			if (conn == null)
				try {
					conn = getConnection();
					isnew = true;
				} catch (AMSException e) {
					e.printStackTrace();
				}
			String query = "";
			query = "insert into location (gps, location_name, client_name, location_type, parent_id, description, boundary, plan, icon)"
					+ " values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			if (ent.getLocationID() > 0)
				query = "update location set gps= ?, location_name = ?, client_name = ?, location_type = ? , parent_id = ? , description = ?, boundary = ? , plan = ?, icon = ? where location_id = ?";
			PreparedStatement ps = conn.prepareStatement(query,
					Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, ent.getGps());
			ps.setString(2, ent.getLocationName());
			ps.setString(3, ent.getClientName());
			ps.setInt(4, ent.getLocationType().getLocationTypeId());
			ps.setLong(5, ent.getParentId());
			ps.setString(6, ent.getDescription());
			ps.setString(7, ent.getBoundary());
			ps.setString(8, ent.getPlan());
			ps.setString(9, ent.getIcon());
			if (ent.getLocationID() > 0)
				ps.setLong(10, ent.getLocationID());
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				ent.setLocationID(rs.getLong("location_id"));
			}
			rs.close();
			ps.close();
			if (isnew)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ent;
	}

	public LocationENT getLocationENT(LocationENT ent, Connection conn) {
		try {
			boolean isNewCon = false;
			if (conn == null)
				try {
					conn = getConnection();
					isNewCon = true;
				} catch (AMSException e) {
					e.printStackTrace();
				}
			String query = "";
			query = "select l.*, lt.location_type as locaTypeName from location l "
					+ " left join location_type lt on lt.location_type_id = l.location_type"
					+ " where l.location_id = "
					+ ent.getLocationID()
					+ " or l.gps = '" + ent.getGps() + "'";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ent = new LocationENT(rs.getLong("location_id"),
						rs.getString("client_name"), new LocationTypeENT(
								rs.getInt("location_type"),
								rs.getString("locaTypeName")),
						rs.getString("gps"), rs.getString("location_name"));
				ent.setIcon(rs.getString("icon"));
				ent.setParentId(rs.getLong("parent_id"));
				ent.setBoundary(rs.getString("boundary"));
				if (rs.getLong("parent_id") > 0)
					ent.setParent(getLocationENT(
							new LocationENT(rs.getLong("parent_id")), conn));
			}
			rs.close();
			ps.close();
			if (isNewCon)
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
		// try {
		// Session s = getSession4Query();
		// s.beginTransaction();
		// List<CountryENT> dropdowns = getSession4Query().createQuery(
		// "from CountryENT").list();
		// for (CountryENT dropdown : dropdowns) {
		// res.add(new DropDownENT(dropdown.getCountryID() + "", dropdown
		// .getCountryName()
		// + " ("
		// + dropdown.getCountryCode()
		// + ")", null));
		// }
		// s.close();
		// } catch (HibernateException ex) {
		// ex.printStackTrace();
		// }
		return res;
	}

	public ArrayList<LocationENT> getAllLocationsForUser(String username,
			String locationTypeIds, String parentLocationIds) {
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
			query += " where l.client_name = '" + username + "'";
			if (parentLocationIds != null && parentLocationIds.length() >= 1)
				query += " and l.parent_id in (" + parentLocationIds + ")";
			if (locationTypeIds != null && locationTypeIds.length() >= 1)
				query += " and l.location_type in (" + locationTypeIds + ")";
			query += " order by l.location_name asc";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				LocationENT ent = new LocationENT(rs.getLong("location_id"),
						rs.getString("client_name"), new LocationTypeENT(
								rs.getInt("location_type"),
								rs.getString("locaName")), rs.getString("gps"),
						rs.getString("location_name"), rs.getLong("parent_id"),
						null);
				ent.setBoundary(rs.getString("boundary"));
				ent.setDescription(rs.getString("description"));
				ent.setIcon(rs.getString("icon"));
				ent.setPlan(rs.getString("plan"));
				ent.setLevels(getLevelsForALocation(ent, conn));
				ent.setEntrances(getEntrancesForALocation(ent, conn));
				if (rs.getLong("parent_id") > 0)
					ent.setParent(getLocationENT(
							new LocationENT(rs.getLong("parent_id")), conn));
				locationENTs.add(ent);
			}
			rs.close();
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
			rs.close();
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
				ArrayList<LocationTypeENT> tmp = getLocationTypeTree(ent, conn);
				ent.setChildren(tmp);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ent;
	}

	public LocationENT getLocationWithChildren(LocationENT parent) {
		LocationENT ent = null;
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "";
			query = "select l.*, lt.location_type_id, lt.location_type ltname from location l"
					+ " left join location_type lt on lt. location_type_id = l.location_type"
					+ " where l.location_id = "
					+ parent.getLocationID()
					+ " and l.location_type != 5 order by l.location_id asc";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ent = new LocationENT(rs.getLong("location_id"),
						rs.getString("client_name"), new LocationTypeENT(
								rs.getInt("location_type_id"),
								rs.getString("ltname")), rs.getString("gps"),
						rs.getString("location_name"));
				ent.setIcon(rs.getString("icon"));
				ent.setDescription(rs.getString("description"));
				ent.setParentId(rs.getLong("parent_id"));
				ent.setChildrenENT(getLocationENTTree(ent));
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ent;
	}

	private ArrayList<LocationENT> getLocationENTTree(LocationENT ent) {
		ArrayList<LocationENT> res = new ArrayList<LocationENT>();
		// if (ent.getLocationType().getLocationTypeId() >= 3)
		// return null;
		try {
			Connection conn = null;
			conn = getConnection();
			String query = "";
			query = "select l.*, lt.location_type ltname from location l"
					+ " left join location_type lt on lt. location_type_id = l.location_type"
					+ " where l.location_type != 5 and l.parent_id = "
					+ ent.getLocationID() + " order by l.location_id asc";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			boolean end = false;
			while (rs.next()) {
				end = true;
				ent = new LocationENT(rs.getLong("location_id"),
						rs.getString("client_name"), new LocationTypeENT(
								rs.getInt("location_type"),
								rs.getString("ltname")), rs.getString("gps"),
						rs.getString("location_name"));
				ent.setIcon(rs.getString("icon"));
				ent.setParentId(rs.getLong("parent_id"));
				ent.setDescription(rs.getString("description"));
				ent.setChildrenENT(getLocationENTTree(ent));
				// if (rs.getInt("location_type_id") > 3)
				// break;
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

	private ArrayList<LocationTypeENT> getLocationTypeTree(LocationTypeENT ent,
			Connection conn) {
		ArrayList<LocationTypeENT> res = new ArrayList<LocationTypeENT>();
		if (ent.getLocationTypeId() >= 3)
			return null;
		try {
			boolean isnew = false;
			if (conn == null) {
				conn = getConnection();
				isnew = true;
			}
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
						rs.getString("location_type"), new LocationTypeENT(
								rs.getInt("parent_id")), null);
				ent.setChildren(getLocationTypeTree(ent, conn));
				res.add(ent);
			}
			ps.close();
			if (isnew)
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
				PathENT p = new PathENT(getLocationENT(
						new LocationENT(rs.getLong("departure_location_id")),
						conn), getLocationENT(
						new LocationENT(rs.getLong("destination_location_id")),
						conn), rs.getDouble("distance"), new PathTypeENT(
						rs.getInt("path_type")), rs.getLong("path_id"));
				p.setPathRoute(rs.getString("path_route"));
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

	public LocationENT findClosestLocation(String GPSCoordinates,
			String locationTypeIds, String parentIds, String clientName) {
		LocationDAO dao = new LocationDAO();
		LocationENT ent = new LocationENT();
		ent.setGps(GPSCoordinates);
		ent = getLocationENT(ent, null);
		if (ent.getLocationID() > 0)
			return ent;
		ArrayList<LocationENT> points = dao.getAllLocationsForUser(clientName,
				locationTypeIds, parentIds);
		int closest = -1;
		double[] distances = new double[points.size()];
		for (int i = 0; i < points.size(); i++) {
			distances[i] = PathDAO.calculateDistanceBetweenTwoPoints(points
					.get(i).getGps(), GPSCoordinates);
			if (closest == -1 || distances[i] < distances[closest]) {
				closest = i;
			}
		}
		return points.get(closest);
	}

	public static UndirectedGraph<Long, DefaultWeightedEdge> createGraph(
			int pathTypeId, String clientName) {
		SimpleWeightedGraph<Long, DefaultWeightedEdge> g = null;
		g = new SimpleWeightedGraph<Long, DefaultWeightedEdge>(
				DefaultWeightedEdge.class);
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> points = dao.getAllLocationsForUser(clientName,
				"11,3,5", null);
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
				res = new PathENT(getLocationENT(
						new LocationENT(rs.getLong("departure_location_id")),
						conn), getLocationENT(
						new LocationENT(rs.getLong("destination_location_id")),
						conn));
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
			query = "select l.location_name, l.location_id, l.parent_id, lt.location_type as locaTypeName, l.gps, l.icon from location l "
					+ " left join location_type lt on lt.location_type_id = l.location_type"
					+ " where l.location_id = " + locationId;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				String locationType = rs.getString("locaTypeName");
				locationType = measureLocationType(locationType);
				qrent = new LocationLightENT(rs.getLong("location_id"),
						locationType, rs.getString("location_name"),
						rs.getString("gps"), null);
				qrent.setI(rs.getString("icon"));
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
			qrent.setI(QRBarcodeGen.createQrCode(locationId + "", 666, "png"));
			json = mapper.writeValueAsString(qrent);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}

	private String measureLocationType(String locationType) {
		String res = "";
		if (locationType.equalsIgnoreCase("Area"))
			res = "Campus";
		if (locationType.equalsIgnoreCase("Building"))
			res = "Building";
		if (locationType.equalsIgnoreCase("Client"))
			res = "University";
		return res;
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
				String locationType = rs.getString("locaTypeName");
				locationType = measureLocationType(locationType);
				ent = new LocationLightENT(rs.getLong("location_id"),
						locationType, rs.getString("location_name"), "", null);
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

	public LocationENT getLocationENTAncestors(long locationId) {
		LocationENT res = new LocationENT();
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
			rs.close();
			ps.close();
			conn.close();
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			query = "select l.*, lt.location_type as ltype from location l "
					+ " left join location_type lt on lt.location_type_id = l.location_type"
					+ " where l.location_id = " + locationId;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				long tmpPID = rs.getLong("parent_id");
				res = new LocationENT(rs.getInt("location_id"),
						rs.getString("client_name"), new LocationTypeENT(
								rs.getInt("location_type"),
								rs.getString("ltype")), rs.getString("gps"),
						rs.getString("location_name"));
				if (tmpPID > 0) {
					LocationENT tmp = getLocationENTTree(res,
							rs.getLong("parent_id"), concatParents);
					res.setParent(tmp);
				}

			}
			rs.close();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	private LocationENT getLocationENTTree(LocationENT ent, long parentId,
			String[] concatParents) {
		if (parentId <= 0) {
			ent.setParent(null);
			return ent;
		}
		try {
			Connection conn = null;
			conn = getConnection();
			String query = "";
			query = "select l.*, lt.location_type as ltype from location l "
					+ " left join location_type lt on lt.location_type_id = l.location_type"
					+ " where l.location_id = " + parentId;
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				long tmpPID = rs.getLong("parent_id");
				ent = new LocationENT(rs.getInt("location_id"),
						rs.getString("client_name"), new LocationTypeENT(
								rs.getInt("location_type"),
								rs.getString("ltype")), rs.getString("gps"),
						rs.getString("location_name"));
				if (tmpPID > 0)
					ent.setParent(getLocationENTTree(ent, tmpPID, Arrays
							.copyOfRange(concatParents, 0,
									concatParents.length - 1)));
				else {
					rs.close();
					ps.close();
					conn.close();
					return ent;
				}
			}
			rs.close();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return ent;
	}

	public LevelENT saveLevel(LevelENT level, Connection conn) {
		try {
			boolean isnew = false;
			if (conn == null)
				try {
					conn = getConnection();
					isnew = true;
				} catch (AMSException e) {
					e.printStackTrace();
				}
			String query = "";
			query = "insert into location_level (description, parent_location_id, plan_id)"
					+ " values (?, ?, ?)";
			if (level.getLevelId() > 0)
				query = "update location_level set parent_location_id= ?, plan_id = ?, description = ? where location_level_id = ?";
			PreparedStatement ps = conn.prepareStatement(query,
					Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, level.getDescription());
			ps.setLong(2, level.getParent_id());
			ps.setLong(3, level.getPlanId());
			if (level.getLevelId() > 0)
				ps.setLong(4, level.getLevelId());
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				level.setLevelId(rs.getLong("location_level_id"));
			}
			rs.close();
			ps.close();
			if (isnew)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return level;
	}

	public boolean deleteLevel(LevelENT level, Connection conn)
			throws AMSException {
		try {
			boolean isnew = false;
			if (conn == null)
				try {
					conn = getConnection();
					isnew = true;
				} catch (AMSException e) {
					e.printStackTrace();
				}
			String query = "delete from location_level where location_level_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setLong(1, level.getLevelId());
			ps.execute();
			ps.close();
			if (isnew)
				conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw getAMSException("", e);
		}
	}

	public ArrayList<LevelENT> getLevelsForALocation(LocationENT parent,
			Connection conn) {
		ArrayList<LevelENT> res = new ArrayList<LevelENT>();
		boolean isnew = false;
		if (conn == null)
			try {
				conn = getConnection();
				isnew = true;
			} catch (AMSException e) {
				e.printStackTrace();
			}
		try {
			String query = "select * from location_level where parent_location_id = "
					+ parent.getLocationID();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				res.add(new LevelENT(rs.getLong("location_level_Id"), rs
						.getLong("parent_location_id"), rs
						.getString("description"), rs.getLong("plan_id")));
			}
			rs.close();
			ps.close();
			if (isnew)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public ArrayList<EntranceIntersectionENT> getEntrancesForALocation(LocationENT parent,
			Connection conn) {
		ArrayList<EntranceIntersectionENT> res = new ArrayList<EntranceIntersectionENT>();
		boolean isnew = false;
		if (conn == null)
			try {
				conn = getConnection();
				isnew = true;
			} catch (AMSException e) {
				e.printStackTrace();
			}
		try {
			String query = "select * from location_entrance where parent_id = "
					+ parent.getLocationID();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				res.add(new EntranceIntersectionENT(rs.getLong("entrance_id"), rs
						.getLong("parent_id"), rs
						.getString("description"), rs.getString("gps"), rs.getBoolean("intersection_entrance")));
			}
			rs.close();
			ps.close();
			if (isnew)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public boolean deleteEntrance(EntranceIntersectionENT entrance, Connection conn)
			throws AMSException {
		try {
			boolean isnew = false;
			if (conn == null)
				try {
					conn = getConnection();
					isnew = true;
				} catch (AMSException e) {
					e.printStackTrace();
				}
			String query = "delete from location_entrance where entrance_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setLong(1, entrance.getEntranceId());
			ps.execute();
			ps.close();
			if (isnew)
				conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw getAMSException("", e);
		}
	}

	public EntranceIntersectionENT saveEntrance(EntranceIntersectionENT entrance, Connection conn) {
		try {
			boolean isnew = false;
			if (conn == null)
				try {
					conn = getConnection();
					isnew = true;
				} catch (AMSException e) {
					e.printStackTrace();
				}
			String query = "";
			query = "insert into location_entrance (description, parent_id, gps, intersection_entrance, entrance_id)"
					+ " values (?, ?, ?, ?, ?)";
			if (entrance.getEntranceId() > 0)
				query = "update location_entrance set parent_id= ?, gps = ?, description = ?, intersection_entrance = ? where entrance_id = ?";
			PreparedStatement ps = conn.prepareStatement(query,
					Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, entrance.getDescription());
			ps.setLong(2, entrance.getParent_id());
			ps.setString(3, entrance.getGps());
			if (entrance.isEntranceIntersection()) {
				ps.setInt(4, 1);
			} else
				ps.setInt(4, 0);
			if (entrance.getEntranceId() > 0)
				ps.setLong(5, entrance.getEntranceId());
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next() && entrance.getEntranceId() > 0) {
				entrance.setEntranceId(rs.getLong("entrance_id"));
			}
			rs.close();
			ps.close();
			if (isnew)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return entrance;
	}
}
