package movie.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movie.service.IMovieDetailService;
import movie.service.MovieDetailServiceImpl;
import movie.vo.MvGradeVO;


@WebServlet("/mvGradeInsert.do")
public class MvGradeInsertController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		double d_mvgRating = Double.parseDouble(req.getParameter("selectedRating"));
		int mvgRating = (int) (d_mvgRating * 10); // 별점 * 10
		int mvId = Integer.parseInt(req.getParameter("mvId"));
		String memId = req.getParameter("memId");
		
		System.out.println("별점주기:"+mvgRating+","+mvId+","+memId);
		
		MvGradeVO mvgv = new MvGradeVO();
		mvgv.setMvgRating(mvgRating); // 평점 * 10
		mvgv.setMvId(mvId);
		mvgv.setMemId(memId);
		System.out.println(mvgv);
		
		IMovieDetailService movieDetailService = MovieDetailServiceImpl.getInstance();
		// 별점이 존재하는지 확인
		int exist = movieDetailService.mvgExist(mvgv);
		
		System.out.println("exist"+exist);
		
		int cnt = 0;
		if(exist == 0) {
			//존재하지 않으면 인서트
			cnt = movieDetailService.mvGradeInsert(mvgv);	
		}else {
			//존재하면 업데이트
			cnt = movieDetailService.mvGradeUpdate(mvgv);
		}
		
		
		
		System.out.println("별점"+cnt);
		
		//카운트 해서 업데이트 만들기
		
		
		
		
		
	}
}
