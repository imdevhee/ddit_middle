package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/findEmail.do")
public class FindEmailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 입력 받은 이름과 휴대폰 번호 가져오기
        String memberName = request.getParameter("memName");
        String memberPhone = request.getParameter("memTelno");
        System.out.println(memberName + memberPhone);
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // 오라클 JDBC 드라이버 로딩
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // 오라클 데이터베이스에 연결
            conn = DriverManager.getConnection("jdbc:oracle:thin:@112.220.114.130:1521:xe", "team2_202310M", "java");

            // SQL 쿼리 작성
            String sql = "SELECT Mem_Email FROM member WHERE mem_name = ? AND mem_telno = ?";

            // PreparedStatement를 사용하여 동적인 쿼리 생성
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, memberName);
            stmt.setString(2, memberPhone);

            // 쿼리 실행 및 결과 얻기
            rs = stmt.executeQuery();

            if (rs.next()) {
                // 찾은 경우: 아이디 출력
                String mail = rs.getString("Mem_Email");
                String mailUserCanSee = mask(mail);
                request.setAttribute("memEmail", mailUserCanSee);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/findEmail.jsp");
                dispatcher.forward(request, response);
            } else {
                // 찾지 못한 경우: 실패 메시지 출력
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/findEmail.jsp");
                dispatcher.forward(request, response);
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // 연결 및 자원 해제
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    
    
    private String mask(String email) {
    	return email.replaceAll("(?<=.{3}).(?=[^@]*?@)", "*");
    }
    
    
    
    
}
