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
			RoleENT roles = new RoleENT();
			for (int i = 0; i < 5; i++) {
				roles.setComment("comment"+i);
				roles.setRoleName("role"+i);
				roles.setClientID(1);
				roles = udao.saveUpdateRole(roles);
			}
			
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
			session.saveOrUpdate(role);
			session.flush();
			tx.commit();
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

	public boolean deleteRole(RoleENT role) throws AMSException {
		Session session = getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.delete(role);
			session.flush();
			tx.commit();
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
					"from RoleENT where roleID =:searchKey ").setParameter(
					"searchKey", role.getRoleID());
			role = (RoleENT) q.uniqueResult();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return role;
	}

	public RoleLST getRolesList(RoleLST roleLST) throws AMSException {
		ArrayList<RoleENT> roleENTs = new ArrayList<RoleENT>();
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

			q = getSession4Query().createQuery(query);
			q.setParameter("roleName", "%"
					+ roleLST.getSearchRole().getRoleName() + "%");
			roleLST.setTotalItems(q.list().size());
			q.setFirstResult(roleLST.getFirst());
			q.setMaxResults(roleLST.getPageSize());
//			q = getSession4Query().createSQLQuery("select * from roles");
			roleENTs = (ArrayList<RoleENT>) q.list();
			roleLST.setRoleENTs(roleENTs);
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return roleLST;
	}

	public RoleENT saveUserRole(RoleENT role) throws AMSException {
		// TODO Auto-generated method stub
		return null;
	}

}
