package movie.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import collection.vo.CollectionVO;
import member.vo.MemberVO;
import movie.service.IMovieDetailService;
import movie.service.MovieDetailServiceImpl;
import movie.vo.MvGradeVO;
import movie.vo.MvPosterVO;
import movie.vo.SottVO;
import movie.vo.ActorVO;
import movie.vo.MvCollectionVO;
import movie.vo.MvCommentVO;
import movie.vo.MovieInfoVO;
import movie.vo.MvPosterVO;
import movie.vo.VodVO;

/**
 * 영화 상세 페이지에서 MOVIE,POSTER,GRADE 테이블 정보를 가져오는 컨트롤러
 * @author PC-19
 *
 */

@WebServlet("/movieDetail.do")
public class MovieDetailController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		IMovieDetailService movieDetailService = MovieDetailServiceImpl.getInstance();
		int mvId = Integer.parseInt(req.getParameter("mvId")); //메인에서 영화 클릭할 때 연결
		
//		int mvId = 1129; // 테스트
		
//		System.out.println("mvId:"+mvId+",memId:"+memId);
		//movie
		MovieInfoVO mvDetail = movieDetailService.getMovieDetail(mvId);
		req.setAttribute("mvDetail", mvDetail);
		
		//poster
		MvPosterVO mvPoster = movieDetailService.getMoviePoster(mvId);
		req.setAttribute("mvPoster", mvPoster);
		
		//MovieGrade (사용자 평점 *10, 평론가 평점 *10)
		MvGradeVO mvGrade = movieDetailService.getMovieGrade(mvId);
		System.out.println("평점:"+mvGrade);
		req.setAttribute("mvGrade", mvGrade);
		
		//출연,제작 인물
		List<ActorVO> actorList = movieDetailService.getActorList(mvId);
		System.out.println("출연/제작:"+actorList);
		req.setAttribute("actorList", actorList);
		
		//예고편
		List<VodVO> vodList = movieDetailService.getVodList(mvId);
		System.out.println("예고편:"+vodList);
		req.setAttribute("vodList", vodList);
		
		//코멘트 테이블, 코멘트 작성자 평점*10, 코멘트 좋아요 개수, 코멘트 댓글 개수, 프로필 이미지 경로, 좋아요 순으로 정렬
		List<MvCommentVO> cmtList = movieDetailService.getCmtList(mvId);
		System.out.println("코멘트:"+cmtList);
		req.setAttribute("cmtList", cmtList);
		
		//시청가능ott
		List<SottVO> sottList = movieDetailService.getSottList(mvId);
		req.setAttribute("sottList", sottList);
		
		//컬렉션
		List<MvCollectionVO> cltList = movieDetailService.getCltList(mvId);
		System.out.println("컬렉션:"+cltList);
		req.setAttribute("cltList", cltList);
		
		//컬렉션 포스터
//		Map<String, Object> map = movieDetailService.getCltPoster2(mvId);
//		List<List<MvPosterVO>> pLists = (List<List<MvPosterVO>>) map.get("pLists");
//		List<MvCollectionVO> mvcList = (List<MvCollectionVO>) map.get("mvcList");
//		req.setAttribute("pLists", pLists);
		
		
		
		MemberVO mv = (MemberVO) req.getSession().getAttribute("LOGIN_MEMBER");
		if(mv!=null) {
			String memId = mv.getMemId();
			//접속자의 평점
			MvGradeVO memGrade = new MvGradeVO();
			memGrade.setMvId(mvId);
			memGrade.setMemId(memId);
			memGrade = movieDetailService.getMemGrade(memGrade); //(접속자 평점)*10
//		System.out.println("접속자평점:"+memGrade);
//		System.out.println(pLists);
//		System.out.println(mvcList);
			//접속자 컬렉션 목록
			List<MvCollectionVO> memClList = movieDetailService.getMemCl(memId);
//		System.out.println(memClList);
			req.setAttribute("memGrade", memGrade);
			req.setAttribute("memClList", memClList);			
		}
		
		
		req.getRequestDispatcher("views/movie/movieDetail.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
}
