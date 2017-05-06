package common.security;

import java.util.ArrayList;

public class GroupRoleENT {

	ArrayList<RoleENT> roleENTs = new ArrayList<RoleENT>();
	int groupID;

	public ArrayList<RoleENT> getRoleENTs() {
		return roleENTs;
	}

	public void setRoleENTs(ArrayList<RoleENT> roleENTs) {
		this.roleENTs = roleENTs;
	}

	public int getGroupID() {
		return groupID;
	}

	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}

}
