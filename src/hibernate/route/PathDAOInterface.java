package hibernate.route;

import java.util.ArrayList;

import common.DropDownENT;
import common.location.LocationENT;
import common.location.LocationLST;
import common.location.LocationTypeENT;
import common.location.PathENT;
import common.location.PathTypeENT;
import tools.AMSException;
import java.sql.Connection;

public interface PathDAOInterface {

	public ArrayList<PathENT> getRoutesForUserAndParent(String username,
			long parentId);

 	public PathENT savePath(PathENT path, Connection conn);

	public boolean deletePath(PathENT ent, Connection conn) throws AMSException;

	public PathENT getAPath(PathENT ent);

	public ArrayList<PathENT> getShortestPath(long dep, long dest,
			int pathTypeId, String clientName, int areaId);
	
	public ArrayList<PathENT> createAPointOnPath(long pathId, String pointGPS, int index);
}
