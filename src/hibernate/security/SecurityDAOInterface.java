package hibernate.security;

import java.util.ArrayList;

import common.client.ClientENT;
import common.security.GroupENT;
import common.security.RoleENT;
import common.security.RoleLST;
import common.user.UserENT;
import common.user.UserLST;
import common.user.UserPassword;
import tools.AMSException;


public interface SecurityDAOInterface {
//	public boolean checkUsernameValidity(String userName) throws AMSException;
	public RoleLST getRolesList(RoleLST roleLST) throws AMSException;
//	public ArrayList<GroupENT> getGroupList(String searchKey, int clientID) throws AMSException;
	public RoleENT saveUpdateRole(RoleENT role) throws AMSException;
//	public boolean saveUpdateGroup(GroupENT group) throws AMSException;
	public RoleENT getRole(RoleENT role) throws AMSException;
//	public GroupENT getGroup(GroupENT group) throws AMSException;
	public boolean deleteRole(RoleENT role) throws AMSException;
//	public boolean deleteGroup(GroupENT group) throws AMSException;
	public RoleENT saveUserRole(RoleENT role) throws AMSException;
//	public GroupENT saveUserGroup(GroupENT group) throws AMSException;
//	public boolean saveGroupRole(GroupENT group) throws AMSException;
//	public ArrayList<UserRoleENT> getUserRoles(RoleENT role) throws AMSException;
//	public boolean getUserGroups(GroupENT group) throws AMSException;
//	public boolean getGroupRoles(GroupENT group) throws AMSException;
//	public boolean checkAuthority(int user_id,int role_id) throws AMSException;
//	public boolean changePassword(UserPassword ent) throws AMSException;
}
