package threads;

import hibernate.location.LocationDAO;

import org.jgrapht.UndirectedGraph;
import org.jgrapht.graph.DefaultWeightedEdge;

public class GraphMapThread implements Runnable {
	public static volatile boolean killer;
	public static UndirectedGraph<Long, DefaultWeightedEdge> graphDirt;
	public static UndirectedGraph<Long, DefaultWeightedEdge> graphWalkaway;

	public GraphMapThread() {
		graphDirt	= LocationDAO.createGraph(1);
		graphWalkaway	= LocationDAO.createGraph(2);
	}

	public void run() {
		Thread a = new Thread();
		a.setName("GraphMapThread");
		while (killer && !Thread.currentThread().isInterrupted()) {
			try {
				a.sleep(10000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

	}

}
