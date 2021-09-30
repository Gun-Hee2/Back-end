package dto;

import java.util.Arrays;

public class Humandto {
	private String id;
	private String pw;
	private String hobby[];
	private String age;
	private String word;
	
	public Humandto(String id, String pw, String[] hobby, String age, String word) {
		this.id = id;
		this.pw = pw;
		this.hobby = hobby;
		this.age = age;
		this.word = word;
	}

	@Override
	public String toString() {
		return "Humandto [id=" + id + ", pw=" + pw + ", hobby=" + Arrays.toString(hobby) + ", age=" + age + ", word="
				+ word + "]";
	}
	
}
