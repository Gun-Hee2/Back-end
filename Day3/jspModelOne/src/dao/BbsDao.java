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
	
	public List<bBsDto> getBbsList() {
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
				+ "           TITLE, CONTENT, WDATE, "
				+ "           DEL, READCOUNT "
				+ "    FROM BBS "
				+ "    ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<bBsDto> list = new ArrayList<bBsDto>();
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getId success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getId success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getId success");
			
			while(rs.next()) { // 데이터가 여러개이기 때문에 if문이 아닌 while문이여야 한다.
				bBsDto dto = new bBsDto(rs.getInt(1), 
						                rs.getString(2), 
						                rs.getInt(3), 
						                rs.getInt(4), 
						                rs.getInt(5), 
						                rs.getString(6), 
						                rs.getString(7), 
						                rs.getString(8), 
						                rs.getInt(9), 
						                rs.getInt(10));
				list.add(dto);
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

}
