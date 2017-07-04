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
	public LocationENT getLocation(LocationENT location) throws AMSException;
	
	public LocationENT saveUpdateLocation(LocationENT ent) throws AMSException;

	public ArrayList<PathENT> getAllPathsForOnePoint(long locationId, int type);

	public LocationLST getLocationLST(LocationLST lst) throws AMSException;

	public LocationENT getLocationENT(LocationENT ent);

	public ArrayList<LocationENT> getAllLocationsForUser(String username, int locationTypeId, long parentLocationId);

	public boolean deleteLocation(LocationENT ent) throws AMSException;

	public boolean deletePath(PathENT ent) throws AMSException;

	public ArrayList<DropDownENT> getAllCountrirs();

	public ArrayList<PathTypeENT> getAllPathTypes();

	public LocationTypeENT getAllLocationTypeChildren(LocationTypeENT parent);

	public ArrayList<PathENT> getAllPaths(String username);

	public void savePath(PathENT path);

	public LocationENT findClosestLocation(String GPSCoordinates);

	public PathENT getAPath(PathENT ent);

	public ArrayList<PathENT> getAPathFromTo(String fromCoordinate,
			String toCoordinate, int pathTypeId);

	public long saveTrip(long deptLocationId, long destLocationId);

	public ArrayList<PathENT> getShortestPath(long dep, long dest,
			int pathTypeId);

	public void deleteTrip(long tripId);

	public PathENT getTrip(long tripId);

	public String getQRCodeForLocationENT(long locationId);
	
	public LocationLST getParentLocationsOfaType(int locationTypeId);
	
	
}
