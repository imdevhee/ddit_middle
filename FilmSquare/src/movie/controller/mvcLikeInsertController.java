package movie.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movie.service.IMovieDetailService;
import movie.service.MovieDetailServiceImpl;
import movie.vo.MvcLikeVO;

@WebServlet("/mvcLikeInsert.do")
public class mvcLikeInsertController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String memId = req.getParameter("memId");
		int mvcId = Integer.parseInt(req.getParameter("mvcId"));
		MvcLikeVO mvcLikev = new MvcLikeVO();
		mvcLikev.setMemId(memId);
		mvcLikev.setMvcId(mvcId);
		
		IMovieDetailService movieDetailService = MovieDetailServiceImpl.getInstance();
		int exist = movieDetailService.mvcLikeExist(mvcLikev);
		
		if(exist == 0 ) {
			int insertCnt = movieDetailService.mvcLikeInsert(mvcLikev);			
			
		}else {
			int deleteCnt = movieDetailService.mvcLikeDelete(mvcLikev);
		}
		
		System.out.println("좋아요"+exist);
		
//		If(cnt > 0) {
//			System.out.println("좋아요");
//		}else {
//			
//		}
		
//		req.getRequestDispatcher(req.getContextPath()+"/movieDetail.do").forward(req, resp);
		
		
	}
}
