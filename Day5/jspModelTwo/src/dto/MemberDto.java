package dto;

import java.io.Serializable;

// 회원가입한 회원의 정보들을 DB에서 데이터를 얻어 데이터 교환을 하기 위한 객체 DTO, DAO에서 데이터를 주고받고 할 때 쓰이는 객체.

public class MemberDto implements Serializable{ // Serializable -> 직렬화 (순서대로 정렬)
	/* 직렬화를 하는 이유: 서버가 다중화 되어있고 세션 클러스터링을 통해 세션관리를 하는 환경에서 도메인 객체가 세션에 저장이 될 때
	도메인 객체에 Serializable 인터페이스 클래스를 구현(implements)해야 정상적으로 세션에 저장하고 꺼내올 수 있기 때문이다. */
	
	private String id;
	private String pwd;
	private String name;
	private String email;
	private int auth;  // 사용자와 관리자를 구분하는 용도의 번호 ex) 사용자:3 관리자:1
	
	public MemberDto() {
		
	}

	public MemberDto(String id, String pwd, String name, String email, int auth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.auth = auth;
	}



	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}



	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", auth=" + auth + "]";
	}
	
	
	

}
