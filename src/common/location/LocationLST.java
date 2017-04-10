package common.location;

import java.util.ArrayList;

public class LocationLST {
	ArrayList<LocationENT> groupENTs = new ArrayList<LocationENT>();
	LocationENT searchLocation = new LocationENT();
	private int currentPage = 0;
	private int totalPages;
	private int pageSize = 10;
	private int totalItems;
	private int first;
	private boolean ascending = true;
	private Boolean isDescending;
	private String sortedByField = "groupName";

	public boolean isAscending() {
		return ascending;
	}

	public void setAscending(boolean ascending) {
		this.ascending = ascending;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
		calcPagingParameters();
	}

	public int getTotalItems() {
		return totalItems;
	}

	public void setTotalItems(int totalItems) {
		this.totalItems = totalItems;
		calcPagingParameters();
	}

	public void setProperties(int totalItems, int currentPage, int pageSize) {
		this.totalItems = totalItems;
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		calcPagingParameters();
	}

	private void calcPagingParameters() {
		try {
			int totalPage = getTotalItems() / getPageSize();
			if (getTotalItems() % getPageSize() != 0)
				totalPage++;
			setTotalPages(totalPage);
			if (getCurrentPage() <= 0 || getCurrentPage() > totalPage) {
				setCurrentPage(1);
			}
			setFirst((getCurrentPage() - 1) * getPageSize());
		} catch (Exception ex) {

		}
	}

	public Boolean getIsDescending() {
		return isDescending;
	}

	public void setIsDescending(Boolean isDescending) {
		this.isDescending = isDescending;
	}

	public String getSortedByField() {
		return sortedByField;
	}

	public void setSortedByField(String sortedByField) {
		this.sortedByField = sortedByField;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getFirst() {
		return first;
	}

	public void setFirst(int first) {
		this.first = first;
	}

	public ArrayList<LocationENT> getGroupENTs() {
		return groupENTs;
	}

	public void setGroupENTs(ArrayList<LocationENT> groupENTs) {
		this.groupENTs = groupENTs;
	}

	public LocationENT getSearchLocation() {
		return searchLocation;
	}

	public void setSearchLocation(LocationENT searchLocation) {
		this.searchLocation = searchLocation;
	}

}
