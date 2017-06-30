package common.location;

import java.util.ArrayList;

public class LocationTypeENT {
	int locationTypeId;
	String locationType;
	LocationTypeENT parent;
	ArrayList<LocationENT> children;
	
	public LocationTypeENT getParent() {
		return parent;
	}

	public void setParent(LocationTypeENT parent) {
		this.parent = parent;
	}

	public ArrayList<LocationENT> getChildren() {
		return children;
	}

	public void setChildren(ArrayList<LocationENT> children) {
		this.children = children;
	}

	public LocationTypeENT(int locationTypeId, String locationType) {
		super();
		this.locationTypeId = locationTypeId;
		this.locationType = locationType;
	}
	
	public LocationTypeENT(int locationTypeId) {
		super();
		this.locationTypeId = locationTypeId;
	}

	public int getLocationTypeId() {
		return locationTypeId;
	}

	public void setLocationTypeId(int locationTypeId) {
		this.locationTypeId = locationTypeId;
	}

	public String getLocationType() {
		return locationType;
	}

	public void setLocationType(String locationType) {
		this.locationType = locationType;
	}

}
