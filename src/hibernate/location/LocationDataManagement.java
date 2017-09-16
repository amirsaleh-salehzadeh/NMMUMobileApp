package hibernate.location;

import java.text.DecimalFormat;
import java.util.ArrayList;

import tools.AMSException;

import common.location.LocationENT;

public class LocationDataManagement {

	private static void updateAllDescriptions() {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> all = dao.getAllLocationsForUser("NMMU", "3,5",
				null);
		for (int i = 0; i < all.size(); i++) {
			LocationENT ent = all.get(i);
			String res = "";

			// UPDATE DESCRIPTION

			String descString = ent.getDescription();
			System.out.println(descString);
			if (descString != null) {
				String[] tmpSentence = descString.split(" ");
				for (int j = 0; j < tmpSentence.length; j++) {
					if (tmpSentence[j].length() <= 1)
						continue;
					tmpSentence[j] = tmpSentence[j].toLowerCase();
					// .toUpperCase()
					if (j < tmpSentence.length)
						res += tmpSentence[j].substring(0, 1).toUpperCase()
								+ tmpSentence[j].substring(1) + " ";
				}
			}

			System.out.println(res);
			// ent.setDescription(res);
			ent.setGps(res);
			if (res.length() <= 1)
				ent.setDescription(null);
			if (ent.getIcon() != null && ent.getIcon().length() < 5)
				ent.setIcon(null);
			try {
				dao.saveUpdateLocation(ent);
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private static void updateAllGPS() {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> all = dao.getAllLocationsForUser("NMMU", "3,5",
				null);
		for (int i = 0; i < all.size(); i++) {
			LocationENT ent = all.get(i);
			String res = "";

			// UPDATE GPS
			String descString = ent.getGps();
			System.out.println(descString);
			if (descString != null) {
				String[] tmpSentence = descString.split(",");
				// for (int j = 0; j < tmpSentence.length; j++) {
				double x = Double.parseDouble(tmpSentence[0]);
				double y = (double) Double.parseDouble(new DecimalFormat(
						".#######").format(x));
				res += y;
				x = Double.parseDouble(tmpSentence[1]);
				y = (double) Double.parseDouble(new DecimalFormat(".#######")
						.format(x));
				res += "," + y;
				// }
			}
			System.out.println(res);
			// ent.setDescription(res);
			ent.setGps(res);
			if (res.length() <= 1)
				ent.setDescription(null);
			if (ent.getIcon() != null && ent.getIcon().length() < 5)
				ent.setIcon(null);
			try {
				dao.saveUpdateLocation(ent);
			} catch (AMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private static void updateAllGPSParents(String topLeft, String topRight, String bottomLeft, String BottomRight) {
		LocationDAO dao = new LocationDAO();
		ArrayList<LocationENT> ents = dao.getAllLocationsForUser("NMMU", "3,5",
				"360");
		for (int i = 0; i < ents.size(); i++) {
			LocationENT ent = ents.get(i);
			String[] gps = ent.getGps().split(",");
			double lat = Double.parseDouble(gps[0]);
			double lng = Double.parseDouble(gps[1]);
		}
	}

	public static void main(String[] args) {
		updateAllDescriptions();
	}
}
