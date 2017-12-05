package hibernate.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;

import com.mysql.jdbc.Statement;

import common.security.GroupENT;
import common.security.GroupLST;
import common.security.RoleENT;
import common.security.RoleLST;
import common.user.UserENT;
import common.user.UserPassword;
import hibernate.config.BaseHibernateDAO;
import tools.AMSException;
import tools.AMSUtililies;

public class SecurityDAO extends BaseHibernateDAO implements
		SecurityDAOInterface {

	public static void main(String[] args) {
		SecurityDAO udao = new SecurityDAO();
		// try {
		//
//		for (int i = 0; i < 30; i++) {
//			RoleENT roles = new RoleENT();
//			roles.setComment("commeneeet" + i);
//			roles.setRoleName("roleeddde" + i);
//			roles.setClientID(1);
//			try {
//				udao.saveUpdateRole(roles);
//			} catch (AMSException e) {
//				e.printStackTrace();
//			}
//		}
	}

	public RoleENT saveUpdateRole(RoleENT role, Connection conn) throws AMSException {
		boolean isnew = false;
		if (conn == null)
			try {
				conn = getConnection();
				isnew = true;
			} catch (AMSException e) {
				e.printStackTrace();
			}
		String query = "";
		query = "INSERT INTO roles (role_name, comment, client_id, category_role) " +
				"VALUES(?, ?, ?, ?) ON DUPLICATE KEY UPDATE  comment = ?, client_id = ?, category_role = ? ";
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(query);
			ps.setString(1, role.getRoleName());
			ps.setString(2, role.getComment());
			ps.setInt(3, role.getClientID());
			ps.setString(4, role.getRoleCategory());
			ps.setString(5, role.getComment());
			ps.setInt(6, role.getClientID());
			ps.setString(7, role.getRoleCategory());
			ps.executeUpdate();
			ps.close();
			if (isnew)
				conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return role;
	}

	private boolean deleteRole(RoleENT role) throws AMSException {
		// try {
		// Connection conn = null;
		// try {
		// conn = getConnection();
		// } catch (AMSException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// String query = "delete from roles where role_name = ?";
		// PreparedStatement ps = conn.prepareStatement(query);
		// ps.setString(1, role.getRoleName());
		// ps.execute();
		// ps.close();
		// conn.close();
		return true;
		// } catch (SQLException e) {
		// e.printStackTrace();
		// throw getAMSException("", e);
		// }
	}

	public RoleENT getRole(RoleENT role) throws AMSException {
//		int clientid = role.getSearchRole().getClientID();
//		try {
//			Connection conn = null;
//			try {
//				conn = getConnection();
//			} catch (AMSException e) {
//				e.printStackTrace();
//			}
//			String searchKey = roleLST.getSearchRole().getRoleName();
//			String query = "Select r.*, c.client_name from roles r "
//					+ "left join clients c on r.client_id = c.client_id where ";
//			if (clientid > 0)
//				query += " clientID = " + clientid + " and ";
//			query += "r.role_name like ? or r.category_role like ? ";
//			query += " order by " + roleLST.getSortedByField();
//			if (roleLST.isAscending())
//				query += ", role_name Asc";
//			else
//				query += " Desc";
//			query += " LIMIT ?, ? ";
//			PreparedStatement ps = conn.prepareStatement(query);
//			ps.setString(1, "%" + searchKey + "%");
//			ps.setString(2, "%" + searchKey + "%");
//			ps.setInt(3, roleLST.getFirst());
//			ps.setInt(4, roleLST.getPageSize());
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				RoleENT r = new RoleENT(rs.getString("role_name"),
//						rs.getInt("client_id"), rs.getString("client_name"),
//						rs.getString("comment"));
//				r.setRoleCategory(rs.getString("category_role"));
//				res.add(r);
//			}
//			rs.last();
//			roleLST.setTotalItems(rs.getRow());
//			rs.close();
//			roleLST.setRoleENTs(res);
//			ps.close();
//			conn.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
		return role;
	}

	public RoleLST getRolesList(RoleLST roleLST) throws AMSException {
		ArrayList<RoleENT> res = new ArrayList<RoleENT>();
		int clientid = roleLST.getSearchRole().getClientID();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String searchKey = roleLST.getSearchRole().getRoleName();
			String query = "Select r.*, c.client_name from roles r "
					+ "left join clients c on r.client_id = c.client_id where ";
			if (clientid > 0)
				query += " clientID = " + clientid + " and ";
			query += "r.role_name like ? or r.category_role like ? ";
			query += " order by " + roleLST.getSortedByField();
			if (roleLST.isAscending())
				query += ", role_name Asc";
			else
				query += " Desc";
			query += " LIMIT ?, ? ";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + searchKey + "%");
			ps.setString(2, "%" + searchKey + "%");
			ps.setInt(3, roleLST.getFirst());
			ps.setInt(4, roleLST.getPageSize());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				RoleENT r = new RoleENT(rs.getString("role_name"),
						rs.getInt("client_id"), rs.getString("client_name"),
						rs.getString("comment"));
				r.setRoleCategory(rs.getString("category_role"));
				res.add(r);
			}
			rs.last();
			roleLST.setTotalItems(rs.getRow());
			rs.close();
			roleLST.setRoleENTs(res);
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return roleLST;
	}

	public GroupLST getGroupList(GroupLST groupLST) throws AMSException {
		ArrayList<GroupENT> res = new ArrayList<GroupENT>();
		int clientid = groupLST.getSearchGroup().getClientID();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String searchKey = groupLST.getSearchGroup().getGroupName();
			String query = "Select g.*, c.client_name from groups g "
					+ "left join clients c on c.client_id = g.client_id where ";
			if (clientid > 0)
				query += " clientID = " + clientid + " and ";
			query += "g.group_name like ? ";
			query += " order by " + groupLST.getSortedByField();
			if (groupLST.isAscending())
				query += " Asc";
			else
				query += " Desc";
			query += " LIMIT ?, ? ";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + searchKey + "%");
			ps.setInt(2, groupLST.getFirst());
			ps.setInt(3, groupLST.getPageSize());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				GroupENT g = new GroupENT(rs.getInt("group_id"),
						rs.getString("group_name"), rs.getInt("client_id"),
						rs.getString("client_name"), rs.getString("comment"));
				res.add(g);
			}
			rs.last();
			groupLST.setTotalItems(rs.getRow());
			rs.close();
			groupLST.setGroupENTs(res);
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return groupLST;
	}

	public GroupENT saveUpdateGroup(GroupENT group, Connection conn)
			throws AMSException {
		boolean isnew = false;
		if (conn == null)
			try {
				conn = getConnection();
				isnew = true;
			} catch (AMSException e) {
				e.printStackTrace();
			}
		String query = "";
		query = "insert into groups (group_name, comment, client_id)"
				+ " values (?, ?, ?)";
		if (group.getGroupID() > 0)
			query = "update groups set group_name= ?, comment = ?, client_id = ? where group_id = "
					+ group.getGroupID();
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, group.getGroupName());
			ps.setString(2, group.getComment());
			ps.setInt(3, group.getClientID());
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				group.setGroupID(rs.getInt("location_id"));
			}
			rs.close();
			ps.close();
			if (isnew)
				conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return group;
	}

	public GroupENT getGroup(GroupENT group) throws AMSException {
		// Query q = null;
		// try {
		// q = getSession().createQuery("from GroupENT where groupID =:Id ");
		// q.setInteger("Id", group.getGroupID());
		// group = (GroupENT) q.uniqueResult();
		// HibernateSessionFactory.closeSession();
		// } catch (HibernateException ex) {
		// ex.printStackTrace();
		// group = null;
		// }
		return group;
	}

	private boolean deleteGroup(GroupENT group) throws AMSException {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "delete from groups where group_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, group.getGroupID());
			ps.execute();
			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw getAMSException("", e);
		}
	}

	public boolean deleteRoles(ArrayList<RoleENT> roles) throws AMSException {
		for (int i = 0; i < roles.size(); i++) {
			deleteRole(roles.get(i));
		}
		return true;
	}

	public boolean deleteGroups(ArrayList<GroupENT> groups) throws AMSException {
		for (int i = 0; i < groups.size(); i++) {
			deleteGroup(groups.get(i));
		}
		return true;
	}

	public RoleENT validateRole(RoleENT role) throws AMSException {
		// Query q = null;
		// try {
		// q = getSession().createQuery(
		// "from RoleENT where roleName =:name and clientID =:client");
		// q.setString("name", role.getRoleName());
		// q.setInteger("client", role.getClientID());
		// role = (RoleENT) q.uniqueResult();
		// HibernateSessionFactory.closeSession();
		// } catch (HibernateException ex) {
		// ex.printStackTrace();
		// role = null;
		// }
		return role;
	}

	public ArrayList<RoleENT> getAllGroupRoles(int gid) {
		ArrayList<RoleENT> res = new ArrayList<RoleENT>();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String query = "Select gr.*, r.* from group_roles gr"
					+ " inner join groups g on g.group_id = gr.group_id"
					+ " inner join roles r on r.role_name = gr.role_name "
					+ " and gr.group_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, gid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				RoleENT r = new RoleENT(rs.getString("role_name"),
						rs.getInt("client_id"), "", 0,
						rs.getInt("role_group_id"), "");
				res.add(r);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public void saveUpdateRolesGroup(ArrayList<RoleENT> roles, GroupENT group)
			throws AMSException {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				e.printStackTrace();
			}
			String query = "delete from group_roles where group_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, group.getGroupID());
			ps.execute();
			query = "insert into group_roles (group_id, role_name) values (?,?)";
			ps.close();
			for (int i = 0; i < roles.size(); i++) {
				ps = conn.prepareStatement(query);
				ps.setInt(1, group.getGroupID());
				ps.setString(2, roles.get(i).getRoleName());
				ps.execute();
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw getAMSException("", e);
		}

	}

	public ArrayList<RoleENT> getAllRoles(String searchKey) {
		ArrayList<RoleENT> res = new ArrayList<RoleENT>();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "Select * from roles where role_name like ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + searchKey + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				RoleENT r = new RoleENT(rs.getString("role_name"),
						rs.getInt("client_id"), "", 0, 0, "");
				res.add(r);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public ArrayList<GroupENT> getAllGroups(String searchKey) {
		ArrayList<GroupENT> res = new ArrayList<GroupENT>();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "Select * from groups where group_name like ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + searchKey + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				GroupENT r = new GroupENT(rs.getInt("group_id"),
						rs.getString("group_name"), rs.getInt("client_id"), "",
						0, 0, "");
				res.add(r);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public void changePassword(String oldPass, String newPass, String username)
			throws AMSException {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				throw getAMSException("", e);
			}
			String query = "select * from users where username = ? and password = ? ";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, username);
			ps.setString(2, AMSUtililies.encodeMD5(oldPass));
			ResultSet rs = ps.executeQuery();
			if (!rs.next()) {
				throw getAMSException("The old password does not match", null);
			}
			query = "update users set password = ? where username = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, AMSUtililies.encodeMD5(newPass));
			ps.setString(2, username);
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw getAMSException("", e);
		}

	}

	public ArrayList<String> getAllRoleCategories(String filter) {
		ArrayList<String> res = new ArrayList<String>();
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "Select distinct category_role from roles where category_role like '%"
					+ filter + "%'";
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				res.add(rs.getString("category_role"));
			}
			rs.close();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	public RoleENT saveUserRole(RoleENT role) throws AMSException {
		// TODO Auto-generated method stub
		return null;
	}

	public GroupENT saveUserGroup(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean saveGroupRole(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean getUserGroups(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean getGroupRoles(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean changePassword(UserPassword ent) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public UserPassword register(UserPassword userPassword) throws AMSException {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "";
			query = "select * from users where username = "
					+ userPassword.getUserName();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				throw new AMSException("The username already exist");
			query = "insert into users (username, password) values (? ,?)";
			ps = conn.prepareStatement(query);
			ps.execute();
			while (rs.next()) {
				rs.getString("category_role");
			}
			rs.close();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return userPassword;
	}

	public GroupENT saveUpdateGroup(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return null;
	}

}
