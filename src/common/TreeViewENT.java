package common;

import java.util.List;

public class TreeViewENT {
	TreeViewENT pranet;
	String value;
	String text;
	String onClick;
	List<TreeViewENT> children;

	public TreeViewENT(TreeViewENT pranet, String value, String text,
			String onClick, List<TreeViewENT> children) {
		super();
		this.pranet = pranet;
		this.value = value;
		this.text = text;
		this.onClick = onClick;
		this.children = children;
	}

	public TreeViewENT getPranet() {
		return pranet;
	}

	public void setPranet(TreeViewENT pranet) {
		this.pranet = pranet;
	}

	public List<TreeViewENT> getChildren() {
		return children;
	}

	public void setChildren(List<TreeViewENT> children) {
		this.children = children;
	}

	public TreeViewENT(String value, String text, String onClick) {
		super();
		this.value = value;
		this.text = text;
		this.onClick = onClick;
	}

	public String getOnClick() {
		return onClick;
	}

	public void setOnClick(String onClick) {
		this.onClick = onClick;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

}
