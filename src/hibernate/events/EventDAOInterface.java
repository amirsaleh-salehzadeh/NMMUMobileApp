package hibernate.events;

import java.util.ArrayList;

import common.TreeViewENT;
import common.events.EventENT;
import tools.AMSException;


public interface EventDAOInterface {
	public void deleteEvent(EventENT ent) throws AMSException;
	public EventENT createUpdateEvent(EventENT ent) throws AMSException;
	public boolean getAllEvents(EventENT ent) throws AMSException;
	public ArrayList<TreeViewENT> getEventCategories();
	
	//activate user
}
