package common.user;

import java.util.ArrayList;

import common.security.GroupENT;
import common.security.RoleENT;

public class UserENT {
	String userName;
	int user_id;
	int client_id;
	UserPassword password = new UserPassword();
	String registerationDate;
	String name;
	String sureName;
	String dateOfBirth;
	String nationalID;
	boolean gender;
	boolean active;
	int race;
	String raceDescription;
	int title;
	String titleDescription;
	String tel;
	ArrayList<RoleENT> roleENTs = new ArrayList<RoleENT>();
	ArrayList<GroupENT> groupENTs = new ArrayList<GroupENT>();
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getClient_id() {
		return client_id;
	}
	public void setClient_id(int client_id) {
		this.client_id = client_id;
	}
	public UserPassword getPassword() {
		return password;
	}
	public void setPassword(UserPassword password) {
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
	public String getSureName() {
		return sureName;
	}
	public void setSureName(String sureName) {
		this.sureName = sureName;
	}
	public String getDateOfBirth() {
		return dateOfBirth;
	}
	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}
	public String getNationalID() {
		return nationalID;
	}
	public void setNationalID(String nationalID) {
		this.nationalID = nationalID;
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
	public int getRace() {
		return race;
	}
	public void setRace(int race) {
		this.race = race;
	}
	public String getRaceDescription() {
		return raceDescription;
	}
	public void setRaceDescription(String raceDescription) {
		this.raceDescription = raceDescription;
	}
	public int getTitle() {
		return title;
	}
	public void setTitle(int title) {
		this.title = title;
	}
	public String getTitleDescription() {
		return titleDescription;
	}
	public void setTitleDescription(String titleDescription) {
		this.titleDescription = titleDescription;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public ArrayList<RoleENT> getRoleENTs() {
		return roleENTs;
	}
	public void setRoleENTs(ArrayList<RoleENT> roleENTs) {
		this.roleENTs = roleENTs;
	}
	public ArrayList<GroupENT> getGroupENTs() {
		return groupENTs;
	}
	public void setGroupENTs(ArrayList<GroupENT> groupENTs) {
		this.groupENTs = groupENTs;
	}

}
