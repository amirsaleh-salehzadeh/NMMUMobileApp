package hibernate.security;

import java.util.ArrayList;

import common.client.ClientENT;
import common.security.GroupENT;
import common.security.GroupLST;
import common.security.RoleENT;
import common.security.RoleLST;
import common.user.UserENT;
import common.user.UserLST;
import common.user.UserPassword;
import tools.AMSException;


public interface SecurityDAOInterface {
//	public boolean checkUsernameValidity(String userName) throws AMSException;
	public RoleLST getRolesList(RoleLST roleLST) throws AMSException;
	public GroupLST getGroupList(GroupLST groupLST) throws AMSException;
	public RoleENT saveUpdateRole(RoleENT role) throws AMSException;
	public GroupENT saveUpdateGroup(GroupENT group) throws AMSException;
	public RoleENT getRole(RoleENT role) throws AMSException;
	public GroupENT getGroup(GroupENT group) throws AMSException;
	public boolean deleteRoles(ArrayList<RoleENT> roles) throws AMSException;
	public boolean deleteGroups(ArrayList<GroupENT> groups) throws AMSException;
//	public RoleENT saveUserRole(RoleENT role) throws AMSException;
//	public GroupENT saveUserGroup(GroupENT group) throws AMSException;
//	public boolean saveGroupRole(GroupENT group) throws AMSException;
//	public ArrayList<UserRoleENT> getUserRoles(RoleENT role) throws AMSException;
//	public boolean getUserGroups(GroupENT group) throws AMSException;
//	public boolean getGroupRoles(GroupENT group) throws AMSException;
//	public boolean checkAuthority(int user_id,int role_id) throws AMSException;
//	public boolean changePassword(UserPassword ent) throws AMSException;
}
