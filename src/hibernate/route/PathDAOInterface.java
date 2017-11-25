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

	public ArrayList<PathTypeENT> getRoutesForUserAndParent(
			ArrayList<PathTypeENT> pathTypeENTs, Connection conn);

	public PathENT savePath(PathENT path);
	
}
