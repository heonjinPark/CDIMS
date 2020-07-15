package kr.co.sunmoon.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwEncoder;
	
	@Setter(onMethod_ = @Autowired)
	private DataSource ds;
	
	@Test
	public void testInsertMember() {
		String sql = "insert into member_auth_tbl(userid, auth) values (?, ?)";
		
//		for (int i = 0; i < 10; i++) {
//			Connection conn = null;
//			PreparedStatement pstmt = null;
//			
//			try {
//				conn = ds.getConnection();
//				pstmt = conn.prepareStatement(sql);
//				
//				pstmt.setString(1, "2014244200");
//				pstmt.setString(2, pwEncoder.encode("pw200"));
//				pstmt.setString(3, "최종수");
//				
//				pstmt.executeUpdate();
//			} catch (Exception e) {
//				e.printStackTrace();
//			} finally {
//				if (pstmt != null) {try {pstmt.close();}catch (Exception e) {} }
//				if (conn != null) {try {conn.close();}catch (Exception e) {} }
//			}
//		}
		
//		for (int i = 0; i < 10; i++) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, "2014244200");
				pstmt.setString(2, "ROLE_USER");
				
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) {try {pstmt.close();}catch (Exception e) {} }
				if (conn != null) {try {conn.close();}catch (Exception e) {} }
			}
//		}
	}
	
}
