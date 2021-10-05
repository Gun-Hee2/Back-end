package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

// 실제로 회원 DB(member.sql)에 접근하는 객체 DAO

public class MemberDao {
    // singleton패턴
	// single변수는 static메서드에서 사용해야 하기 때문에 static 변수로 설정해야 한다.
	private static MemberDao dao = null;
	// 외부에서 객체 생성x
	private MemberDao() { 
		DBConnection.initConnection();
	}
	
	public static MemberDao getInstance() { // 외부에서는 getInstance()를 통해서만 객체 생성 가능.
		if(dao == null) {
			dao = new MemberDao();
		}
		return dao;
	}
	
	public boolean addMember(MemberDto dto) { // 하나의 행을 각 컬럼대로 뽑는것은 번거롭고 힘들기 때문에 MemberDto객체를 이용해 하나의 데이터를 객체화.
		
		String sql = " INSERT INTO MEMBER(ID, PWD, NAME, EMAIL, AUTH) "
				+ "    VALUES(?, ?, ?, ?, 3) "; // 객체 sql에 쿼리문을 넣는다.
		
		Connection conn = null; // DB에 연결하는 객체
		PreparedStatement psmt = null; // SQL쿼리문을 전송하는 객체
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection(); // DBConnection.java의 DBConnection클래스의 getConnection메소드, DB와 연결하는 메소드이다.
			System.out.println("1/3 addMember success");
			
			psmt = conn.prepareStatement(sql); //  DB에 연결하는 객체인 conn에 객체 sql에 담긴 쿼리문을 할당하고 SQL구문을 DB로 가져간다.
			psmt.setString(1, dto.getId()); // 객체 sql에 담긴 쿼리문의 VALUES값에 해당되는 ?에 순서대로 해당값을 dto객체에 담는다.
			psmt.setString(2, dto.getPwd()); 
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());			
			System.out.println("2/3 addMember success");
			
			count = psmt.executeUpdate(); // DB로 가져간 쿼리문을 실행한다. INSERT쿼리 실행 완료. 객체 count는 쿼리문이 정상적으로 실행되면 true값을, 실패하면 false값을 갖는다.
			System.out.println("3/3 addMember success");
			
		} catch (SQLException e) {			
			e.printStackTrace();
			System.out.println("addMember fail"); // DB연결 및 쿼리문 실행 실패 했을 때 출력
		} finally {
			DBClose.close(conn, psmt, null); // DB연결 해제하는 DBClose.java의 DBClose클래스의 close메소드 실행.
		}
		
		return count>0?true:false; // count가 실행되면 1이므로 0보다 크기 때문에 true값를 리턴, 실행되지 않으면 0이므로 false값을 리턴.
	}
	
	public boolean getId(String id) {
		
		String sql = " SELECT COUNT(*) "
				+ "	   FROM MEMBER "
				+ "    WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null; // 쿼리문을 실행하고 조회한 데이터값을 저장하는 객체 rs
		
		int findId = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			System.out.println("2/3 getId success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getId success");
			
			if(rs.next()) { // 간단하게 "DB에서 실행한 쿼리문에 대한 데이터값인 rs의 값(쿼리문 결과)이 있다면"이라는 의미이다. 
				findId = rs.getInt(1); // 데이터값 rs에 대하여 첫번째 결과값을 int형으로 findId에 넣는다.
				System.out.println(rs.getInt(1));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getId fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return findId>0?true:false;
	}
	
	public MemberDto login(String id, String pwd) { // return값이 MemberDto값인 login메소드, 대입되는 id와 pwd값은 loginAf.jsp에서의 입력값
		String sql = " SELECT ID, NAME, EMAIL, AUTH "
				+ "	   FROM MEMBER "
				+ "    WHERE ID=? AND PWD=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto mem = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("2/3 getId success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getId success");
			
			if(rs.next()) {
				String _id = rs.getString(1); // SELECT쿼리문의 결과값중 첫번째 결과값인 ID의 값을 객체 _id에 넣는다.
				String name = rs.getString(2);
				String email = rs.getString(3);
				int auth = rs.getInt(4);
				
				mem = new MemberDto(_id, null, name, email, auth); // 객체 mem은 MemberDto에 조회한 값들을 넣어서 만든 Dto값
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("login fail");
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return mem;
	}
	
	
}








