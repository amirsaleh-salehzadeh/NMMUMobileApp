package hibernate.config;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import tools.AMSException;


public class BaseHibernateDAO {
	public static final int AMSEX_UNKNOWN = AMSException.AMSEX_UNKNOWN;
	public static final int AMSEX_DELETE = AMSException.AMSEX_DELETE;
	public static final int AMSEX_SAVE = AMSException.AMSEX_SAVE;
	public static final int AMSEX_SAVE_DUPLICATE = AMSException.AMSEX_SAVE_DUPLICATE;
	public Session getSession(){
		SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
		return sessionFactory.openSession();
	}
	public Session getSession4Query(){
		return HibernateSessionFactory.getSession();
	}
	public Session getSession2Save(){
		SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
		return sessionFactory.getCurrentSession();
	}
	public AMSException getAMSException(int operationType, Exception ex) {
		String msg = ex.getMessage();
		switch (operationType) {
		case AMSEX_DELETE:
			msg = "A problem occured while deleting";
			break;
		case AMSEX_SAVE:
			msg = "A problem occured while saving";
			break;
		case AMSEX_SAVE_DUPLICATE:
			msg = "The record has been currently saved";
			
		}
		AMSException e = getAMSException(msg, ex);
		e.setType(operationType);
		return e;

	}
	public AMSException getAMSException(String defaultMessage, Exception ex) {
		getSession().close();

		if (ex == null) {
			return new AMSException(defaultMessage);
		}

		ex.printStackTrace();
		// else if(ex.getMessage().startsWith(""){}
		return new AMSException(defaultMessage, ex);
	}
}
