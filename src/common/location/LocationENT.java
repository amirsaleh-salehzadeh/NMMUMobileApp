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
	private String clientName;
	public LocationTypeENT locationType;
	private String gps = "";
	private String locationName = "";
	private String icon = "";
	private String plan = "";
	private String boundary = "";
	private String description = "";
	private long parentId;
	private ArrayList<LevelENT> levels;
	private ArrayList<EntranceIntersectionENT> entrances;

	/**
	 * @return the entrances
	 */
	public ArrayList<EntranceIntersectionENT> getEntrances() {
		return entrances;
	}

	/**
	 * @param entrances
	 *            the entrances to set
	 */
	public void setEntrances(ArrayList<EntranceIntersectionENT> entrances) {
		this.entrances = entrances;
	}

	public ArrayList<LocationENT> childrenENT = new ArrayList<LocationENT>();
	private LocationENT parent;

	public LocationENT(long locationID, String clientName,
			LocationTypeENT locationType, String gps, String locationName,
			String icon, String plan, String boundary, String description,
			long parentId, ArrayList<LocationENT> childrenENT,
			LocationENT parent) {
		super();
		this.locationID = locationID;
		this.clientName = clientName;
		this.locationType = locationType;
		this.gps = gps;
		this.locationName = locationName;
		this.icon = icon;
		this.plan = plan;
		this.boundary = boundary;
		this.description = description;
		this.parentId = parentId;
		this.childrenENT = childrenENT;
		this.parent = parent;
	}

	/**
	 * @return the floors
	 */
	public ArrayList<LevelENT> getLevels() {
		return levels;
	}

	/**
	 * @param floors
	 *            the floors to set
	 */
	public void setLevels(ArrayList<LevelENT> levels) {
		this.levels = levels;
	}

	/**
	 * @return the icon
	 */
	public String getIcon() {
		return icon;
	}

	/**
	 * @param icon
	 *            the icon to set
	 */
	public void setIcon(String icon) {
		this.icon = icon;
	}

	/**
	 * @return the plan
	 */
	public String getPlan() {
		return plan;
	}

	/**
	 * @param plan
	 *            the plan to set
	 */
	public void setPlan(String plan) {
		this.plan = plan;
	}

	/**
	 * @return the boundary
	 */
	public String getBoundary() {
		return boundary;
	}

	/**
	 * @param boundary
	 *            the boundary to set
	 */
	public void setBoundary(String boundary) {
		this.boundary = boundary;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the parent
	 */
	public LocationENT getParent() {
		return parent;
	}

	/**
	 * @param parent
	 *            the parent to set
	 */
	public void setParent(LocationENT parent) {
		this.parent = parent;
	}

	public LocationENT(long locationID, String clientName,
			LocationTypeENT locationType, String gps, String locationName,
			long parentId, ArrayList<LocationENT> childrenENT) {
		super();
		this.locationID = locationID;
		this.clientName = clientName;
		this.locationType = locationType;
		this.gps = gps;
		this.locationName = locationName;
		this.parentId = parentId;
		this.childrenENT = childrenENT;
	}

	/**
	 * @return the parentId
	 */
	public long getParentId() {
		return parentId;
	}

	/**
	 * @param parentId
	 *            the parentId to set
	 */
	public void setParentId(long parentId) {
		this.parentId = parentId;
	}

	public ArrayList<LocationENT> getChildrenENT() {
		return childrenENT;
	}

	public void setChildrenENT(ArrayList<LocationENT> childrenENT) {
		this.childrenENT = childrenENT;
	}

	public LocationENT(long locationID, String clientName,
			LocationTypeENT locationType, String gps, String locationName) {
		super();
		this.locationID = locationID;
		this.clientName = clientName;
		this.locationType = locationType;
		this.gps = gps;
		this.locationName = locationName;
	}

	public LocationENT() {
	}

	public LocationENT(long locationID, String clientName,
			LocationTypeENT locationType, String locationName) {
		super();
		this.locationID = locationID;
		this.clientName = clientName;
		this.locationType = locationType;
		this.locationName = locationName;
	}

	public LocationENT(String clientName) {
		super();
		this.clientName = clientName;
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

	public LocationENT(long locationID, String clientName) {
		super();
		this.locationID = locationID;
		this.clientName = clientName;
	}

	public long getLocationID() {
		return this.locationID;
	}

	public void setLocationID(long locationID) {
		this.locationID = locationID;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
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
