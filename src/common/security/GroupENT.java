package common.security;

public class GroupENT {

	String groupName;
	int groupID;
	int clientID;
	String comment;

	public GroupENT(String groupName, int groupID, int clientID, String comment) {
		super();
		this.groupName = groupName;
		this.groupID = groupID;
		this.clientID = clientID;
		this.comment = comment;
	}
	
	public GroupENT() {
	}
	
	public GroupENT(int groupID) {
		super();
		this.groupID = groupID;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
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

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

}
