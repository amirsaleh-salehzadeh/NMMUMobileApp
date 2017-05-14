package common.events;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the events_category database table.
 * 
 */
@Entity
@Table(name="events_category")
public class EventsCategory implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="category_id")
	private int categoryId;

	private String title;

	//bi-directional many-to-many association to Event
	@ManyToMany(mappedBy="eventsCategories")
	private List<EventENT> eventENTs;

	//bi-directional many-to-one association to EventsCategory
	@ManyToOne
	@JoinColumn(name="parent_id")
	private EventsCategory eventsCategory;

	//bi-directional many-to-one association to EventsCategory
	@OneToMany(mappedBy="eventsCategory")
	private List<EventsCategory> eventsCategories;

	public EventsCategory() {
	}

	public int getCategoryId() {
		return this.categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
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

	public EventsCategory getEventsCategory() {
		return this.eventsCategory;
	}

	public void setEventsCategory(EventsCategory eventsCategory) {
		this.eventsCategory = eventsCategory;
	}

	public List<EventsCategory> getEventsCategories() {
		return this.eventsCategories;
	}

	public void setEventsCategories(List<EventsCategory> eventsCategories) {
		this.eventsCategories = eventsCategories;
	}

	public EventsCategory addEventsCategory(EventsCategory eventsCategory) {
		getEventsCategories().add(eventsCategory);
		eventsCategory.setEventsCategory(this);

		return eventsCategory;
	}

	public EventsCategory removeEventsCategory(EventsCategory eventsCategory) {
		getEventsCategories().remove(eventsCategory);
		eventsCategory.setEventsCategory(null);

		return eventsCategory;
	}

}