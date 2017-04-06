package hibernate.security;

import java.util.ArrayList;

import common.client.ClientENT;
import common.security.GroupENT;
import common.security.RoleENT;
import common.user.UserENT;
import common.user.UserLST;
import common.user.UserPassword;
import tools.AMSException;


public interface SecurityDAOInterface {
	public boolean checkUsernameValidity(String userName) throws AMSException;
	public ArrayList<RoleENT> getRolesList(String searchKey, int clientID) throws AMSException;
	public ArrayList<GroupENT> getGroupList(String searchKey, int clientID) throws AMSException;
	public RoleENT saveUpdateRole(RoleENT role) throws AMSException;
	public boolean saveUpdateGroup(GroupENT group) throws AMSException;
	public boolean getRole(RoleENT role) throws AMSException;
	public boolean getGroup(GroupENT group) throws AMSException;
	public boolean deleteRole(RoleENT role) throws AMSException;
	public boolean deleteGroup(GroupENT group) throws AMSException;
	public boolean saveUserRole(RoleENT role) throws AMSException;
	public boolean saveUserGroup(GroupENT group) throws AMSException;
	public boolean saveGroupRole(GroupENT group) throws AMSException;
	public boolean getUserRoles(RoleENT role) throws AMSException;
	public boolean getUserGroups(GroupENT group) throws AMSException;
	public boolean getGroupRoles(GroupENT group) throws AMSException;
	public boolean checkAuthority(int user_id,int role_id) throws AMSException;
	public boolean changePassword(UserPassword ent) throws AMSException;
}
