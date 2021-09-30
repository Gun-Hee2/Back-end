package dto;

import java.util.Arrays;

public class HumanDto {
	private String name;
	private String age;
	private String gender;
	private String hobby[];

	public HumanDto() {
		
	}

	public HumanDto(String name, String age, String gender, String hobby[]) {
		super();
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.hobby = hobby;
	}

	@Override
	public String toString() {
		return "HumanDto [name=" + name + ", age=" + age + ", gender=" + gender + ", hobby="
				+ Arrays.toString(hobby) + "]";
	}
}
