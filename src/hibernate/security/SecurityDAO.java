package hibernate.security;

import java.util.ArrayList;
import java.util.Arrays;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import common.client.ClientENT;
import common.security.GroupENT;
import common.security.RoleENT;
import common.user.UserENT;
import common.user.UserLST;
import common.user.UserPassword;
import hibernate.config.BaseHibernateDAO;
import hibernate.config.HibernateSessionFactory;
import tools.AMSException;

public class SecurityDAO extends BaseHibernateDAO implements
		SecurityDAOInterface {

	public static void main(String[] args) {
		SecurityDAO udao = new SecurityDAO();
		try {
//			RoleENT roles = new RoleENT("Test", 7, "comm", 1);
			udao.getRolesList("", 1);
			System.out.println("done");
		} catch (AMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<RoleENT> getRolesList(String searchKey, int clientID)
			throws AMSException {
		ArrayList<RoleENT> roleENTs = new ArrayList<RoleENT>();
		Query q = null;
		try {
			q = getSession()
					.createQuery(
							"from RoleENT where roleName like :searchKey and clientID =:clientID")
					.setParameter("searchKey", "%" + searchKey + "%")
					.setParameter("clientID", clientID);
			roleENTs = (ArrayList<RoleENT>) q.list();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return roleENTs;
	}

	public boolean checkUsernameValidity(String userName) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public ArrayList<GroupENT> getGroupList(String searchKey, int clientID)
			throws AMSException {
		// TODO Auto-generated method stub
		return null;
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

	public boolean saveUpdateGroup(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return false;
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

	public boolean getRole(RoleENT role) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean getGroup(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean deleteGroup(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean saveUserRole(RoleENT role) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean saveUserGroup(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean saveGroupRole(GroupENT group) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean getUserRoles(RoleENT role) throws AMSException {
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

	public boolean checkAuthority(int user_id, int role_id) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean changePassword(UserPassword ent) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}



}
