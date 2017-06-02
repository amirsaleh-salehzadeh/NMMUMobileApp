package tools.algorithms.pathFinding;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class UndirectedGraphWithWeight {
	
	public static class NodeClass{
		 
		 int  id; // node id
		 HashSet<EdgeContents> edges; // set of edges
		  
		 public NodeClass(int name){
			 id = name;
			 edges = new HashSet<EdgeContents>();
		 }	
		 
		 // method to copy the set of edges
		 private static HashSet<EdgeContents> cloneSet(HashSet<EdgeContents> oldSet){
			 HashSet<EdgeContents> clonedSet = new HashSet<EdgeContents>(oldSet.size());
			 for (EdgeContents edge : oldSet){
				 clonedSet.add(new EdgeContents(edge));
			 }
			 return clonedSet;
		 }
		 
		 // copy constructor
		 public NodeClass(NodeClass anotherNode){
			 this.id = anotherNode.id;
			 this.edges = cloneSet(anotherNode.edges);
		 }
		 
		 public HashSet<EdgeContents> getEdges(){
			 
			 return edges;
		 }
	}
	
	
	// edge contains name aka id, weight
	public static class EdgeContents{
		int name;
		int weight;
		
		public EdgeContents (int name,int weight){
			
			this.name = name;
			this.weight = weight;
			
		}
		
		// copy constructor
		public EdgeContents(EdgeContents anotherEdge){
			this.name = anotherEdge.name;
			this.weight = anotherEdge.weight;
		}
	} 
	
	
	 void addNode(UndirectedGraphWithWeight g,int nodeId){
		NodeClass nodeToAdd = new NodeClass(nodeId);
		g.nodes.add(nodeToAdd);
		g.nodeMap.put(nodeId, nodeToAdd);
	}
	
	
	HashSet<NodeClass> getAllNodes(){
		return nodes;
	}
	
	public HashMap<Integer, NodeClass> getNodeMap(){
		return nodeMap;
	}
	
	public void addEdgeInSet(EdgeContents edge){
		setOfEdges.add(edge);
	}
	
	private HashSet<NodeClass> nodes = new HashSet<NodeClass>();
	private HashMap<Integer, NodeClass> nodeMap = new HashMap<Integer, NodeClass>();
	private HashSet<EdgeContents> setOfEdges = new HashSet<EdgeContents>();
	
	
}