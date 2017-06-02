package tools.algorithms.pathFinding;

public class Vertex implements Comparable<Vertex> {
	public final long name;
	public Edge[] adjacencies;
	public double minDistance = Double.POSITIVE_INFINITY;
	public Vertex previous;

	public Vertex(long argName) {
		name = argName;
	}

	public long getVertex() {
		return name;
	}

	public int compareTo(Vertex other) {
		return Double.compare(minDistance, other.minDistance);
	}
}
