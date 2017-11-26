package common.location;

import java.util.ArrayList;

public class PathENT {
	LocationENT departure;
	LocationENT destination;
	LocationLightENT depL;
	LocationLightENT desL;
	double distance;
	ArrayList<PathTypeENT> pathTypes;
	String pathType;
	long pathId;
	String pathRoute;
	double width;
	String pathName;
	String description;
	

	/**
	 * @return the pathType
	 */
	public String getPathType() {
		return pathType;
	}

	/**
	 * @param pathType the pathType to set
	 */
	public void setPathType(String pathType) {
		this.pathType = pathType;
	}

	/**
	 * @return the pathRoute
	 */
	public String getPathRoute() {
		return pathRoute;
	}

	/**
	 * @param pathRoute the pathRoute to set
	 */
	public void setPathRoute(String pathRoute) {
		this.pathRoute = pathRoute;
	}

	public PathENT() {
	}

	/**
	 * @return the pathType
	 */
	public ArrayList<PathTypeENT> getPathTypes() {
		return pathTypes;
	}

	/**
	 * @param pathType the pathType to set
	 */
	public void setPathTypes(ArrayList<PathTypeENT> pathTypes) {
		this.pathTypes = pathTypes;
	}

	/**
	 * @return the width
	 */
	public double getWidth() {
		return width;
	}

	/**
	 * @param width the width to set
	 */
	public void setWidth(double width) {
		this.width = width;
	}

	/**
	 * @return the pathName
	 */
	public String getPathName() {
		return pathName;
	}

	/**
	 * @param pathName the pathName to set
	 */
	public void setPathName(String pathName) {
		this.pathName = pathName;
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

	public PathENT(LocationENT departure, LocationENT destination,
			double distance, PathTypeENT pathType) {
		super();
		this.departure = departure;
		this.destination = destination;
		this.distance = distance;
		this.pathTypes = new ArrayList<PathTypeENT>();
		this.pathTypes.add(pathType);
	}

	public PathENT(LocationENT departure, LocationENT destination,
			double distance, PathTypeENT pathType, long pathId) {
		super();
		this.departure = departure;
		this.destination = destination;
		this.distance = distance;
		this.pathTypes = new ArrayList<PathTypeENT>();
		this.pathTypes.add(pathType);
		this.pathId = pathId;
	}
	
	public PathENT(LocationLightENT departure, LocationLightENT destination,
			double distance, PathTypeENT pathType, long pathId) {
		super();
		this.depL = departure;
		this.desL = destination;
		this.distance = distance;
		this.pathTypes = new ArrayList<PathTypeENT>();
		this.pathTypes.add(pathType);
		this.pathId = pathId;
	}

	/**
	 * @return the depL
	 */
	public LocationLightENT getDepL() {
		return depL;
	}

	/**
	 * @param depL the depL to set
	 */
	public void setDepL(LocationLightENT depL) {
		this.depL = depL;
	}

	/**
	 * @return the desL
	 */
	public LocationLightENT getDesL() {
		return desL;
	}

	/**
	 * @param desL the desL to set
	 */
	public void setDesL(LocationLightENT desL) {
		this.desL = desL;
	}

	public PathENT(long pathId) {
		super();
		this.pathId = pathId;
	}

	public PathENT(LocationENT departure, LocationENT destination) {
		super();
		this.departure = departure;
		this.destination = destination;
	}

	public long getPathId() {
		return pathId;
	}

	public void setPathId(long pathId) {
		this.pathId = pathId;
	}

	public PathENT(LocationENT departure, LocationENT destination,
			PathTypeENT pathType) {
		super();
		this.departure = departure;
		this.destination = destination;
		this.pathTypes = new ArrayList<PathTypeENT>();
		this.pathTypes.add(pathType);
	}

	public LocationENT getDeparture() {
		return departure;
	}

	public void setDeparture(LocationENT departure) {
		this.departure = departure;
	}

	public LocationENT getDestination() {
		return destination;
	}

	public void setDestination(LocationENT destination) {
		this.destination = destination;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

}
