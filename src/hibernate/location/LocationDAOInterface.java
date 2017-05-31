package hibernate.location;

import java.util.ArrayList;

import common.DropDownENT;
import common.location.LocationENT;
import common.location.LocationLST;
import common.user.UserENT;
import common.user.UserLST;
import tools.AMSException;


public interface LocationDAOInterface {
	public LocationENT saveUpdateLocation(LocationENT ent) throws AMSException;
	public LocationLST getLocationLST(LocationLST lst) throws AMSException;
	public LocationENT getLocationENT(LocationENT ent) throws AMSException;
	public boolean deleteLocation(LocationENT ent) throws AMSException;
	public ArrayList<DropDownENT> getAllCountrirs();
	
	//activate user
}
