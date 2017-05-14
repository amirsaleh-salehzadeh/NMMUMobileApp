package common.events;

import java.io.Serializable;
import javax.persistence.*;

import common.hashtag.EventsHashTag;
import common.location.VenueENT;

import java.math.BigInteger;
import java.util.List;


/**
 * The persistent class for the events database table.
 * 
 */
@Entity
@Table(name="events")
public class EventENT implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="event_id")
	private String eventId;

	@Column(name="creator_id")
	private BigInteger creatorUId;

	@Lob
	private String description;

	@Column(name="end_time")
	private String endTime;

	@Column(name="event_title")
	private String eventTitle;

	@Column(name="price")
	private int price;

	@Column(name="status")
	private int status;
	
	@Column(name="active")
	private boolean active;

	public BigInteger getCreatorUId() {
		return creatorUId;
	}

	public void setCreatorUId(BigInteger creatorUId) {
		this.creatorUId = creatorUId;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	//bi-directional many-to-one association to CalendarDate
	@ManyToOne
	@JoinColumn(name="start_time")
	private CalendarDate calendarDate;

	//bi-directional many-to-many association to EventsCategory
	@ManyToMany
	@JoinTable(
		name="events_categories"
		, joinColumns={
			@JoinColumn(name="event_id")
			}
		, inverseJoinColumns={
			@JoinColumn(name="category_id")
			}
		)
	private List<EventsCategory> eventsCategories;

	//bi-directional many-to-one association to Venue
	@ManyToOne
	@JoinColumn(name="venue_id")
	private VenueENT venue;

	//bi-directional many-to-one association to EventsAttendance
	@OneToMany(mappedBy="event")
	private List<EventsAttendance> eventsAttendances;

	//bi-directional many-to-one association to EventsHashTag
	@OneToMany(mappedBy="event")
	private List<EventsHashTag> eventsHashTags;

	public EventENT() {
	}

	public String getEventId() {
		return this.eventId;
	}

	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getEventTitle() {
		return this.eventTitle;
	}

	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}

	public int getPrice() {
		return this.price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public CalendarDate getCalendarDate() {
		return this.calendarDate;
	}

	public void setCalendarDate(CalendarDate calendarDate) {
		this.calendarDate = calendarDate;
	}

	public List<EventsCategory> getEventsCategories() {
		return this.eventsCategories;
	}

	public void setEventsCategories(List<EventsCategory> eventsCategories) {
		this.eventsCategories = eventsCategories;
	}

	public VenueENT getVenue() {
		return this.venue;
	}

	public void setVenue(VenueENT venue) {
		this.venue = venue;
	}

	public List<EventsAttendance> getEventsAttendances() {
		return this.eventsAttendances;
	}

	public void setEventsAttendances(List<EventsAttendance> eventsAttendances) {
		this.eventsAttendances = eventsAttendances;
	}

	public EventsAttendance addEventsAttendance(EventsAttendance eventsAttendance) {
		getEventsAttendances().add(eventsAttendance);
		eventsAttendance.setEventENT(this);

		return eventsAttendance;
	}

	public EventsAttendance removeEventsAttendance(EventsAttendance eventsAttendance) {
		getEventsAttendances().remove(eventsAttendance);
		eventsAttendance.setEventENT(null);

		return eventsAttendance;
	}

	public List<EventsHashTag> getEventsHashTags() {
		return this.eventsHashTags;
	}

	public void setEventsHashTags(List<EventsHashTag> eventsHashTags) {
		this.eventsHashTags = eventsHashTags;
	}

	public EventsHashTag addEventsHashTag(EventsHashTag eventsHashTag) {
		getEventsHashTags().add(eventsHashTag);
		eventsHashTag.setEventENT(this);

		return eventsHashTag;
	}

	public EventsHashTag removeEventsHashTag(EventsHashTag eventsHashTag) {
		getEventsHashTags().remove(eventsHashTag);
		eventsHashTag.setEventENT(null);

		return eventsHashTag;
	}

}