package common.location;

public class EntranceIntersectionENT {
	long entranceId;
	long parent_id;
	String description;
	String gps;
	boolean entranceIntersection;
	
	public EntranceIntersectionENT(long entranceId, long parent_id,
			String description, String gps, boolean entranceIntersection) {
		super();
		this.entranceId = entranceId;
		this.parent_id = parent_id;
		this.description = description;
		this.gps = gps;
		this.entranceIntersection = entranceIntersection;
	}

	/**
	 * @return the entranceIntersection
	 */
	public boolean isEntranceIntersection() {
		return entranceIntersection;
	}

	/**
	 * @param entranceIntersection the entranceIntersection to set
	 */
	public void setEntranceIntersection(boolean entranceIntersection) {
		this.entranceIntersection = entranceIntersection;
	}

	public EntranceIntersectionENT(long entranceId) {
		super();
		this.entranceId = entranceId;
	}
	
	public EntranceIntersectionENT(long entranceId, long parent_id, String description,
			String gps) {
		super();
		this.entranceId = entranceId;
		this.parent_id = parent_id;
		this.description = description;
		this.gps = gps;
	}
	/**
	 * @return the entranceId
	 */
	public long getEntranceId() {
		return entranceId;
	}
	/**
	 * @param entranceId the entranceId to set
	 */
	public void setEntranceId(long entranceId) {
		this.entranceId = entranceId;
	}
	/**
	 * @return the parent_id
	 */
	public long getParent_id() {
		return parent_id;
	}
	/**
	 * @param parent_id the parent_id to set
	 */
	public void setParent_id(long parent_id) {
		this.parent_id = parent_id;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the gps
	 */
	public String getGps() {
		return gps;
	}
	/**
	 * @param gps the gps to set
	 */
	public void setGps(String gps) {
		this.gps = gps;
	}
	
}
