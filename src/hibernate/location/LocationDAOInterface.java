package hibernate.location;

import java.util.ArrayList;

import common.DropDownENT;
import common.location.LocationENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import common.user.UserENT;
import common.user.UserLST;
import tools.AMSException;


public interface LocationDAOInterface {
	public LocationENT saveUpdateLocation(LocationENT ent) throws AMSException;
	public LocationLST getLocationLST(LocationLST lst) throws AMSException;
	public LocationENT getLocationENT(LocationENT ent);
	public ArrayList<LocationENT> getAllLocationsForUser(String username) throws AMSException;
	public boolean deleteLocation(LocationENT ent) throws AMSException;
	public ArrayList<DropDownENT> getAllCountrirs();
	public ArrayList<PathTypeENT> getAllPathTypes();
	public ArrayList<LocationTypeENT> getAllLocationTypes();
	public ArrayList<PathENT> getAllPaths(String username);
	public ArrayList<PathENT> getShortestPath(LocationENT dep, LocationENT dest);
	public void savePath(PathENT path);
}
