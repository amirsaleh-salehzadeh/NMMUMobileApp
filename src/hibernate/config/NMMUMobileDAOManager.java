package hibernate.config;

import hibernate.client.ClientDAO;
import hibernate.client.ClientDAOInterface;
import hibernate.security.SecurityDAO;
import hibernate.security.SecurityDAOInterface;
import hibernate.user.UserDAO;
import hibernate.user.UserDAOInterface;

public class NMMUMobileDAOManager {
	
	static UserDAOInterface _userDAOInterface ;
	static SecurityDAOInterface _securityDAOInterface ;
	static ClientDAOInterface _clientDAOInterface ;
	
	public static UserDAOInterface getUserDAOInterface(){
		if (_userDAOInterface == null) {
			_userDAOInterface = new UserDAO();
		}
		return _userDAOInterface; 
	}
	
	public static SecurityDAOInterface getSecuirtyDAOInterface(){
		if (_securityDAOInterface == null) {
			_securityDAOInterface = new SecurityDAO();
		}
		return _securityDAOInterface; 
	}
	
	public static ClientDAOInterface getClientDAOInterface(){
		if (_clientDAOInterface == null) {
			_clientDAOInterface = new ClientDAO();
		}
		return _clientDAOInterface; 
	}
	
}