package com.shop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Ks_CategoryDAO {

	Connection con = null;           // DB연결
	PreparedStatement pstmt = null;  // DB에 SQL문을 전송하는 객체
	ResultSet rs = null;             // SQL문을 실행 후 결과 값을 가지고 있는 객체
	
	String sql = null;               // SQL문을 저장할 객체
	
	// Ks_CategoryDAO 객체를 싱글턴 방식으로 만들어 보자
	// 1단계 : 싱클턴 방식으로 객체를 만들기 위해서는 우선적으로 
	//       기본 생성자의 접근제어자를 public에서 private으로 바꿔 주어야한다. 
	
	// 2단계 : Ks_CategoryDAO 객체를 정적 멤버로 선언해 주어야 한다.  -static 으로 선언해야함
	private static Ks_CategoryDAO instance;
	
	private Ks_CategoryDAO() {}        // 기본생성자 
	
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해주는 getInstance() 라는 메서드를
	// 만들어서 getInstance() 메서드에 외부에서 접근할 수 있게 해야함.
	public static Ks_CategoryDAO getInstance() {
		
		if(instance == null) {
			instance = new Ks_CategoryDAO();
		}
		
		return instance;
	}  // getInstance() 메서드 end
	
	// DB를 연동하는 작업을 진행하는 메서드 - DBCP 방식으로 DB와 연결 진행 
	public void openConn() {

		try {
			// 1단계 : JNDI 서버 객체 생성
			Context ctx = new InitialContext();
			
			// 2단계 : lookup() 메서드를 이용하여 매칭되는 커넥션을 찾는다.
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");
			
			// 3단계 : DataSource 객체를 이용하여 커넥션 객체를 하나 가져온다.
			con = ds.getConnection();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	} // openConn() 메서드 end
	
	
	// DB에 연결된 자원을 종료하는 메서드
	public void closeConn(ResultSet rs, 
			PreparedStatement pstmt, Connection con) {

			try {
				if(rs != null) {
				rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(con != null) {
					con.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
	} // closeConn() 메서드 end
	
	
	
	
	
}
