package hibernate.route;

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
import graph.management.GraphGenerator;
import hibernate.config.BaseHibernateDAO;
import hibernate.location.LocationDAO;
import tools.AMSException;
import tools.QRBarcodeGen;

public class RouteDAO extends BaseHibernateDAO implements RouteDAOInterface {

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
			String query = "Select p.*, pt.* from paths p "
					+ "inner join location lf on lf.location_id = p.destination_location_id "
					+ " left join path_type pt on pt.path_type_id = p.path_type"
					+ " where lf.client_name = '" + username
					+ "' and lf.parent_id = " + parentId;
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			LocationDAO ldao = new LocationDAO();
			while (rs.next()) {
				PathENT p = new PathENT(ldao.getLocationENT(
						new LocationENT(rs.getLong("departure_location_id")),
						conn), ldao.getLocationENT(
						new LocationENT(rs.getLong("destination_location_id")),
						conn), rs.getDouble("distance"),
						new PathTypeENT(rs.getInt("path_type_id"), rs
								.getString("pt.path_type")),
						rs.getLong("path_id"));
				p.setPathRoute(rs.getString("path_route"));
				res.add(p);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

}