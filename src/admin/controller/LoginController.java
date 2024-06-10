package admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.service.IAdminService;
import admin.service.AdminServiceImpl;
import admin.vo.AdminVO;




@WebServlet("/admin")
public class LoginController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/admin/adminLogin.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String adminId = req.getParameter("adminId");
		String adminPw = req.getParameter("adminPw");
		
		// 서비스 생성
		IAdminService adminService = AdminServiceImpl.getInstance();
		
		// 관리자 ID 및 패스워드를 사용하여 DB로부터 해당 관리자 정보를 가져온다.
		AdminVO adminloginInfo = new AdminVO();
		adminloginInfo.setAdminId(adminId);
		adminloginInfo.setAdminPw(adminPw);
		
		AdminVO av = adminService.getAdminLoginInfo(adminloginInfo);
		
		if(av != null) { // 인증된 관리자인 경우
			
			// 세션에 로그인 정보 설정하기
			req.getSession().setAttribute("LOGIN_ADMIN", av);
			
			String redirectURL = (String) req.getSession().getAttribute("redirectURL");
			
			if(redirectURL != null) {
				// 세션에서 요청했던 URL 삭제처리
				req.getSession().removeAttribute("redirectURL");
				// 요청했던 URL로 이동시키기
				resp.sendRedirect(redirectURL);
			}else {
				// 메인 페이지로 이동하기
				resp.sendRedirect(req.getContextPath() + "/adminIndex.jsp");
			}
			
		}else { // 관리자 인증 실패
			// 로그인 페이지로 이동하기
			req.setAttribute("loginFailed", true);
			resp.sendRedirect(req.getContextPath() + "/admin");
//			req.getRequestDispatcher("/views/admin/adminLogin.jsp").forward(req, resp);
		}
	}
}
