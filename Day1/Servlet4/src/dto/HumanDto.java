package dto;

public class HumanDto {
	private String name;
	private int number;
	
	public HumanDto() {
		
	}

	public HumanDto(String name, int number) {
		super();
		this.name = name;
		this.number = number;
	}

	@Override
	public String toString() {
		return "HumanDto [name=" + name + ", number=" + number + "]";
	}
	
	

}
