package common.events;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the calendar_date database table.
 * 
 */
@Entity
@Table(name="calendar_date")
public class CalendarDate implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="date_id")
	private int dateId;

	@Column(name="day_date")
	private String dayDate;

	//bi-directional many-to-one association to Event
	@OneToMany(mappedBy="calendarDate")
	private List<EventENT> events;

	public CalendarDate() {
	}

	public int getDateId() {
		return this.dateId;
	}

	public void setDateId(int dateId) {
		this.dateId = dateId;
	}

	public String getDayDate() {
		return this.dayDate;
	}

	public void setDayDate(String dayDate) {
		this.dayDate = dayDate;
	}

	public List<EventENT> getEvents() {
		return this.events;
	}

	public void setEvents(List<EventENT> events) {
		this.events = events;
	}

	public EventENT addEventENT(EventENT event) {
		getEvents().add(event);
		event.setCalendarDate(this);

		return event;
	}

	public EventENT removeEventENT(EventENT event) {
		getEvents().remove(event);
		event.setCalendarDate(null);

		return event;
	}

}