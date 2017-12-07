package hibernate.security;

import java.sql.Connection;
import java.util.ArrayList;

import common.security.GroupENT;
import common.security.GroupLST;
import common.security.RoleENT;
import common.security.RoleLST;
import common.user.UserPassword;
import tools.AMSException;


public interface SecurityDAOInterface {
//	public boolean checkUsernameValidity(String userName) throws AMSException;
	public RoleLST getRolesList(RoleLST roleLST) throws AMSException;
	public GroupLST getGroupList(GroupLST groupLST) throws AMSException;
	public ArrayList<String> getAllRoleCategories(String filter);
	public RoleENT saveUpdateRole(RoleENT role, Connection conn) throws AMSException;
	public GroupENT saveUpdateGroup(GroupENT group) throws AMSException;
	public RoleENT getRole(RoleENT role) throws AMSException;
	public GroupENT getGroup(GroupENT group) throws AMSException;
	public boolean deleteRoles(ArrayList<RoleENT> roles) throws AMSException;
	public boolean deleteGroups(ArrayList<GroupENT> groups) throws AMSException;
	public RoleENT validateRole(RoleENT role) throws AMSException;
	public ArrayList<RoleENT> getAllGroupRoles(int gid);
	public void saveUpdateRolesGroup(ArrayList<RoleENT> roles, GroupENT group) throws AMSException;
	public void changePassword(String oldPass, String newPass, String username) throws AMSException;
	public RoleENT saveUserRole(RoleENT role) throws AMSException;
	public GroupENT saveUserGroup(GroupENT group) throws AMSException;
	public boolean saveGroupRole(GroupENT group) throws AMSException;
//	public ArrayList<UserRoleENT> getUserRoles(RoleENT role) throws AMSException;
	public boolean getUserGroups(GroupENT group) throws AMSException;
	public boolean getGroupRoles(GroupENT group) throws AMSException;
	public boolean changePassword(UserPassword ent) throws AMSException;
	public UserPassword register(UserPassword userPassword) throws AMSException;
}
