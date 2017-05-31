package common.security;

public class RoleENT {
	String roleName = "";
	int clientID;
	String clientName;
	String roleCategory;
	int roleUserName;
	int roleGroupID;

	public String getRoleCategory() {
		return roleCategory;
	}

	public void setRoleCategory(String roleCategory) {
		this.roleCategory = roleCategory;
	}

	public RoleENT(String roleName, int clientID,
			String clientName, int roleUserName, int roleGroupID, String comment) {
		super();
		this.roleName = roleName;
		this.clientID = clientID;
		this.clientName = clientName;
		this.roleUserName = roleUserName;
		this.roleGroupID = roleGroupID;
		this.comment = comment;
	}

	public int getRoleUserName() {
		return roleUserName;
	}

	public void setRoleUserName(int roleUserName) {
		this.roleUserName = roleUserName;
	}

	public int getRoleGroupID() {
		return roleGroupID;
	}

	public void setRoleGroupID(int roleGroupID) {
		this.roleGroupID = roleGroupID;
	}

	public RoleENT() {

	}

	public RoleENT(String roleName, int clientID,
			String clientName, String comment) {
		super();
		this.roleName = roleName;
		this.clientID = clientID;
		this.clientName = clientName;
		this.comment = comment;
	}
	
	public RoleENT(String roleName) {
		super();
		this.roleName = roleName;
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

	public int getClientID() {
		return clientID;
	}

	public void setClientID(int clientID) {
		this.clientID = clientID;
	}

}
