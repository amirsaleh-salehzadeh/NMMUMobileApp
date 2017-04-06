package hibernate.user;

import java.util.ArrayList;
import java.util.Arrays;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import common.client.ClientENT;
import common.security.RoleENT;
import common.user.UserENT;
import common.user.UserLST;
import common.user.UserPassword;
import hibernate.config.BaseHibernateDAO;
import tools.AMSException;

public class UserDAO extends BaseHibernateDAO implements UserDAOInterface {

	public static void main(String[] args) {
		UserDAO udao = new UserDAO();
		try {
			ArrayList<RoleENT> roles = new ArrayList<RoleENT>();
			roles = udao.getRolesList("", 1);
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
			q = getSession().createQuery(
					"from RoleENT where roleName like :searchKey and clientID IN :clientID")
					.setParameter("searchKey", "%" + searchKey + "%")
					.setParameter("clientID", clientID);
			roleENTs = (ArrayList<RoleENT>) q.list();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return roleENTs;
	}



	public boolean register(UserENT ent) throws AMSException {
		// TODO Auto-generated method stub
		return false;
	}


	public UserLST getUserLST(UserLST lst) throws AMSException {
		// TODO Auto-generated method stub
		return null;
	}


	public UserENT getUserENT(String username) throws AMSException {
		// TODO Auto-generated method stub
		return null;
	}


	public void deleteUser(String username) throws AMSException {
		// TODO Auto-generated method stub
		
	}

}
