package common.location;

public class LocationTypeENT {
	int locationTypeId;
	String locationType;

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
