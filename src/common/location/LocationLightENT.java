package common.location;

// Generated Apr 11, 2017 5:12:45 PM by Hibernate Tools 3.4.0.CR1

import java.math.BigInteger;
import java.util.ArrayList;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Location generated by hbm2java
 */
public class LocationLightENT {

	public long id;
	public String t;// type
	public String n;// Name
	public String g;// gps
	public String i; //image
	public LocationLightENT p; // parent

	/**
	 * @return the i
	 */
	public String getI() {
		return i;
	}

	/**
	 * @param i the i to set
	 */
	public void setI(String i) {
		this.i = i;
	}

	public LocationLightENT(long id, String t, String n, String g,
			LocationLightENT p) {
		super();
		this.id = id;
		this.t = t;
		this.n = n;
		this.g = g;
		this.p = p;
	}
	
	public LocationLightENT(LocationENT ent) {
		super();
		this.id = ent.getEntrances().get(0).getEntranceId();
		this.t = ent.getLocationType().getLocationType();
		this.n = ent.getLocationName();
		this.g = ent.getEntrances().get(0).getGps();
		this.p = null;
	}
	
	public LocationLightENT(long id) {
		super();
		this.id = id;
	}
	
	public LocationLightENT() {
		super();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getT() {
		return t;
	}

	public void setT(String t) {
		this.t = t;
	}

	public String getN() {
		return n;
	}

	public void setN(String n) {
		this.n = n;
	}

	public String getG() {
		return g;
	}

	public void setG(String g) {
		this.g = g;
	}


	public LocationLightENT getP() {
		return p;
	}

	public void setP(LocationLightENT p) {
		this.p = p;
	}

}
