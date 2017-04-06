package common.security;

public class GroupENT {
	String groupName;
	int group_ID;
	int client_id;
	String comment;
	
	public String getgroupName() {
		return groupName;
	}
	public void setgroupName(String groupName) {
		this.groupName = groupName;
	}
	public int getgroup_ID() {
		return group_ID;
	}
	public void setgroup_ID(int group_ID) {
		this.group_ID = group_ID;
	}
	public int getClient_id() {
		return client_id;
	}
	public void setClient_id(int client_id) {
		this.client_id = client_id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
}
