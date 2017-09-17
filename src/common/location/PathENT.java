package common.location;

public class PathENT {
	LocationENT departure;
	LocationENT destination;
	LocationLightENT depL;
	LocationLightENT desL;
	double distance;
	PathTypeENT pathType;
	long pathId;
	String pathRoute;
	

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

	public PathENT(LocationENT departure, LocationENT destination,
			double distance, PathTypeENT pathType) {
		super();
		this.departure = departure;
		this.destination = destination;
		this.distance = distance;
		this.pathType = pathType;
	}

	public PathENT(LocationENT departure, LocationENT destination,
			double distance, PathTypeENT pathType, long pathId) {
		super();
		this.departure = departure;
		this.destination = destination;
		this.distance = distance;
		this.pathType = pathType;
		this.pathId = pathId;
	}
	
	public PathENT(LocationLightENT departure, LocationLightENT destination,
			double distance, PathTypeENT pathType, long pathId) {
		super();
		this.depL = departure;
		this.desL = destination;
		this.distance = distance;
		this.pathType = pathType;
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
		this.pathType = pathType;
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

	public PathTypeENT getPathType() {
		return pathType;
	}

	public void setPathType(PathTypeENT pathType) {
		this.pathType = pathType;
	}

}
