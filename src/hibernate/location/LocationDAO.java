package hibernate.location;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import common.DropDownENT;
import common.client.ClientENT;
import common.location.CountryENT;
import common.location.LocationENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import common.security.RoleENT;
import hibernate.config.BaseHibernateDAO;
import hibernate.config.HibernateSessionFactory;
import tools.AMSException;
import tools.algorithms.Dijkstra;
import tools.algorithms.pathFinding.Edge;
import tools.algorithms.pathFinding.Vertex;

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
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, ent.getCountry());
			ps.setString(2, ent.getAddress());
			ps.setString(3, ent.getPostBox());
			ps.setString(4, ent.getGps());
			ps.setString(5, ent.getLocationName());
			ps.setString(6, ent.getUserName());
			ps.setInt(7, ent.getLocationType().getLocationTypeId());
			if (ent.getLocationID() > 0)
				ps.setLong(8, ent.getLocationID());
			ps.execute();
			ps.close();
			conn.close();
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
			query = "select * from location where location_id = "
					+ ent.getLocationID();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ent = new LocationENT(rs.getInt("location_id"),
						rs.getString("username"), new LocationTypeENT(
								rs.getInt("location_id"),
								rs.getString("location_type")),
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
		Session session = getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.delete(ent);
			tx.commit();
			session.flush();
			session.clear();
			session.close();
			return true;
		} catch (HibernateException ex) {
			tx.rollback();
			session.clear();
			session.close();
			ex.printStackTrace();
			throw getAMSException("", ex);
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
			query = "select l.* from location l "
					+ " left join location_type lt on lt.location_type_id = l.location_type"
					+ " where username = '" + username + "'";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				locationENTs.add(new LocationENT(rs.getInt("location_id"), rs
						.getString("username"), new LocationTypeENT(rs
						.getInt("location_id"), rs.getString("location_type")),
						rs.getString("address"), rs.getString("gps"), rs
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

	private ArrayList<PathENT> getAllPathsForOnePoint(long locationId) {
		ArrayList<PathENT> res = new ArrayList<PathENT>();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "Select * from paths "
					+ "where destination_location_id = '" + locationId
					+ "' or departure_location_id = '" + locationId + "'";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				PathENT p = new PathENT(getLocationENT(new LocationENT(
						rs.getLong("departure_location_id"))),
						getLocationENT(new LocationENT(rs
								.getLong("destination_location_id"))),
						rs.getDouble("distance"), new PathTypeENT(
								rs.getInt("path_type")),
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
			ps.setDouble(
					3,
					calculateDistance(path.getDestination().getGps(), path
							.getDeparture().getGps()));
			ps.setInt(4, path.getPathType().getPathTypeId());
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private double calculateDistance(String gps, String gps2) {
		final int R = 6371;
		double latDistance = Math
				.toRadians(Double.parseDouble(gps2.split(",")[0])
						- Double.parseDouble(gps.split(",")[0]));
		double lonDistance = Math
				.toRadians(Double.parseDouble(gps2.split(",")[1].replaceAll(
						" ", ""))
						- Double.parseDouble(gps.split(",")[1].replaceAll(" ",
								"")));
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

	public HashMap<Long, Vertex> getShortestPath(long dep, long dest) {
		ArrayList<LocationENT> points = getAllLocationsForUser("admin");
		HashMap<Long, Vertex> map = new HashMap<Long, Vertex>();
		for (int i = 0; i < points.size(); i++) {
			map.put(points.get(i).getLocationID(), new Vertex(points.get(i)
					.getLocationID()));
		}
		for (HashMap.Entry<Long, Vertex> entry : map.entrySet()) {
			Vertex v = entry.getValue();
			ArrayList<PathENT> ptz = getAllPathsForOnePoint(entry.getKey());
			Edge[] edgz = new Edge[ptz.size()];
			for (int i = 0; i < ptz.size(); i++) {
				PathENT tmpPath = ptz.get(i);
				edgz[i] = new Edge(map.get(tmpPath.getDestination()
						.getLocationID()), tmpPath.getDistance());
			}
			v.adjacencies = edgz;
			System.out.println(entry.getKey());
			map.put(entry.getKey(), v);
		}
		return map;
	}

	// public HashMap<String, Vertex> getShortestPathTMP(LocationENT dep,
	// LocationENT dest) {
	// ArrayList<PathENT> res = getAllPaths("admin");
	// HashMap<String, Vertex> map = new HashMap<String, Vertex>();
	// for (int i = 0; i < res.size(); i++) {
	// PathENT p = res.get(i);
	// Vertex v1 = new Vertex(p.getDeparture().getLocationID() + "");
	// Vertex v2 = new Vertex(p.getDestination().getLocationID() + "");
	// Edge[] e1 = v1.adjacencies;
	// Edge[] e2 = v2.adjacencies;
	// if (e1 != null) {
	// Edge[] tmp = new Edge[e1.length + 1];
	// System.arraycopy(e1, 0, tmp, 0, e1.length);
	// tmp[tmp.length - 1] = new Edge(v2, p.getDistance());
	// v1.adjacencies = tmp;
	// } else {
	// v1.adjacencies = new Edge[] { new Edge(v2, p.getDistance()) };
	// }
	// if (e2 != null) {
	// Edge[] tmp = new Edge[e2.length + 1];
	// System.arraycopy(e2, 0, tmp, 0, e2.length);
	// tmp[tmp.length - 1] = new Edge(v1, p.getDistance());
	// v2.adjacencies = tmp;
	// } else {
	// v2.adjacencies = new Edge[] { new Edge(v1, p.getDistance()) };
	// }
	// if (!map.containsKey(v1.toString())) {
	// map.put(v1.toString(), v1);
	// } else
	// v1 = map.get(v1.toString());
	// if (!map.containsKey(v2.toString())) {
	// map.put(v2.toString(), v2);
	// } else
	// v2 = map.get(v2.toString());
	// map.put(v1.toString(), v1);
	// map.put(v2.toString(), v2);
	// }
	// return map;
	// }
	public static void main(String[] args) {
		LocationDAO dao = new LocationDAO();
		HashMap<Long, Vertex> tmp = dao.getShortestPath(0, 0);
		Dijkstra.computePaths(tmp.get(39));
		System.out.println(Dijkstra.getShortestPathTo(tmp.get(52)));
	}
}
