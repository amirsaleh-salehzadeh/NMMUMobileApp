package common.security;

import javax.persistence.*;

@Entity
@Table(name = "roles")
public class RoleENT {
	
	@Id
	@GeneratedValue
	@Column(name = "role_id")
	int roleID;
	@Column(name = "role_name")
	String roleName = "";
	@Column(name = "client_id")
	int clientID;
	@Column(name = "comment")
	String comment ="";

	// public RoleENT(String roleName, int roleID, String comment, int clientID)
	// {
	// this.roleName = roleName;
	// this.clientID = clientID;
	// this.comment = comment;
	// this.roleID = roleID;
	// }

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
