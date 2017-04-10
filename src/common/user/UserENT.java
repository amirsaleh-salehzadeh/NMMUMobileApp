package common.user;

import java.util.ArrayList;

import common.location.LocationENT;
import common.security.GroupENT;
import common.security.RoleENT;

public class UserENT {
	String userName;
	int userID;
	int clientID;
	String password;
	String registerationDate;
	String name;
	String surName;
	String dateOfBirth;
	boolean gender;
	boolean active;
	EthnicENT ethnic = new EthnicENT();
	int ethnicID;
	TitleENT title = new TitleENT();
	int titleID;
	ArrayList<RoleENT> roleENTs = new ArrayList<RoleENT>();
	ArrayList<GroupENT> groupENTs = new ArrayList<GroupENT>();
	ArrayList<LocationENT> locationENTs = new ArrayList<LocationENT>();


	public void setRoleENTs(ArrayList<RoleENT> roleENTs) {
		this.roleENTs = roleENTs;
	}

	public ArrayList<GroupENT> getGroupENTs() {
		return groupENTs;
	}

	public void setGroupENTs(ArrayList<GroupENT> groupENTs) {
		this.groupENTs = groupENTs;
	}

	public ArrayList<LocationENT> getLocationENTs() {
		return locationENTs;
	}

	public void setLocationENTs(ArrayList<LocationENT> locationENTs) {
		this.locationENTs = locationENTs;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getClientID() {
		return clientID;
	}

	public void setClientID(int clientID) {
		this.clientID = clientID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRegisterationDate() {
		return registerationDate;
	}

	public void setRegisterationDate(String registerationDate) {
		this.registerationDate = registerationDate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurName() {
		return surName;
	}

	public void setSurName(String sureName) {
		this.surName = sureName;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public boolean isGender() {
		return gender;
	}

	public void setGender(boolean gender) {
		this.gender = gender;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public EthnicENT getEthnic() {
		return ethnic;
	}

	public void setEthnic(EthnicENT ethnic) {
		this.ethnic = ethnic;
		setEthnicID(ethnic.getEthnicID());
	}

	public int getEthnicID() {
		return ethnicID;
	}

	public void setEthnicID(int ethnicID) {
		this.ethnicID = ethnicID;
	}

	public int getTitleID() {
		return titleID;
	}

	public void setTitleID(int titleID) {
		this.titleID = titleID;
	}

	public ArrayList<RoleENT> getRoleENTs() {
		return roleENTs;
	}

	public TitleENT getTitle() {
		return title;
	}

	public void setTitle(TitleENT title) {
		this.title = title;
		setTitleID(title.getTitleID());
	}

}
