package tools.algorithms.pathFinding;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.PriorityQueue;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DijkstraAlgo {

	// comparator function to compare PathAndLengthEntry
	public static class comparePathAndLengthEntry implements
			Comparator<PathAndLengthEntry> {

		public int compare(PathAndLengthEntry arg0, PathAndLengthEntry arg1) {
			// TODO Auto-generated method stub
			if (arg0 == arg1)
				return 0;
			else if (arg0.distance > arg1.distance)
				return 1;
			else
				return -1;
		}

	}

	public static void main(String args[]) throws IOException {
		for (int i = 1; i <= 200; i++) {
			g.addNode(g, i);
		}
		int nodeId = 1;
		int vertex = 30;
		int weight = 67;
		UndirectedGraphWithWeight.NodeClass node = g.getNodeMap().get(nodeId);
		UndirectedGraphWithWeight.EdgeContents edgeOfTheNode = new UndirectedGraphWithWeight.EdgeContents(
				vertex, weight);
		node.edges.add(edgeOfTheNode);
		System.out.println();
	}

	/**
	 * @param NodeClass
	 *            starting node
	 * @return shortest PathAndLengthEntry This method computes shortest path
	 *         between 2 nodes
	 */
	private static PathAndLengthEntry DijkstraShortestPath(
			UndirectedGraphWithWeight.NodeClass start,
			UndirectedGraphWithWeight.NodeClass finish) {

		ArrayList<PathAndLengthEntry> arrayOfPathAndDistanceOfPath = new ArrayList<PathAndLengthEntry>();
		PathAndLengthEntry newEntry = new PathAndLengthEntry();
		newEntry.path.add(start);
		arrayOfPathAndDistanceOfPath.add(newEntry);
		nodeVisitedlist.add(start);

		while (!nodeVisitedlist.contains(finish)) {
			PathAndLengthEntry minEntry = selectMinimumEdge(arrayOfPathAndDistanceOfPath);
			arrayOfPathAndDistanceOfPath.add(minEntry);
			nodeVisitedlist.add(minEntry.path.get(minEntry.path.size() - 1));
		}

		// return the shortest path and distance
		return arrayOfPathAndDistanceOfPath.get(arrayOfPathAndDistanceOfPath
				.size() - 1);

	}

	/**
	 * Selects the minimum edge,stores the PathAndLengthEntry in a priority
	 * queue thus the first element in the priority queue is shortest element
	 */
	private static PathAndLengthEntry selectMinimumEdge(
			ArrayList<PathAndLengthEntry> arrayOfPathAndLengthEntry) {

		Comparator<PathAndLengthEntry> comparator = new comparePathAndLengthEntry();
		PriorityQueue<PathAndLengthEntry> pqOfPath = new PriorityQueue<PathAndLengthEntry>(
				10, comparator);// priority queue of path and length entry

		for (PathAndLengthEntry currentEntry : arrayOfPathAndLengthEntry)
			for (UndirectedGraphWithWeight.EdgeContents edge : currentEntry.path
					.get(currentEntry.path.size() - 1).edges) {
				UndirectedGraphWithWeight.NodeClass nodeOfTheCurrentEdge = g
						.getNodeMap().get(edge.name);
				if (!nodeVisitedlist.contains(nodeOfTheCurrentEdge)) {
					PathAndLengthEntry newEntry = new PathAndLengthEntry(
							currentEntry);
					newEntry.path.add(nodeOfTheCurrentEdge);
					newEntry.distance += edge.weight;
					pqOfPath.add(newEntry);
				}
			}

		return pqOfPath.remove();
	}

	/** class contains the shortest path, distance */
	static class PathAndLengthEntry {

		// constructor initializes path and length entry
		public PathAndLengthEntry() {
			this.path = new ArrayList<UndirectedGraphWithWeight.NodeClass>();
			this.distance = 0;

		}

		// copy constructor
		public PathAndLengthEntry(PathAndLengthEntry anotherEntry) {

			this.path = cloneArrayList(anotherEntry.path);
			this.distance = anotherEntry.distance;
		}

		// method to copy arrayList Collection
		private static ArrayList<UndirectedGraphWithWeight.NodeClass> cloneArrayList(
				ArrayList<UndirectedGraphWithWeight.NodeClass> oldArrayList) {
			ArrayList<UndirectedGraphWithWeight.NodeClass> clonedList = new ArrayList<UndirectedGraphWithWeight.NodeClass>(
					oldArrayList.size());
			for (UndirectedGraphWithWeight.NodeClass node : oldArrayList) {
				clonedList.add(new UndirectedGraphWithWeight.NodeClass(node));
			}
			return clonedList;
		}

		private ArrayList<UndirectedGraphWithWeight.NodeClass> getPath() {
			return path;
		}

		// instance variables
		ArrayList<UndirectedGraphWithWeight.NodeClass> path; // stores path
		int distance;// stores distance

	}

	private static UndirectedGraphWithWeight g = new UndirectedGraphWithWeight();
	private static ArrayList<UndirectedGraphWithWeight.NodeClass> nodeVisitedlist = new ArrayList<UndirectedGraphWithWeight.NodeClass>();
	// private static hashset<nodeclass> allgraphnodeslist = g.getallnodes();

}