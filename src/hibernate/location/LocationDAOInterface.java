package hibernate.location;

import java.util.ArrayList;
import java.sql.Connection;

import common.DropDownENT;
import common.location.EntranceIntersectionENT;
import common.location.LevelENT;
import common.location.LocationENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import tools.AMSException;

public interface LocationDAOInterface {
	public LocationENT saveUpdateLocation(LocationENT ent, Connection conn)
			throws AMSException;

	public ArrayList<PathENT> getAllPathsForOnePoint(long locationId, int type);

	public LocationENT getLocationENT(LocationENT ent, Connection conn);

	public ArrayList<LocationENT> getAllLocationsForUser(String username,
			String locationTypeIds, String parentLocationIds);

	public boolean deleteLocation(LocationENT ent) throws AMSException;

	public ArrayList<DropDownENT> getAllCountrirs();

	public ArrayList<PathTypeENT> getAllPathTypes();

	public LocationTypeENT getAllLocationTypeChildren(LocationTypeENT parent);

	public LocationENT findClosestLocation(String GPSCoordinates,
			String locationTypeIds, String parentIds, String clientName);

	public long saveTrip(long deptLocationId, long destLocationId);

	public void deleteTrip(long tripId);

	public PathENT getTrip(long tripId);

	public String getQRCodeForLocationENT(long locationId);

	public LocationLST getParentLocationsOfaType(int locationTypeId);

	public LocationENT getLocationENTAncestors(long locationId);

	public LocationENT getLocationWithChildren(LocationENT parent);

	public LevelENT saveLevel(LevelENT level, Connection conn);

	public ArrayList<EntranceIntersectionENT> getEntrancesForALocation(LocationENT parent,
			Connection conn);
	
	public LocationENT getEntranceLocation(EntranceIntersectionENT ent,
			Connection conn);
	
	public EntranceIntersectionENT getEntranceIntersectionENT(long entranceIntersectionId,
			Connection conn);

	public boolean deleteEntrance(EntranceIntersectionENT entrance, Connection conn)
			throws AMSException;

	public EntranceIntersectionENT saveEntrance(EntranceIntersectionENT entrance, Connection conn);

	public ArrayList<LevelENT> getLevelsForALocation(LocationENT parent,
			Connection conn);

	public boolean deleteLevel(LevelENT level, Connection conn)
			throws AMSException;

}
