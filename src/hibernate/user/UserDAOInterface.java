package hibernate.user;

import java.util.ArrayList;

import common.DropDownENT;
import common.security.GroupENT;
import common.security.RoleENT;
import common.user.EthnicENT;
import common.user.TitleENT;
import common.user.UserENT;
import common.user.UserLST;
import tools.AMSException;


public interface UserDAOInterface {
	public UserENT saveUpdateUser(UserENT ent) throws AMSException;
	public UserLST getUserLST(UserLST lst) throws AMSException;
	public UserENT getUserENT(UserENT user) throws AMSException;
	public boolean deleteUser(UserENT user) throws AMSException;
	public ArrayList<EthnicENT> getAllEthnics() throws AMSException;
	public ArrayList<TitleENT> getAllTitles() throws AMSException;
	public EthnicENT getEthnic(int ethnicID) throws AMSException;
	public TitleENT getTitle(int titleID) throws AMSException;
	public ArrayList<RoleENT> getAllRolesUser(int uid);
	public ArrayList<GroupENT> getAllGroupsUser(int uid);
	public void saveUpdateUserRoles(UserENT user) throws AMSException;
	public ArrayList<DropDownENT> getTitlesDropDown();
	public ArrayList<DropDownENT> getEthnicsDropDown();
	//activate user
}
