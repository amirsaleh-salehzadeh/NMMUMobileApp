package hibernate.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.mapping.List;

import common.security.GroupENT;
import common.security.GroupLST;
import common.security.RoleENT;
import common.security.RoleLST;
import hibernate.config.BaseHibernateDAO;
import hibernate.config.HibernateSessionFactory;
import tools.AMSException;

public class SecurityDAO extends BaseHibernateDAO implements
		SecurityDAOInterface {

	public static void main(String[] args) {
		SecurityDAO udao = new SecurityDAO();
//		try {
//
			for (int i = 0; i < 30; i++) {
				RoleENT roles = new RoleENT();
				roles.setComment("commeneeet" + i);
				roles.setRoleName("roleeddde" + i);
				roles.setClientID(1);
				try {
					udao.saveUpdateRole(roles);
				} catch (AMSException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
//				System.out.println("hei");
			}
//			RoleLST role = udao.getRolesList(new RoleLST());
//			RoleENT role = new RoleENT();
//			role.setRoleName("role100");
//			role.setClientID(2);
//			RoleENT r = udao.getRole(role);
//			GroupLST g = new GroupLST();
//			GroupENT gs = new GroupENT();
//			gs.setGroupName("");
//			g.setSearchGroup(gs);
//			g = udao.getGroupList(g);
			System.out.println("done");
//		} catch (AMSException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
	}

	public RoleENT saveUpdateRole(RoleENT role) throws AMSException {
		Session session = getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			if (role.getRoleID() <= 0) {
				if (validateRole(role) == null)
					session.save(role);
				else
					throw getAMSException("The role already Exist", null);
			} else
				session.saveOrUpdate(role);
			tx.commit();
			session.flush();
			session.clear();
			session.close();
		} catch (HibernateException ex) {
			tx.rollback();
			session.clear();
			session.close();
			ex.printStackTrace();
			throw getAMSException("", ex);
		}
		return role;
	}
	
	

	private boolean deleteRole(RoleENT role) throws AMSException {
		try {
			Connection conn = null;
			try {
				conn = getConnection();
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "delete from roles where role_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, role.getRoleID());
			ps.execute();
			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw getAMSException("", e);
		}
	}

	public RoleENT getRole(RoleENT role) throws AMSException {
		Query q = null;
		try {
			Session session = getSession();
			q = session.createQuery(
					"from RoleENT where roleID =:Id");
			q.setInteger("Id", role.getRoleID());
			role = (RoleENT) q.uniqueResult();
			session.close();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
			role = null;
		}
		return role;
	}

	public RoleLST getRolesList(RoleLST roleLST) throws AMSException {
		Query q = null;
		int clientid = roleLST.getSearchRole().getClientID();
		try {
			String query = "from RoleENT where roleName like :roleName ";
			if (clientid > 0)
				query += "and clientID = " + clientid;
			query += " order by " + roleLST.getSortedByField();
			if (roleLST.isAscending())
				query += " Asc";
			else
				query += " Desc";
			q = getSession().createQuery(query);
			q.setParameter("roleName", "%"
					+ roleLST.getSearchRole().getRoleName() + "%");
			roleLST.setTotalItems(q.list().size());
			q.setFirstResult(roleLST.getFirst());
			q.setMaxResults(roleLST.getPageSize());
			ArrayList<RoleENT> result = (ArrayList<RoleENT>) q.list();
			roleLST.setRoleENTs(result);
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return roleLST;
	}

	public GroupLST getGroupList(GroupLST groupLST) throws AMSException {
		ArrayList<GroupENT> groupENTs = new ArrayList<GroupENT>();
		Query q = null;
		int clientid = groupLST.getSearchGroup().getClientID();
		try {
			String query = "from GroupENT where groupName like :groupName ";
			if (clientid > 0)
				query += "and clientID = " + clientid;
			query += " order by " + groupLST.getSortedByField();
			if (groupLST.isAscending())
				query += " Asc";
			else
				query += " Desc";

			q = getSession().createQuery(query);
			q.setParameter("groupName", "%"
					+ groupLST.getSearchGroup().getGroupName() + "%");
			groupLST.setTotalItems(q.list().size());
			q.setFirstResult(groupLST.getFirst());
			q.setMaxResults(groupLST.getPageSize());
			groupENTs = (ArrayList<GroupENT>) q.list();
			groupLST.setGroupENTs(groupENTs);
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return groupLST;
	}

	public GroupENT saveUpdateGroup(GroupENT group) throws AMSException {
		Session session = getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			if (group.getGroupID() <= 0) {
				if (getGroup(group) == null)
					session.save(group);
				else
					throw getAMSException("The group already Exist", null);
			} else
				session.saveOrUpdate(group);
			tx.commit();
			session.flush();
			session.clear();
			session.close();
		} catch (HibernateException ex) {
			tx.rollback();
			session.clear();
			session.close();
			ex.printStackTrace();
			throw getAMSException("", ex);
		}
		return group;
	}

	public GroupENT getGroup(GroupENT group) throws AMSException {
		Query q = null;
		try {
			q = getSession().createQuery(
					"from GroupENT where groupID =:Id ");
			q.setInteger("Id", group.getGroupID());
			group = (GroupENT) q.uniqueResult();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
			group = null;
		}
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
		Query q = null;
		try {
			q = getSession().createQuery(
					"from RoleENT where roleName =:name and clientID =:client");
			q.setString("name", role.getRoleName());
			q.setInteger("client", role.getClientID());
			role = (RoleENT) q.uniqueResult();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
			role = null;
		}
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
					+ " inner join roles r on r.role_id = gr.role_id "
					+ " and gr.group_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, gid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				RoleENT r = new RoleENT(rs.getInt("role_id"),
						rs.getString("role_name"), rs.getInt("client_id"), "",
						0, rs.getInt("role_group_id"), "");
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
			String query = "delete from group_roles " + "where group_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, group.getGroupID());
			ps.execute();
			query = "insert into group_roles (group_id, role_id) values (?,?)";
			for (int i = 0; i < roles.size(); i++) {
				ps = conn.prepareStatement(query);
				ps.setInt(1, group.getGroupID());
				ps.setInt(2, roles.get(i).getRoleID());
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
			ps.setString(1, "%"+searchKey+"%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				RoleENT r = new RoleENT(rs.getInt("role_id"),
						rs.getString("role_name"), rs.getInt("client_id"), "",
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

}
