package common.location;

import java.io.Serializable;
import javax.persistence.*;

import common.events.EventENT;

import java.math.BigInteger;
import java.util.List;


/**
 * The persistent class for the venue database table.
 * 
 */
@Entity
public class VenueENT implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="venue_id")
	private String venueId;

	private int capacity;

	@Column(name="creator_id")
	private BigInteger creatorUId;

	@Column(name="location_id")
	private BigInteger locationId;

	private String title;

	//bi-directional many-to-one association to Event
	@OneToMany(mappedBy="venue")
	private List<EventENT> eventENTs;

	public VenueENT() {
	}

	public String getVenueId() {
		return this.venueId;
	}

	public void setVenueId(String venueId) {
		this.venueId = venueId;
	}

	public int getCapacity() {
		return this.capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public BigInteger getCreatorUId() {
		return this.creatorUId;
	}

	public void setCreatorUId(BigInteger creatorUId) {
		this.creatorUId = creatorUId;
	}

	public BigInteger getLocationId() {
		return this.locationId;
	}

	public void setLocationId(BigInteger locationId) {
		this.locationId = locationId;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<EventENT> getEventENTs() {
		return this.eventENTs;
	}

	public void setEventENTs(List<EventENT> events) {
		this.eventENTs = events;
	}

	public EventENT addEvent(EventENT event) {
		getEventENTs().add(event);
		event.setVenue(this);

		return event;
	}

	public EventENT removeEvent(EventENT event) {
		getEventENTs().remove(event);
		event.setVenue(null);

		return event;
	}

}