//package hibernate.user;
//
//import java.lang.reflect.Field;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.List;
//
//import org.hibernate.HibernateException;
//import org.hibernate.Query;
//import org.hibernate.Session;
//import org.hibernate.Transaction;
//
//import common.DropDownENT;
//import common.client.ClientENT;
//import common.security.GroupENT;
//import common.security.RoleENT;
//import common.user.EthnicENT;
//import common.user.TitleENT;
//import common.user.UserENT;
//import common.user.UserLST;
//import common.user.UserPassword;
//import hibernate.config.BaseHibernateDAO;
//import hibernate.config.HibernateSessionFactory;
//import tools.AMSException;
//import tools.AMSUtililies;
//
//public class UserDAO extends BaseHibernateDAO implements UserDAOInterface {
//	public static void main(String[] args) {
//		UserDAO udao = new UserDAO();
//		// try {
//		// for (int i = 14; i < 20; i++) {
//		// TitleENT roles = new TitleENT();
//		// roles = udao.getTitle(2);
//		// EthnicENT eth = new EthnicENT();
//		// eth = udao.getEthnic(2);
//		// UserENT ent = new UserENT();
//		// ent.setActive(true);
//		// ent.setClientID(1);
//		// ent.setDateOfBirth("dob");
//		// ent.setGender(true);
//		// ent.setEthnic(eth);
//		// ent.setRegisterationDate("today");
//		// ent.setSurName("surnamezzz");
//		// ent.setName("namezzzz"+i);
//		// ent.setTitle(roles);
//		// ent.setUserName("userNamezzzz4");
//		// UserPassword up = new UserPassword();
//		// up.setUserPassword("passsssss"+i);
//		// ent.setPassword("pass"+i);
//		// ent = udao.saveUpdateUser(ent);
//
//		UserLST l = new UserLST();
//		UserENT us = new UserENT();
//		ArrayList<RoleENT> ad = new ArrayList<RoleENT>();
//		UserENT u = new UserENT();
//		u.setRoleENTs(ad);
//		try {
//			udao.saveUpdateUserRoles(u);
//		} catch (AMSException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		System.out.println(us.toString());
//		// l.setSearchUser(us);
//		// udao.deleteUser(us);
//
//		System.out.println("done");
//		// }
//		// } catch (AMSException e) {
//		// // TODO Auto-generated catch block
//		// e.printStackTrace();
//		// }
//	}
//
//	public UserENT saveUpdateUser(UserENT ent) throws AMSException {
//		Session session = getSession();
//		Transaction tx = null;
//		try {
//			tx = session.beginTransaction();
//			ent.setPassword(AMSUtililies.encodeMD5(ent.getPassword()));
//			if (ent.getUserName() != null && !ent.getUserName().equalsIgnoreCase("")) {
//				if (getUserENT(ent) == null)
//					session.save(ent);
//				else
//					throw getAMSException("The username already Exist", null);
//			} else
//				session.saveOrUpdate(ent);
//			tx.commit();
//			session.flush();
//			session.clear();
//			session.close();
//		} catch (HibernateException ex) {
//			tx.rollback();
//			session.clear();
//			session.close();
//			ex.printStackTrace();
//			throw getAMSException("", ex);
//		}
//		return ent;
//	}
//
//	public UserLST getUserLST(UserLST lst) throws AMSException {
//		ArrayList<UserENT> userENTs = new ArrayList<UserENT>();
//		Query q = null;
//		int clientid = lst.getSearchUser().getClientID();
//		try {
//			String query = "from UserENT where username like :uname ";
//			if (clientid > 0)
//				query += "and clientID = " + clientid;
//			query += " order by " + lst.getSortedByField();
//			if (lst.isAscending())
//				query += " Asc";
//			else
//				query += " Desc";
//
//			q = getSession().createQuery(query);
//			q.setParameter("uname", "%" + lst.getSearchUser().getUserName()
//					+ "%");
//			lst.setTotalItems(q.list().size());
//			q.setFirstResult(lst.getFirst());
//			q.setMaxResults(lst.getPageSize());
//			userENTs = (ArrayList<UserENT>) q.list();
//			lst.setUserENTs(userENTs);
//			HibernateSessionFactory.closeSession();
//		} catch (HibernateException ex) {
//			ex.printStackTrace();
//		}
//		return lst;
//	}
//
//	public boolean deleteUser(UserENT user) throws AMSException {
//		try {
//			Connection conn = null;
//			try {
//				conn = getConnection();
//			} catch (AMSException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			String query = "delete from users where username = ?";
//			PreparedStatement ps = conn.prepareStatement(query);
//			ps.setString(1, user.getUserName());
//			ps.execute();
//			ps.close();
//			conn.close();
//			return true;
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw getAMSException("", e);
//		}
//	}
//
//	public ArrayList<EthnicENT> getAllEthnics() throws AMSException {
//		ArrayList<EthnicENT> list = new ArrayList<EthnicENT>();
//		Query q = null;
//		try {
//			q = getSession().createQuery("from EthnicENT");
//			list = (ArrayList<EthnicENT>) q.list();
//			HibernateSessionFactory.closeSession();
//		} catch (HibernateException ex) {
//			throw getAMSException("", ex);
//		}
//		return list;
//	}
//
//	public ArrayList<TitleENT> getAllTitles() throws AMSException {
//		ArrayList<TitleENT> list = new ArrayList<TitleENT>();
//		Query q = null;
//		try {
//			q = getSession().createQuery("from TitleENT");
//			list = (ArrayList<TitleENT>) q.list();
//			HibernateSessionFactory.closeSession();
//		} catch (HibernateException ex) {
//			ex.printStackTrace();
//			throw getAMSException("", ex);
//		}
//		return list;
//	}
//
//	public EthnicENT getEthnic(int ethnicID) throws AMSException {
//		Query q = null;
//		EthnicENT ethnic = new EthnicENT();
//		try {
//			q = getSession().createQuery("from EthnicENT where ethnicID =:Id");
//			q.setInteger("Id", ethnicID);
//			ethnic = (EthnicENT) q.uniqueResult();
//			HibernateSessionFactory.closeSession();
//		} catch (HibernateException ex) {
//			ex.printStackTrace();
//			throw getAMSException("", ex);
//		}
//		return ethnic;
//	}
//
//	public TitleENT getTitle(int titleID) throws AMSException {
//		Query q = null;
//		TitleENT title = new TitleENT();
//		try {
//			q = getSession().createQuery("from TitleENT where titleID =:Id");
//			q.setInteger("Id", titleID);
//			title = (TitleENT) q.uniqueResult();
//			HibernateSessionFactory.closeSession();
//		} catch (HibernateException ex) {
//			ex.printStackTrace();
//			throw getAMSException("", ex);
//		}
//		return title;
//	}
//
//	public UserENT getUserENT(UserENT user) throws AMSException {
//		Query q = null;
//		try {
//			q = getSession().createQuery(
//					"from UserENT where username =:uname");
//			q.setString("uname", user.getUserName());
//			user = (UserENT) q.uniqueResult();
//			HibernateSessionFactory.closeSession();
//		} catch (HibernateException ex) {
//			ex.printStackTrace();
//			throw getAMSException("", ex);
//		}
//		return user;
//	}
//
//	public ArrayList<DropDownENT> getTitlesDropDown() {
//		Query q = null;
//		ArrayList<DropDownENT> res = new ArrayList<DropDownENT>();
//		try {
//			Session s = getSession4Query();
//			s.beginTransaction();
//			List<TitleENT> dropdowns = getSession4Query().createQuery(
//					"from TitleENT").list();
//			for (TitleENT dropdown : dropdowns) {
//				res.add(new DropDownENT(dropdown.getTitleID() + "", dropdown
//						.getTitle(), null));
//			}
//			// List dropDown = q.list();
//		} catch (HibernateException ex) {
//			ex.printStackTrace();
//		}
//		return res;
//	}
//
//	public ArrayList<DropDownENT> getEthnicsDropDown() {
//		Query q = null;
//		ArrayList<DropDownENT> res = new ArrayList<DropDownENT>();
//		try {
//			Session s = getSession4Query();
//			s.beginTransaction();
//			List<EthnicENT> dropdowns = getSession4Query().createQuery(
//					"from EthnicENT").list();
//			for (EthnicENT dropdown : dropdowns) {
//				res.add(new DropDownENT(dropdown.getEthnicID() + "", dropdown
//						.getEthnic(), null));
//			}
//			// List dropDown = q.list();
//		} catch (HibernateException ex) {
//			ex.printStackTrace();
//		}
//		return res;
//	}
//
//	public ArrayList<RoleENT> getAllRolesUser(String username) {
//		ArrayList<RoleENT> res = new ArrayList<RoleENT>();
//		try {
//			Connection conn = null;
//			try {
//				conn = getConnection();
//			} catch (AMSException e) {
//				e.printStackTrace();
//			}
//			String query = "Select ur.*, r.* from user_roles ur"
//					+ " inner join users u on u.username = ur.username"
//					+ " inner join roles r on r.role_name = ur.role_name "
//					+ " and ur.username = ?";
//			PreparedStatement ps = conn.prepareStatement(query);
//			ps.setString(1, username);
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				RoleENT r = new RoleENT(
//						rs.getString("role_name"), rs.getInt("client_id"), "",
//						rs.getInt("user_role_id"), 0, "");
//				res.add(r);
//			}
//			ps.close();
//			conn.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return res;
//	}
//
//	public ArrayList<GroupENT> getAllGroupsUser(String username) {
//		ArrayList<GroupENT> res = new ArrayList<GroupENT>();
//		try {
//			Connection conn = null;
//			try {
//				conn = getConnection();
//			} catch (AMSException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//
//			String query = "Select ug.*, g.* from user_groups ug"
//					+ " inner join groups g on g.group_id = ug.group_id"
//					+ " inner join users u on u.username = ug.username "
//					+ " and u.username = ?";
//			PreparedStatement ps = conn.prepareStatement(query);
//			ps.setString(1, username);
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				GroupENT r = new GroupENT(rs.getInt("group_id"),
//						rs.getString("group_name"), rs.getInt("client_id"), "",
//						0, rs.getInt("user_group_id"), "");
//				res.add(r);
//			}
//			ps.close();
//			conn.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return res;
//	}
//
//	public void saveUpdateUserRoles(UserENT user) throws AMSException {
//		try {
//			Connection conn = null;
//			try {
//				conn = getConnection();
//			} catch (AMSException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			String query = "delete from user_roles where username = ?";
//			PreparedStatement ps = conn.prepareStatement(query);
//			ps.setString(1, user.getUserName());
//			ps.execute();
//			query = "insert into user_roles (role_name, username) values (?,?)";
//			for (int i = 0; i < user.getRoleENTs().size(); i++) {
//				ps = conn.prepareStatement(query);
//				ps.setString(2, user.getUserName());
//				ps.setString(1, user.getRoleENTs().get(i).getRoleName());
//				ps.execute();
//			}
//			ps.close();
//			conn.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw getAMSException("", e);
//		}
//	}
//
//	public boolean deleteUsers(ArrayList<UserENT> users) throws AMSException {
//		for (int i = 0; i < users.size(); i++) {
//			deleteUser(users.get(i));
//		}
//		return true;
//	}
//
//	public void saveUpdateUserGroups(UserENT user) throws AMSException {
//		try {
//			Connection conn = null;
//			try {
//				conn = getConnection();
//			} catch (AMSException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			String query = "delete from user_groups where username = ?";
//			PreparedStatement ps = conn.prepareStatement(query);
//			ps.setString(1, user.getUserName());
//			ps.execute();
//			query = "insert into user_groups (group_id, username) values (?,?)";
//			for (int i = 0; i < user.getGroupENTs().size(); i++) {
//				ps = conn.prepareStatement(query);
//				ps.setString(2, user.getUserName());
//				ps.setInt(1, user.getGroupENTs().get(i).getGroupID());
//				ps.execute();
//			}
//			ps.close();
//			conn.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw getAMSException("", e);
//		}
//	}
//
//}
