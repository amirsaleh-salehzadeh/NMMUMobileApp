package common.security;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class RoleENT {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	int roleID;
	String roleName;
	int clientID;
	String comment;

//	public RoleENT(String roleName, int roleID, String comment, int clientID) {
//		this.roleName = roleName;
//		this.clientID = clientID;
//		this.comment = comment;
//		this.roleID = roleID;
//	}

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
