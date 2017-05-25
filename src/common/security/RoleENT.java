package common.security;

public class RoleENT {
	int roleID;
	String roleName = "";
	int clientID;
	String clientName;
	String roleCategory;
	int roleUserID;
	int roleGroupID;

	public String getRoleCategory() {
		return roleCategory;
	}

	public void setRoleCategory(String roleCategory) {
		this.roleCategory = roleCategory;
	}

	public RoleENT(int roleID, String roleName, int clientID,
			String clientName, int roleUserID, int roleGroupID, String comment) {
		super();
		this.roleID = roleID;
		this.roleName = roleName;
		this.clientID = clientID;
		this.clientName = clientName;
		this.roleUserID = roleUserID;
		this.roleGroupID = roleGroupID;
		this.comment = comment;
	}

	public int getRoleUserID() {
		return roleUserID;
	}

	public void setRoleUserID(int roleUserID) {
		this.roleUserID = roleUserID;
	}

	public int getRoleGroupID() {
		return roleGroupID;
	}

	public void setRoleGroupID(int roleGroupID) {
		this.roleGroupID = roleGroupID;
	}

	public RoleENT() {

	}

	public RoleENT(int roleID, String roleName, int clientID,
			String clientName, String comment) {
		super();
		this.roleID = roleID;
		this.roleName = roleName;
		this.clientID = clientID;
		this.clientName = clientName;
		this.comment = comment;
	}
	
	public RoleENT(int roleID) {
		super();
		this.roleID = roleID;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	String comment = "";

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getRoleID() {
		return roleID;
	}

	public void setRoleID(int roleID) {
		this.roleID = roleID;
	}

	public int getClientID() {
		return clientID;
	}

	public void setClientID(int clientID) {
		this.clientID = clientID;
	}

}
