package collection.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import collection.service.ClLikeServiceImpl;
import collection.service.CollcontentServiceImpl;
import collection.service.CollectionServiceImpl;
import collection.service.IClLikeService;
import collection.service.ICollcontentService;
import collection.service.ICollectionService;
import member.servive.AtchFileServiceImpl;
import member.servive.IAtchFileService;
import member.servive.IMemberService;
import member.servive.MemberServiceImpl;
import movie.service.IMovieGradeService;
import movie.service.IMovieInfoService;
import movie.service.IPosterService;
import movie.service.MovieGradeServiceImpl;
import movie.service.MovieInfoServiceImpl;
import movie.service.PosterServiceImpl;

import collection.vo.CollParamContainerVO;
import collection.vo.CollcontentVO;
import collection.vo.CollectionVO;
import member.vo.AtchFileVO;
import member.vo.MemberVO;
import movie.vo.MovieInfoVO;
import movie.vo.PosterVO;

@WebServlet("/collectionDetail.do")
public class CollectionDetailController extends HttpServlet {
	 
	 ICollectionService collectionService = CollectionServiceImpl.getInstance();
	 IMemberService memberService = MemberServiceImpl.getInstance();
	 IAtchFileService fileService = AtchFileServiceImpl.getInstance();
	 ICollcontentService collContentService = CollcontentServiceImpl.getInstance();
	 IMovieInfoService movieInfoService = MovieInfoServiceImpl.getInstance();
	 IPosterService posterService = PosterServiceImpl.getInstance();
	 IClLikeService collLikeService = ClLikeServiceImpl.getInstance();
	 IMovieGradeService movieGradeService = MovieGradeServiceImpl.getInstance();
	 
	 
	 @Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 
		 // 파라미터 받아오기
		 String sclId = req.getParameter("clId");
		 
		 if(sclId==null) {
			 sclId = "123";
		 }
		 
		 
		 CollectionVO coll = collectionService.getACollection(new CollectionVO(new BigDecimal(sclId)));
		 String memId = coll.getMemId();
		 
		 int likeCnt = collLikeService.countLike(coll);
		 coll.setLikeCnt(likeCnt);
		 
		 MemberVO mem = memberService.getAMember(new MemberVO(memId));
		 
		 AtchFileVO file = fileService.getAFile(memId);
		 
		 List<CollcontentVO> collContentList = collContentService.getCollContentList(new CollcontentVO(new BigDecimal(sclId)));

		 List<Map<String, Object>> paramMapList = new ArrayList<Map<String,Object>>();
		 for(CollcontentVO collCont : collContentList ) {
			 
			 MovieInfoVO movie = movieInfoService.getAMovie(collCont.getMvId().intValue());
			 try {
				 movie.setGradeAvg(movieGradeService.getGradeAvg(movie.getMvId()));				
			} catch (Exception e) {
				movie.setGradeAvg(0);				
			}
			 
			 PosterVO poster = null;
			 try {
				  poster = posterService.getPosterByMvId(movie.getMvId());				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			 Map<String, Object> paramMap = new HashMap<String, Object>();
			 paramMap.put("movie", movie);
			 paramMap.put("poster", poster);
			 
			 paramMapList.add(paramMap);
			 
		 }
		 
		 CollParamContainerVO collParam = new CollParamContainerVO(coll, mem, file, paramMapList );
		 req.setAttribute("collParam", collParam);
		 
		 req.getRequestDispatcher("/views/collectionDetail2.jsp").forward(req, resp);
		 
	}
	 
	 @Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 
	}

}
