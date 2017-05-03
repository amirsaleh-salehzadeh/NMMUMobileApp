package common.security;

public class GroupENT {
	int groupID;
	String groupName = "";
	int clientID;
	String clientName;
	int groupUserID;
	int roleGroupID;
	
	public GroupENT(int groupID, String groupName, int clientID,
			String clientName, int groupUserID, int roleGroupID, String comment) {
		super();
		this.groupID = groupID;
		this.groupName = groupName;
		this.clientID = clientID;
		this.clientName = clientName;
		this.groupUserID = groupUserID;
		this.roleGroupID = roleGroupID;
		this.comment = comment;
	}

	public int getGroupUserID() {
		return groupUserID;
	}

	public void setGroupUserID(int groupUserID) {
		this.groupUserID = groupUserID;
	}

	public int getRoleGroupID() {
		return roleGroupID;
	}

	public void setRoleGroupID(int roleGroupID) {
		this.roleGroupID = roleGroupID;
	}

	public GroupENT() {
		
	}
	
	public GroupENT(int groupID, String groupName, int clientID,
			String clientName, String comment) {
		super();
		this.groupID = groupID;
		this.groupName = groupName;
		this.clientID = clientID;
		this.clientName = clientName;
		this.comment = comment;
	}
	
	public GroupENT(int groupID) {
		super();
		this.groupID = groupID;
	}
	
	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	
	String comment = "";

	public String getGroupName() {
		return groupName;
	}
	
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public String getComment() {
		return comment;
	}
	
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public int getGroupID() {
		return groupID;
	}

	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}

	public int getClientID() {
		return clientID;
	}

	public void setClientID(int clientID) {
		this.clientID = clientID;
	}

}
