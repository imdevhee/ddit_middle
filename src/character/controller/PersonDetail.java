package character.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import character.service.CharacterServiceImpl;
import character.service.ICharacterService;
import character.vo.CharacterVO;
import character.vo.PersonImageVO;
import character.vo.PersonInfoVO;
import character.vo.PersonLikeVO;
import member.vo.MemberVO;
import movie.service.IPosterService;
import movie.service.PosterServiceImpl;
import movie.vo.PosterInfoVO;


@WebServlet("/personDetail.do")
public class PersonDetail extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 인물 정보  
		
		long psId = Long.parseLong(req.getParameter("psId"));
		System.out.println(psId);
		
		ICharacterService charService = CharacterServiceImpl.getInstance();
		
		List<PersonInfoVO> psifList = charService.searchInfo(psId);
		
		req.setAttribute("psifList", psifList);

		System.out.println(psifList);	
		
		// 인물 사진
		
		List<PersonImageVO> psiList = charService.searchImage(psId);
		
		req.setAttribute("psiList", psiList);
		
		System.out.println(psiList);
		
		// 좋아요 수 
		List<PersonLikeVO> pslkList = charService.personLk(psId);
		
		if (pslkList != null) {
			req.setAttribute("pslkList", pslkList);
		    System.out.println(pslkList);
		} else {
		   
		    System.out.println("pslkList가 null");
		}
		
		
		// 출연작 정보
		IPosterService pstService = PosterServiceImpl.getInstance();
				
		List<PosterInfoVO> pstifList = pstService.pstInfo(psId);
		
		req.setAttribute("pstifList", pstifList);
		
		System.out.println(pstifList);
		req.getRequestDispatcher("/views/personDetail.jsp").forward(req, resp);
		
		
		
		
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		
		BufferedReader reader = req.getReader();
		StringBuilder str = new StringBuilder();
		String line;
		while((line = reader.readLine()) != null) {
			str.append(line);
		}
		
		JSONObject jsonRequest = new JSONObject(str.toString());
		
		MemberVO mv = (MemberVO) req.getSession().getAttribute("LOGIN_MEMBER");
		String loginedMemId = mv.getMemId();
		System.out.println("loginedMemId ===>" + loginedMemId);
		
		
		
//		String memId = jsonRequest.getString("memId");
		Long psId = jsonRequest.getLong("psId");
//		String pslkYn = jsonRequest.getString("pslkYn");
		System.out.println( "post의 psID !!!!! >>><><><"+psId);
		
		
		
		
		resp.setContentType("text/html;charset=UTF-8");
		
		ICharacterService charService = CharacterServiceImpl.getInstance();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("memId",loginedMemId);
		map.put("psId",psId);
		
		
		// 좋아요 정보 조회
		PersonLikeVO plvo = charService.plvoinfo(map);
		
		System.out.println("plvo ====>>>> "+plvo);
		
		String msg = "";
		// 로그인이 되어있고 인물정보가 잘 넘어왔을 때에는 insert가 가능하다 
		if(loginedMemId != null && psId != null) {
			
			// 로그인된 아이디로 조회한 인물 좋아요가 널일 경우는 insert
			if(plvo == null) {
				int cnt = charService.createlike(map);
				
			} else {
				String currentPslkYn = plvo.getPslkYn();
				
				
				if ("Y".equals(currentPslkYn)){
				// 로그인된 아이디로 조회한 인물 좋아요가 널이 아니고 Y일 때는 N이 되도록 업데이트
				System.out.println("이미 있어서 업데이트 N으로 바꿈");
				int cnt = charService.updatelike(map);
			} else {
				// 로그인된 아이디로 조회한 인물 좋아요가 널이 아니고 N일 때는 Y이 되도록 업데이트
				System.out.println("이미 있어서 업데이트 Y으로 바꿈");
				int cnt = charService.updatelikeReverse(map);
			}
			}
		// 로그인이 되어있지 않을 경우에는 로그인이 필요한 기능이라고 알려준다
		}else {
			System.out.println("하고싶으면 로그인을 하세요");
			req.getSession().setAttribute("msg", msg);
		}
		
	}	

}
