package movie.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.service.IReplyService;
import comment.service.ReplyServiceImpl;
import comment.vo.ReplyVO;
import movie.service.IMovieDetailService;
import movie.service.MovieDetailServiceImpl;
import movie.vo.MvGradeVO;
import movie.vo.MvPosterVO;
import movie.vo.ActorVO;
import movie.vo.MvCollectionVO;
import movie.vo.MvCommentVO;
import movie.vo.MovieInfoVO;
import movie.vo.VodVO;

/**
 * 영화 상세 페이지에서 MOVIE,POSTER,GRADE 테이블 정보를 가져오는 컨트롤러
 * @author PC-19
 *
 */

@WebServlet("/Detail.do")
public class MovieDetail extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String memId = "61";
		int mvId =1129;
		///////////////////////////////////////////////////////////////////
		MvCommentVO mvc = new MvCommentVO();
		IMovieDetailService movieDetail = MovieDetailServiceImpl.getInstance();
		mvc.setMemId(memId);
		mvc.setMvId(mvId);
		MvCommentVO mvC1=movieDetail.getMvMvc(mvc);
		System.out.println("mvcmvcmvcmvc"+mvC1);
		req.setAttribute("mvC", mvC1);
		
		MvCommentVO mvC = (MvCommentVO) req.getAttribute("mvC");
		IReplyService replyListService = ReplyServiceImpl.getInstance();
		IMovieDetailService movieDetailService = MovieDetailServiceImpl.getInstance();
		////////////////////////////////////////////////////////////////////// mvcId가져오는
		
//		int mvId = Integer.parseInt(req.getParameter("mvId")); 메인에서 영화 클릭할 때 연결
		if (mvC != null) {

		int mvcId =mvC.getMvcId();
		System.out.println("mvccccccccccccccccccccccccccccId:"+mvcId);
		//movie
		MovieInfoVO mvDetail = movieDetailService.getMovieDetail(mvId);
		//poster
		MvPosterVO mvPoster = movieDetailService.getMoviePoster(mvId);
		//MovieGrade (사용자 평점 *10, 평론가 평점 *10)
		MvGradeVO mvGrade = movieDetailService.getMovieGrade(mvId);
		System.out.println("평점:"+mvGrade);
		//출연,제작 인물
		List<ActorVO> actorList = movieDetailService.getActorList(mvId);
		System.out.println("출연/제작:"+actorList);
		//예고편
		List<VodVO> vodList = movieDetailService.getVodList(mvId);
		System.out.println("예고편:"+vodList);
		//컬렉션
		List<MvCollectionVO> cltList = movieDetailService.getCltList(mvId);
		System.out.println("컬렉션:"+cltList);
		//코멘트 테이블, 코멘트 작성자 평점*10, 코멘트 좋아요 개수, 코멘트 댓글 개수, 프로필 이미지 경로, 좋아요 순으로 정렬
		List<MvCommentVO> cmtList = movieDetailService.getCmtList(mvId);
		System.out.println("코멘트:"+cmtList);
		System.out.println(">>>>mvcID"+mvcId);
		List<ReplyVO> rv = replyListService.getList(mvcId);
		
		
		System.out.println("rv>>>>>>>>>>>>>>>>>>" +rv);

		
		req.setAttribute("mvDetail", mvDetail);
		req.setAttribute("mvPoster", mvPoster);
		req.setAttribute("mvGrade", mvGrade);
		req.setAttribute("actorList", actorList);
		req.setAttribute("vodList", vodList);
		req.setAttribute("cltList", cltList);
		req.setAttribute("cmtList", cmtList);
		req.setAttribute("rv", rv);
		
		req.getRequestDispatcher("views/movie/commDetail.jsp").forward(req, resp);

		} else {
	        System.out.println("mvC 객체가 null입니다. 적절한 처리를 수행하세요.");
	    }	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
