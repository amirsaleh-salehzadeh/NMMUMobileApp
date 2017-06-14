package common.location;

// Generated Apr 11, 2017 5:12:45 PM by Hibernate Tools 3.4.0.CR1

import java.math.BigInteger;
import java.util.ArrayList;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Location generated by hbm2java
 */
public class LocationENT {

	private long locationID;
	private String userName;
	private int country = 0;
	public LocationTypeENT locationType;
	private String address = "";
	private String postBox = "";
	private String gps = "";
	private String locationName = "";
	public ArrayList<LocationENT> childrenENT = new ArrayList<LocationENT>();

	
	public ArrayList<LocationENT> getChildrenENT() {
		return childrenENT;
	}

	public void setChildrenENT(ArrayList<LocationENT> childrenENT) {
		this.childrenENT = childrenENT;
	}

	public LocationENT(long locationID, String userName, int country,
			LocationTypeENT locationType, String address, String postBox,
			String gps, String locationName) {
		super();
//		if (address == null)
//			address = "N/A";
//		if (gps == null)
//			gps = "N/A";
		if (country == 0)
			country = 200;
		this.locationID = locationID;
		this.userName = userName;
		this.country = country;
		this.locationType = locationType;
		this.address = address;
		this.postBox = postBox;
		this.gps = gps;
		this.locationName = locationName;
	}

	public LocationENT() {
	}

	public LocationENT(long locationID, String userName,
			LocationTypeENT locationType, String address, String gps,
			String locationName) {
		super();
		if (address == null)
			address = "N/A";
		if (gps == null)
			gps = "N/A";
		if (country == 0)
			country = 200;
		this.locationID = locationID;
		this.userName = userName;
		this.locationType = locationType;
		this.address = address;
		this.gps = gps;
		this.locationName = locationName;
	}
	
	public LocationENT(String userName) {
		super();
		this.userName = userName;
	}

	public LocationENT(long locationID) {
		super();
		this.locationID = locationID;
	}

	public LocationTypeENT getLocationType() {
		return locationType;
	}

	public void setLocationType(LocationTypeENT locationType) {
		this.locationType = locationType;
	}

	public LocationENT(long locationID, String userName) {
		super();
		this.locationID = locationID;
		this.userName = userName;
	}

	public long getLocationID() {
		return this.locationID;
	}

	public void setLocationID(long locationID) {
		this.locationID = locationID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getCountry() {
		return this.country;
	}

	public void setCountry(int country) {
		this.country = country;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		if (address == null)
			address = "N/A";
		this.address = address;
	}

	public String getPostBox() {
		return this.postBox;
	}

	public void setPostBox(String postBox) {
		if (postBox == null)
			postBox = "N/A";
		this.postBox = postBox;
	}

	public String getGps() {
		return this.gps;
	}

	public void setGps(String gps) {
		if (gps == null)
			gps = "";
		this.gps = gps;
	}

	public String getLocationName() {
		return this.locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

}
