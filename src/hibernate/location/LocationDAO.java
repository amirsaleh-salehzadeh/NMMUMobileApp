package hibernate.location;

import java.util.ArrayList;
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
import hibernate.config.BaseHibernateDAO;
import hibernate.config.HibernateSessionFactory;
import tools.AMSException;

public class LocationDAO extends BaseHibernateDAO implements
		LocationDAOInterface {
	public static void main(String[] args) {
		// for (int i = 3; i < 14; i++) {
		// LocationENT location = new LocationENT();
		// location.setAddress("address"+i);
		// location.setArea("area"+i);
		// location.setCell("cell"+i);
		// location.setCountry(i);
		// location.setEmail("email"+i);
		// location.setFax("fax"+i);
		// location.setGps("gps"+i);
		// location.setLocationName("NAME"+i);
		// location.setPostBox("pob"+i);
		// location.setState("state"+i);
		// location.setStreet("street"+i);
		// location.setTel("tel"+i);
		// location.setUserID(5);
		LocationDAO lad = new LocationDAO();
		// try {
		// lad.saveUpdateLocation(location);
		// } catch (AMSException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// LocationLST lst = new LocationLST();
		// LocationENT location = new LocationENT();
		// location.setLocationID(1);
		// LocationDAO lad = new LocationDAO();
		// try {
		// lst.setSearchKey("state");
		// location.setCell("");
		// location.setEmail("");
		// lst.setSearchLocation(location);
		// lst = lad.getLocationLST(lst);
		// System.out.println("sss");
		// } catch (AMSException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// }
		ArrayList<DropDownENT> cnt = lad.getAllCountrirs();
		System.out.println("");
	}

	public LocationENT saveUpdateLocation(LocationENT ent) throws AMSException {
		Session session = getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			if (ent.getLocationID() <= 0) {
				if (getLocationENT(ent) == null)
					session.save(ent);
				else
					throw getAMSException("The role already Exist", null);
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
			throw getAMSException("", ex);
		}
		return ent;
	}

	public LocationLST getLocationLST(LocationLST lst) throws AMSException {
		ArrayList<LocationENT> locationENTs = new ArrayList<LocationENT>();
		Query q = null;
		int userid = lst.getSearchLocation().getUserID();
		try {
			String query = "from LocationENT where state like :state or street like :street or area like :area "
					+ "or cell like :cell or email like :email  ";
			if (userid > 0)
				query += "and userID = " + userid;
			query += " order by " + lst.getSortedByField();
			if (lst.isAscending())
				query += " Asc";
			else
				query += " Desc";
			q = getSession().createQuery(query);
			q.setParameter("state", "%" + lst.getSearchLocation().getState()
					+ "%");
			q.setParameter("street", "%" + lst.getSearchLocation().getStreet()
					+ "%");
			q.setParameter("area", "%" + lst.getSearchLocation().getArea()
					+ "%");
			q.setParameter("cell", "%" + lst.getSearchLocation().getCell()
					+ "%");
			q.setParameter("email", "%" + lst.getSearchLocation().getEmail()
					+ "%");
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

	public LocationENT getLocationENT(LocationENT ent) throws AMSException {
		Query q = null;
		try {
			q = getSession().createQuery(
					"from LocationENT where locationID =:Id");
			q.setLong("Id", ent.getLocationID());
			ent = (LocationENT) q.uniqueResult();
			HibernateSessionFactory.closeSession();
		} catch (HibernateException ex) {
			ex.printStackTrace();
			ent = null;
			throw getAMSException("", ex);
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
			// List dropDown = q.list();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return res;
	}

}
