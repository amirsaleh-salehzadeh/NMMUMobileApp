package hibernate.user;

import common.user.UserENT;
import common.user.UserLST;
import tools.AMSException;


public interface UserDAOInterface {
	public boolean register(UserENT ent) throws AMSException;
	public UserLST getUserLST(UserLST lst) throws AMSException;
	public UserENT getUserENT(String username) throws AMSException;
	public void deleteUser(String username) throws AMSException;
	//activate user
}
