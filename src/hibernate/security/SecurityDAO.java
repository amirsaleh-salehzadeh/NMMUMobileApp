package hibernate.security;

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
		try {
//
//			for (int i = 0; i < 30; i++) {
//				RoleENT roles = new RoleENT();
//				roles.setComment("commeneeet" + i);
//				roles.setRoleName("roleeddde" + i);
//				roles.setClientID(3);
//				udao.saveUpdateRole(roles);
////				System.out.println("hei");
//			}
			RoleLST role = udao.getRolesList(new RoleLST());
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
		} catch (AMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
		}
		return role;
	}
	
	

	private boolean deleteRole(RoleENT role) throws AMSException {
		Session session = getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.delete(role);
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
			return false;
		}
	}

	public RoleENT getRole(RoleENT role) throws AMSException {
		Query q = null;
		try {
			q = getSession().createQuery(
					"from RoleENT where roleID =:Id");
			q.setInteger("Id", role.getRoleID());
			role = (RoleENT) q.uniqueResult();
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
		Session session = getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.delete(group);
			tx.commit();
			session.clear();
			session.close();
			return true;
		} catch (HibernateException ex) {
			tx.rollback();
			session.clear();
			session.close();
			ex.printStackTrace();
			throw getAMSException(ex.toString(), ex);
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

}
