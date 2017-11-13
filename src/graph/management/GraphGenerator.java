package graph.management;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import org.jgrapht.UndirectedGraph;
import org.jgrapht.graph.DefaultWeightedEdge;

import hibernate.location.LocationDAO;

public class GraphGenerator {

	public void generateGraph(String clientName, int areaId, int pathTypeId) {
		UndirectedGraph<Long, DefaultWeightedEdge> graph = LocationDAO
				.createGraph(1, clientName);
		FileOutputStream fout;
		try {
			fout = new FileOutputStream("c:\\theFirstCompassGraphFiles\\"
					+ clientName + "-" + areaId + "-" + pathTypeId + ".ser");
			ObjectOutputStream oos = new ObjectOutputStream(fout);
			oos.writeObject(graph);
			oos.close();
			fout.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public UndirectedGraph<Long, DefaultWeightedEdge> fetchGraph(
			String clientName, int areaId, int pathTypeId) {
		// LocationDAO.createGraph(1);
		FileInputStream fileIn;
		UndirectedGraph<Long, DefaultWeightedEdge> obj = null;
		try {
			String fileLocation = "c:\\theFirstCompassGraphFiles\\"
					+ clientName + "-" + areaId + "-" + pathTypeId + ".ser";
			File f = new File(fileLocation);
			if (!f.exists()) {
				f.createNewFile();
				generateGraph(clientName, areaId, pathTypeId);
			}
			fileIn = new FileInputStream(fileLocation);

			ObjectInputStream objectIn = new ObjectInputStream(fileIn);
			obj = (UndirectedGraph<Long, DefaultWeightedEdge>) objectIn
					.readObject();
			objectIn.close();
			objectIn.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return obj;
	}

}
