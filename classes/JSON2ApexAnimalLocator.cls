public class JSON2ApexAnimalLocator {


	public class Animal {
		public Integer id;
		public String name;
		public String eats;
		public String says;
	}
public Animal animal;	
	
	public static JSON2ApexAnimalLocator parse(String json) {
		return (JSON2ApexAnimalLocator) System.JSON.deserialize(json, JSON2ApexAnimalLocator.class);
	}
}