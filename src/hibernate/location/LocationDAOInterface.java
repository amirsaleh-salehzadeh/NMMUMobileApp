package hibernate.location;

import java.util.ArrayList;

import common.DropDownENT;
import common.location.LocationENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import tools.AMSException;

public interface LocationDAOInterface {
	public LocationENT saveUpdateLocation(LocationENT ent) throws AMSException;

	public ArrayList<PathENT> getAllPathsForOnePoint(long locationId, int type);

	public LocationLST searchForLocations(LocationLST lst) throws AMSException;

	public LocationENT getLocationENT(LocationENT ent);

	public ArrayList<LocationENT> getAllLocationsForUser(String username, String locationTypeIds, String parentLocationIds);

	public boolean deleteLocation(LocationENT ent) throws AMSException;

	public boolean deletePath(PathENT ent) throws AMSException;

	public ArrayList<DropDownENT> getAllCountrirs();

	public ArrayList<PathTypeENT> getAllPathTypes();

	public LocationTypeENT getAllLocationTypeChildren(LocationTypeENT parent);

	public ArrayList<PathENT> getAllPaths(String username);

	public PathENT savePath(PathENT path);

	public LocationENT findClosestLocation(String GPSCoordinates, String locationTypeIds, String parentIds, String clientName);

	public PathENT getAPath(PathENT ent);

	public long saveTrip(long deptLocationId, long destLocationId);

	public ArrayList<PathENT> getShortestPath(long dep, long dest,
			int pathTypeId, String clientName, int areaId);

	public void deleteTrip(long tripId);

	public PathENT getTrip(long tripId);

	public String getQRCodeForLocationENT(long locationId);
	
	public LocationLST getParentLocationsOfaType(int locationTypeId);
	
	public LocationENT getLocationENTAncestors(long locationId);
	
	public LocationENT getLocationWithChildren(LocationENT parent);
	
	
}
