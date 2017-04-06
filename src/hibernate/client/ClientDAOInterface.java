package hibernate.client;

import java.util.ArrayList;

import common.client.ClientENT;
import common.security.RoleENT;
import common.user.UserENT;
import common.user.UserLST;
import common.user.UserPassword;
import tools.AMSException;


public interface ClientDAOInterface {
	public ArrayList<ClientENT> getAllClients(String searchKey) throws AMSException;
	public ClientENT getClient(int clientID) throws AMSException;
}
