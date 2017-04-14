package hibernate.user;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import common.client.ClientENT;
import common.security.RoleENT;
import common.user.EthnicENT;
import common.user.TitleENT;
import common.user.UserENT;
import common.user.UserLST;
import common.user.UserPassword;
import hibernate.config.BaseHibernateDAO;
import hibernate.config.HibernateSessionFactory;
import tools.AMSException;

public class UserDAO extends BaseHibernateDAO implements UserDAOInterface {

	public static void main(String[] args) {
		UserDAO udao = new UserDAO();
		// try {
		// for (int i = 14; i < 20; i++) {
		// TitleENT roles = new TitleENT();
		// roles = udao.getTitle(2);
		// EthnicENT eth = new EthnicENT();
		// eth = udao.getEthnic(2);
		// UserENT ent = new UserENT();
		// // ent.setUserID(i);
		// ent.setActive(true);
		// ent.setClientID(1);
		// ent.setDateOfBirth("dob");
		// ent.setGender(true);
		// ent.setEthnic(eth);
		// ent.setRegisterationDate("today");
		// ent.setSurName("surnamezzz");
		// ent.setName("namezzzz"+i);
		// ent.setTitle(roles);
		// ent.setUserName("userNamezzzz4");
		// UserPassword up = new UserPassword();
		// up.setUserPassword("passsssss"+i);
		// ent.setPassword("pass"+i);
		// ent = udao.saveUpdateUser(ent);

		UserLST l = new UserLST();
		UserENT us = new UserENT();
		System.out.println(us.toString());
		// l.setSearchUser(us);
		// udao.deleteUser(us);

		System.out.println("done");
		// }
		// } catch (AMSException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
	}

	public UserENT saveUpdateUser(UserENT ent) throws AMSException {
		Session session = getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			if (ent.getUserID() <= 0) {
				if (getUserENT(ent) == null)
					session.save(ent);
				else
					throw getAMSException("The username already Exist", null);
			} else
				session.saveOrUpdate(ent);
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
		return ent;
	}

	public UserLST getUserLST(UserLST lst) throws AMSException {
		ArrayList<UserENT> userENTs = new ArrayList<UserENT>();
		Query q = null;
		int clientid = lst.getSearchUser().getClientID();
		try {
			String query = "from UserENT where username like :uname ";
			if (clientid > 0)
				query += "and clientID = " + clientid;
			query += " order by " + lst.getSortedByField();
			if (lst.isAscending())
				query += " Asc";
			else
				query += " Desc";

			q = getSession().createQuery(query);
			q.setParameter("uname", "%" + lst.getSearchUser().getUserName()
					+ "%");
			lst.setTotalItems(q.list().size());
			q.setFirstResult(lst.getFirst());
			q.setMaxResults(lst.getPageSize());
			userENTs = (ArrayList<UserENT>) q.list();
			lst.setUserENTs(userENTs);
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return lst;
	}

	public boolean deleteUser(UserENT username) throws AMSException {
		Session session = getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.delete(username);
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

	public ArrayList<EthnicENT> getAllEthnics() throws AMSException {
		ArrayList<EthnicENT> list = new ArrayList<EthnicENT>();
		Query q = null;
		try {
			q = getSession().createQuery("from EthnicENT");
			list = (ArrayList<EthnicENT>) q.list();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public ArrayList<TitleENT> getAllTitles() throws AMSException {
		ArrayList<TitleENT> list = new ArrayList<TitleENT>();
		Query q = null;
		try {
			q = getSession().createQuery("from TitleENT");
			list = (ArrayList<TitleENT>) q.list();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public EthnicENT getEthnic(int ethnicID) throws AMSException {
		Query q = null;
		EthnicENT ethnic = new EthnicENT();
		try {
			q = getSession().createQuery("from EthnicENT where ethnicID =:Id");
			q.setInteger("Id", ethnicID);
			ethnic = (EthnicENT) q.uniqueResult();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
			ethnic = null;
		}
		return ethnic;
	}

	public TitleENT getTitle(int titleID) throws AMSException {
		Query q = null;
		TitleENT title = new TitleENT();
		try {
			q = getSession().createQuery("from TitleENT where titleID =:Id");
			q.setInteger("Id", titleID);
			title = (TitleENT) q.uniqueResult();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
			title = null;
		}
		return title;
	}

	public UserENT getUserENT(UserENT user) throws AMSException {
		Query q = null;
		try {
			q = getSession().createQuery(
					"from UserENT where userID =:Id or username =:uname");
			q.setInteger("Id", user.getUserID());
			q.setString("uname", user.getUserName());
			user = (UserENT) q.uniqueResult();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
			user = null;
		}
		return user;
	}

}
