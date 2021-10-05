package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.bBsDto;

public class BbsDao {
	
	private static BbsDao dao = null;
	
	private BbsDao() {
		
	}
	
	public static BbsDao getInstance( ) {
		if(dao == null) {
			dao = new BbsDao();
		}
		return dao;
	}
	
	public List<bBsDto> getBbsList() { // bBsDto의 데이터를 List값으로 리턴하는 메소드
	      
	      String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
	            + "           TITLE, CONTENT, WDATE, "
	            + "           DEL, READCOUNT "
	            + "    FROM BBS "
	            + "    ORDER BY REF DESC, STEP ASC ";
	      
	      Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;
	      
	      List<bBsDto> list = new ArrayList<bBsDto>(); // 리턴값으로 줄 list객체를 ArrayList로 생성
	      
	      
	      
	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/4 getId success");
	         
	         psmt = conn.prepareStatement(sql);
	         System.out.println("2/4 getId success");
	         
	         rs = psmt.executeQuery();
	         System.out.println("3/4 getId success");
	         
	         while(rs.next()) { // 데이터가 여러개이기 때문에 if문이 아닌 while문이여야 한다.
	            bBsDto dto = new bBsDto(rs.getInt(1),    // SEQ
	                                  rs.getString(2), // ID
	                                  rs.getInt(3),    // REF
	                                  rs.getInt(4),    // STEP
	                                  rs.getInt(5),    // DEPTH
	                                  rs.getString(6), // TITLE
	                                  rs.getString(7), // CONTENT
	                                  rs.getString(8), // WDATE
	                                  rs.getInt(9),    // DEL
	                                  rs.getInt(10));  // READACCOUNT
	            list.add(dto); // 쿼리문의 결과값들인 dto정보을 ArrayList에 순서대로 넣는다.
	         }
	         System.out.println("4/4 getId success");
	         
	      } catch (SQLException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	         System.out.println("getBbsList fail");
	      }finally {
	         DBClose.close(conn, psmt, rs);
	      }
	      
