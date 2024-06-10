package member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import member.servive.IMemberService;
import member.servive.MemberServiceImpl;
import member.vo.MemberVO;

@WebServlet("/kakaoLogin.do")
public class KakaoLogin extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		doPost(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		BufferedReader bf = req.getReader();
		StringBuffer sbf = new StringBuffer();
		String line;

		while ((line = bf.readLine()) != null) {
			sbf.append(line);
		}

		JSONObject jsondata = new JSONObject(sbf.toString());

		String memEmail = jsondata.getString("memEmail");
		String memFrom = jsondata.getString("memFrom");
		String memNcnm = jsondata.getString("memNcnm");
		String memName = jsondata.getString("memName");
		String memTelno = jsondata.getString("memTelno");
		String birthyear = jsondata.getString("memBirthyear");
		String birthday = jsondata.getString("memBirthday");
		String gender = jsondata.getString("memGender");

		memTelno = memTelno.replace("+82 ", "0");
		System.out.println(memTelno);

		String maleFemale = "";

		if (gender.equals("male")) {
			if (Integer.parseInt(birthyear) > 2000) {
				maleFemale = "3";
			} else {
				maleFemale = "1";
			}
		} else {
			if (Integer.parseInt(birthyear) > 2000) {
				maleFemale = "4";
			} else {
				maleFemale = "2";
			}
		}
		String MemInum = birthyear.substring(2, 4) + birthday + "-" + maleFemale;

		System.out.println(memEmail);

		//
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out = resp.getWriter();

		IMemberService memService = MemberServiceImpl.getInstance();
		MemberVO login = null;
		MemberVO mv = new MemberVO();
		
		// 데이터베이스에 이메일이 이미 존재하는지 확인
		if (memService.emailChk(memEmail)) {
			
		
			mv = memService.searchInfo(memEmail);
			
			// 이메일이 이미 존재할 경우
			req.getSession().setAttribute("LOGIN_MEMBER", mv);

			
			System.out.println("이미 있는 정보로 로그인");

//			resp.sendRedirect(req.getContextPath() + "/main.do");
			out.print(login);

		} else {
			// 이메일이 존재하지 않을 경우, 삽입 진행
			System.out.println("존재하는 아이디 없음");

			login = new MemberVO();
			login.setMemEmail(memEmail);
			login.setMemFrom(memFrom);
			login.setMemNcnm(memNcnm);
			login.setMemInum(MemInum);
			login.setMemName(memName);
			login.setMemTelno(memTelno);

			System.out.println(login.getMemEmail());
			System.out.println(login.getMemId());
			
			int cnt = memService.kakaoInsert(login);
			
			mv = memService.searchInfo(login.getMemEmail());
			
			if (cnt > 0) {

				System.out.println("존재하는 아이디 없고 인서트 까지 성공");

				req.getSession().setAttribute("LOGIN_MEMBER", mv);
//				resp.sendRedirect(req.getContextPath() + "/main.do");
				resp.getWriter().print(cnt);

			}

		}

	}
}
