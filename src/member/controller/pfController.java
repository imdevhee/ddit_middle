package member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.servive.AtchFileServiceImpl;
import member.servive.IAtchFileService;
import member.servive.IMemberService;
import member.servive.MemberServiceImpl;
import member.vo.AtchFileVO;
import member.vo.MemberVO;
import movie.service.IMovieGradeService;
import movie.service.IMovieInfoService;
import movie.service.IPosterService;
import movie.service.MovieGradeServiceImpl;
import movie.service.MovieInfoServiceImpl;
import movie.service.PosterServiceImpl;
import movie.vo.GradeVOforYE;
import movie.vo.MovieInfoVO;
import movie.vo.MvGradeVO;
import movie.vo.PosterVO;
import util.MyUtil;

@WebServlet("/mypage.do")
public class pfController extends HttpServlet {
	static IMemberService memService = MemberServiceImpl.getInstance();
	static IAtchFileService fileService = AtchFileServiceImpl.getInstance();
	static IMovieInfoService movieService = MovieInfoServiceImpl.getInstance();
	static IMovieGradeService gradeService = MovieGradeServiceImpl.getInstance();
	static IPosterService posterService = PosterServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // 멤버 기본정보
	    MemberVO mv = (MemberVO) req.getSession().getAttribute("LOGIN_MEMBER");

	    
	    // 멤버 프로필 사진 띄우기

	    MemberVO memId = memService.searchMember(mv);
	    
	    // getMember() = 유저 아이디로 프로필 상세정보 가져오는 메서드
	    AtchFileVO atchFileVO = fileService.getMember(memId);
	    req.setAttribute("mv", mv);
	    req.setAttribute("atchFileVO", atchFileVO);
	    req.getRequestDispatcher("views/member/mypage3.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
		// 마이페이지에서 전송한 index 값 받기
        String selectedGrade = req.getParameter("selectedGrade");
        
        
        String memId = req.getParameter("mypagemember");
        
        List<GradeVOforYE> gradeList = gradeService.getGradeList(new MvGradeVO(memId, Integer.parseInt(selectedGrade)));
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!");
        System.out.println("gradeList : "+gradeList.size());
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!");
        List<PosterVO> posterList = new ArrayList<PosterVO>();
        int count = 0;
        
        for(GradeVOforYE grade : gradeList) {
        	if(++count>10) break;
        	PosterVO poster = posterService.getPosterByMvId(grade.getMvId().intValue());
        	if(poster==null) {
        		count--;
        		continue;
        	}
        	posterList.add(poster);
        }

        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!");
        System.out.println("posterList : "+posterList.size());
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!");
        String posterListJson = MyUtil.convertObjectToJson(posterList);

        // 클라이언트로 응답 전송
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(posterListJson);
        
	}
}