	      return list;
	      
	}
	
    public boolean writeBbs(bBsDto dto) { // bbswriteAf.jsp에서 실행되는 메소드로 dto에는 new bBsDto(id, title, content)의 데이터값으로 넣는다.
		
		String sql = " INSERT INTO BBS "
				+ "      (SEQ, ID, "
				+ "      REF, STEP, DEPTH, "
				+ "      TITLE, CONTENT, WDATE, DEL, READCOUNT) "
				+ "    VALUES"
				+ "      (SEQ_BBS.NEXTVAL, ?, " // SEQ_BBS.NEXTVAL은 해당 시퀀스의 값을 증가시킴
				+ "		 (SELECT NVL(MAX(REF), 0)+1 FROM BBS), 0, 0, " 
		/* REF는 SEQ와 동일하게 시퀀스의 값을 증가시켜야 하지만 SEQ_BBS.NEXTVAL을 두번 사용할 수 없으므로 다음과 같이 코딩하여 동일하게 사용할 수 있다.
		   첫 시작의 REF는 글이 없을 때이므로 NULL값이며 NVL을 사용하여 0으로 만들 수 있다. 그 후부터는 REF의 값은 이미 NULL값이 아닌 0이므로
	       NVL은 기능을 하지않고 0부터 글들이 추가될 때마다 +1씩 증가한다.*/
				+ "      ?, ?, SYSDATE, 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
						
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 writeBbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/3 writeBbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 writeBbs success");
			
		} catch (SQLException e) {			
			e.printStackTrace();
			System.out.println("writeBbs fail");
		} finally {
			
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}

    public bBsDto getBbs(int seq) {
    	String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
    			+ "      TITLE, CONTENT, WDATE, DEL, READCOUNT "
				+ "	   FROM BBS "
				+ "    WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		bBsDto dto = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getdto success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/4 getdto success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getdto success");
			
			if(rs.next()) {
			
				dto = new bBsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10)); 
			}
			System.out.println("4/4 getdto success");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("login fail");
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
	}
    
    public void readcount(int seq) { // 게시물의 seq을 넣어 DB에 저장되어 있는 SEQ데이터에 대해 조회수를 +1증가 시키는 메소드
    	String sql = " UPDATE BBS "
    			+ "    SET READCOUNT=READCOUNT + 1 "
    			+ "    WHERE SEQ=? ";
    	
    	Connection conn = null;
		PreparedStatement psmt = null;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getcount success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 getcount success");
			
			psmt.executeUpdate();
			System.out.println("3/3 getcount success");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("readcount fail");
		}finally {
			DBClose.close(conn, psmt, null);
		}
	
    }
    public boolean updateBbs(bBsDto dto) { 
    	// bbsupdate에서 받아온 seq, title, content를 bBsDto에 넣어 bBsDto로 객체화 하여 메소드에 대입, 글을 수정하는 메소드
    	
    	String sql = " UPDATE BBS "
    			+ "    SET TITLE=?, "
    			+ "    CONTENT=? "
    			+ "    WHERE SEQ=? ";
    	
    	Connection conn = null;
    	PreparedStatement psmt = null;
    	
    	int count = 0;
    					
    	try {
    		conn = DBConnection.getConnection();
    		System.out.println("1/3 updateBbs success");
    		
    		psmt = conn.prepareStatement(sql);
    		psmt.setString(1, dto.getTitle());
    		psmt.setString(2, dto.getContent());
    		psmt.setInt(3, dto.getSeq());
    		System.out.println("2/3 updateBbs success");
    		
    		count = psmt.executeUpdate();
    		System.out.println("3/3 updateBbs success");
    		
    		
    	} catch (SQLException e) {			
    		e.printStackTrace();
    		System.out.println("updateBbs fail");
    	} finally {
    		
    		DBClose.close(conn, psmt, null);
    	}
    	return count>0?true:false;
    	
    }

    
    public boolean answer(int seq, bBsDto bbs) { // writeBbs(bBsDto dto)와 비슷한 맥락
    	// seq = 부모의 시퀀스 bbs = 새로 입력한 답글의 데이터
    	// 답글을 추가하고 추가여부를 리턴하는 메소드
        
        // update
        // REF와 같고 STEP을 늘려라
        String sql1 = " UPDATE BBS "
              +      " SET STEP=STEP+1 "
              +      " WHERE REF = (SELECT REF FROM BBS WHERE SEQ=? ) " // 게시물의 SEQ가 ?일때의 그룹번호와 일치하는 그룹번호들
              +      "       AND STEP > (SELECT STEP FROM BBS WHERE SEQ=? )"; //게시물의 SEQ가 ?일때의 행번호보다 클때의 행번호들
        
        // insert
        String sql2 = " INSERT INTO BBS(SEQ, ID,  "
              +      "             REF, STEP, DEPTH, "
              +     "               TITLE, CONTENT, WDATE, DEL, READCOUNT) "
              +      " VALUES(SEQ_BBS.NEXTVAL, ?, "
              +      "            (SELECT REF FROM BBS WHERE SEQ=? ),"   // REF
              +      "         (SELECT STEP FROM BBS WHERE SEQ=? ) + 1, "  // STEP
              +      "         (SELECT DEPTH FROM BBS WHERE SEQ=? ) + 1, " // DEPTH
              +      "         ?, ?, SYSDATE, 0, 0) ";
        
        Connection conn = null;
         PreparedStatement psmt = null;
         
         int count = 0;
         
         try {
           conn = DBConnection.getConnection();
           conn.setAutoCommit(false);
           System.out.println("1/6 answer success");
           
           // update
           psmt = conn.prepareStatement(sql1);
           psmt.setInt(1, seq);
           psmt.setInt(2, seq);
           System.out.println("2/6 answer success");
           
           count = psmt.executeUpdate();
           System.out.println("3/6 answer success");
           
           // psmt 초기화, 다시 쿼리문 사용
           psmt.clearParameters();
           
           // insert
           psmt = conn.prepareStatement(sql2);
           psmt.setString(1, bbs.getId());
           psmt.setInt(2, seq);
           psmt.setInt(3, seq);
           psmt.setInt(4, seq);
           psmt.setString(5, bbs.getTitle());
           psmt.setString(6, bbs.getContent());
           System.out.println("4/6 answer success");
           
           count = psmt.executeUpdate();
           System.out.println("5/6 answer success");
           
           conn.commit();
           System.out.println("6/6 answer success");
           
        } catch (SQLException e) {
           e.printStackTrace();
           System.out.println("answer fail");
           // 되돌림
           try {
              conn.rollback();
           } catch (SQLException e1) { e1.printStackTrace();}
        } finally {
           try {
              conn.setAutoCommit(false);
           } catch (SQLException e) {
              // TODO Auto-generated catch block
              e.printStackTrace();
           }
           DBClose.close(conn, psmt, null);
        }
         return count>0?true:false;
     }
    
     public List<bBsDto> getBbsSearchList(String choice, String search) { 
    	 // choice는 bbsanswer.jsp에서 선택한 <select>값이며, search는 유저가 게시판 리스트에서 원하는 항목으로 검색한 검색명이다.
    	 // bBsDto의 데이터를 List값으로 리턴하는 메소드
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
				+ "    TITLE, CONTENT, WDATE, "
				+ "    DEL, READCOUNT "
				+ "    FROM BBS ";
		
		String sWord = ""; //sWord = searchword의 줄임말
		if(choice.equals("title")) { //option에서 고른 title과 DB에서 찾은 데이터가 같을 때 sWord의 쿼리문이 추가된다.
			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) { //option에서 고른 content와 DB에서 찾은 데이터가 같을 때 sWord의 쿼리문이 추가된다.
			sWord = " WHERE CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("id")) { //option에서 고른 id와 DB에서 찾은 데이터가 같을 때 sWord의 쿼리문이 추가된다.
			sWord = " WHERE ID = '" + search + "' ";
		}
		
		sql = sql + sWord; // 위에서 맞는 조건으로 선택된 sWord를 기존의 sql과 합쳐서 쿼리문이 실행된다.
		
		
		sql = sql + "    ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<bBsDto> list = new ArrayList<bBsDto>(); // 리턴값으로 줄 list객체를 ArrayList로 생성
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getId success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getId success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getId success");
			
			while(rs.next()) { // 데이터가 여러개이기 때문에 if문이 아닌 while문이여야 한다.
				bBsDto dto = new bBsDto(rs.getInt(1),    // SEQ
						                rs.getString(2), // ID
						                rs.getInt(3),    // REF
						                rs.getInt(4),    // STEP
						                rs.getInt(5),    // DEPTH
						                rs.getString(6), // TITLE
						                rs.getString(7), // CONTENT
						                rs.getString(8), // WDATE
						                rs.getInt(9),    // DEL
						                rs.getInt(10));  // READACCOUNT
				list.add(dto); // 쿼리문의 결과값들인 dto정보을 ArrayList에 순서대로 넣는다.
			}
			System.out.println("4/4 getId success");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getBbsList fail");
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
		
	}
    
    public List<bBsDto> getBbsPagingList(String choice, String search, int pageNumber) { // pageNumber는 0,1,2이런식으로 넘어옴
   	 // choice는 bbsanswer.jsp에서 선택한 <select>값이며, search는 유저가 게시판 리스트에서 원하는 항목으로 검색한 검색명이다.
   	 // bBsDto의 데이터를 List값으로 리턴하는 메소드
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT "
				+ "    FROM ";
		
		       sql +=      "(SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, "
		       		+ "         SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT "
		       		+ "       FROM BBS ";
		       
		       
		
		String sWord = ""; //sWord = searchword의 줄임말
		if(choice.equals("title")) { //option에서 고른 title과 DB에서 찾은 데이터가 같을 때 sWord의 쿼리문이 추가된다.
			sWord = "         WHERE TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) { //option에서 고른 content와 DB에서 찾은 데이터가 같을 때 sWord의 쿼리문이 추가된다.
			sWord = "         WHERE CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("id")) { //option에서 고른 id와 DB에서 찾은 데이터가 같을 때 sWord의 쿼리문이 추가된다.
			sWord = "         WHERE ID = '" + search + "' ";
		}
		
		sql = sql + sWord; // 위에서 맞는 조건으로 선택된 sWord를 기존의 sql과 합쳐서 쿼리문이 실행된다.
		
		
		sql = sql + "         ORDER BY REF DESC, STEP ASC) ";
		
		sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
//		sql = sql + " WHERE RNUM BETWEEN ? AND ? ";
		
		// pageNumber = 0 1 2
		int start, end;
		start = 1 + 10 * pageNumber;
		end = 10 + 10 * pageNumber;
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<bBsDto> list = new ArrayList<bBsDto>(); // 리턴값으로 줄 list객체를 ArrayList로 생성
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsSearchList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getBbsSearchList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsSearchList success");
			
			while(rs.next()) { // 데이터가 여러개이기 때문에 if문이 아닌 while문이여야 한다.
				bBsDto dto = new bBsDto(rs.getInt(1),    // SEQ
						                rs.getString(2), // ID
						                rs.getInt(3),    // REF
						                rs.getInt(4),    // STEP
						                rs.getInt(5),    // DEPTH
						                rs.getString(6), // TITLE
						                rs.getString(7), // CONTENT
						                rs.getString(8), // WDATE
						                rs.getInt(9),    // DEL
						                rs.getInt(10));  // READACCOUNT
				list.add(dto); // 쿼리문의 결과값들인 dto정보을 ArrayList에 순서대로 넣는다.
			}
			System.out.println("4/4 getBbsSearchList success");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getBbsSearchList fail");
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
		
	}
    
    public int getAllBbs(String choice, String search) {
 		
 		String sql = " SELECT COUNT(*) FROM BBS ";
 		
 		String sWord = "";
 		if(choice.equals("title")) {
 			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
 		}else if(choice.equals("content")) {
 			sWord = " WHERE CONTENT LIKE '%" + search + "%' ";
 		}else if(choice.equals("id")) {
 			sWord = " WHERE ID= '" + search + "' ";
 		}		
 		sql = sql + sWord;
 		
 		Connection conn = null;
 		PreparedStatement psmt = null;
 		ResultSet rs = null;
 		
 		int len = 0;
 		
 		try {
 			conn = DBConnection.getConnection();
 			System.out.println("1/3 getAllBbs success");
 			
 			psmt = conn.prepareStatement(sql);
 			System.out.println("2/3 getAllBbs success");
 			
 			rs = psmt.executeQuery();
 			if(rs.next()) {
 				len = rs.getInt(1);
 			}
 			System.out.println("3/3 getAllBbs success");
 			
 		} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 			System.out.println("getAllBbs fail");
 		} finally {
 			DBClose.close(conn, psmt, rs);
 		}
 		
 		return len;
 	}
    
    public boolean deleteBbs(int seq) {
    	String sql = " UPDATE BBS "
    			+ "    SET DEL=1 "
    			+ "    WHERE SEQ=? ";
    	
    	Connection conn = null;
 		PreparedStatement psmt = null;
 		
 		int count = 0;
 		
 		try {
 			conn = DBConnection.getConnection();
 			System.out.println("1/3 deleteBbs success");
 			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 deleteBbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteBbs success");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("deleteBbs fail");
		}
 		
 		return count>0?true:false;
    }
}











