package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.servive.IMemberService;
import member.servive.MemberServiceImpl;
import member.vo.MemberVO;

@WebServlet("/memLogin.do")
public class MemLogin extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/views/loginForm.jsp").forward(req, resp);
		
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String memEmail = req.getParameter("memEmail");
		String memPw = req.getParameter("memPw");
//		System.out.println(memEmail);
		
		// 서비스 생성
		IMemberService memService = MemberServiceImpl.getInstance();

		// 사용자 메일 및 비밀번호를 사용하여 db에서 해당사용자 정보 가져옴
		MemberVO login = new MemberVO();
		login.setMemEmail(memEmail);
		login.setMemPw(memPw);
		
		MemberVO mv = memService.loginChk(login);
		
		
		
		if(mv != null) {  // 인증된 사용자인 경우
			// 세션에 로그인 정보 설정
			req.getSession().setAttribute("LOGIN_MEMBER", mv);
			
			String redirectURL = (String) req.getSession().getAttribute("redirectURL");
			
//			if(redirectURL == null) {System.out.println(redirectURL);}
//			System.out.println(redirectURL);
			
			if(redirectURL != null) {
				// 세션에서 요청한 URL 삭제
				req.getSession().removeAttribute("redirectURL");
				// 요청 URL로 이동
				resp.sendRedirect(redirectURL);
			}else {
				// 메인 페이지 이동
				resp.sendRedirect(req.getContextPath() + "/main.do");  
				System.out.println("성공헀니?");
				
			}
			
		}
		else { // 인증 실패
			// 실패시 메시지 보내기
			req.setAttribute("loginFail", "로그인 실패 다시입력하세요.");
			
			// 로그인 페이지로 이동
			req.getRequestDispatcher("/views/loginForm.jsp").forward(req, resp);
			
		}
		
		
	}
	

}