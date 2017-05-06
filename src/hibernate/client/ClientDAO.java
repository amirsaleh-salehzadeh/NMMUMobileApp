package hibernate.client;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.sun.jersey.spi.inject.ClientSide;

import common.DropDownENT;
import common.client.ClientENT;
import common.security.RoleENT;
import common.user.UserENT;
import common.user.UserLST;
import common.user.UserPassword;
import hibernate.config.BaseHibernateDAO;
import tools.AMSException;

public class ClientDAO extends BaseHibernateDAO implements ClientDAOInterface {

	public static void main(String[] args) {
		ClientDAO cdao = new ClientDAO();
		try {
			ArrayList<DropDownENT> clientENTs = cdao.getClientsDropDown();
			System.out.println("");
		} catch (AMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public ArrayList<ClientENT> getAllClients(String searchKey)
			throws AMSException {
		ArrayList<ClientENT> clientENTs = new ArrayList<ClientENT>();
		Query q = null;
		try {
			q = getSession().createQuery(
					"from ClientENT where clientName like :searchKey")
					.setParameter("searchKey", "%" + searchKey + "%");
			clientENTs = (ArrayList<ClientENT>) q.list();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return clientENTs;
	}

	public ClientENT getClient(int clientID) throws AMSException {
		// TODO Auto-generated method stub
		Query q = null;
		ClientENT clientENT = new ClientENT();
		try {
			q = getSession().createQuery(
					"from ClientENT where clientID = :searchKey").setParameter(
					"searchKey", clientID);
			clientENT = (ClientENT) q.uniqueResult();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return clientENT;
	}

	public ArrayList<DropDownENT> getClientsDropDown() throws AMSException {
		Query q = null;
		ArrayList<DropDownENT> res = new ArrayList<DropDownENT>();
		try {
			Session s = getSession4Query();
			s.beginTransaction();
			List<ClientENT> dropdowns = getSession4Query()
					.createQuery(
							"from ClientENT").list();
			for(ClientENT dropdown : dropdowns) {
				res.add(new DropDownENT(dropdown.getClientID()+"", dropdown.getClientName(), null));
			}
			// List dropDown = q.list();
		} catch (HibernateException ex) {
			ex.printStackTrace();
		}
		return res;
	}

}
