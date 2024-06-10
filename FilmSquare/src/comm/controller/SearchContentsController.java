package comm.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.hc.client5.http.fluent.Request;

import character.service.CharacterServiceImpl;
import character.service.ICharacterService;
import character.vo.CharacterVO;
import movie.service.IMovieInfoService;
import movie.service.MovieInfoServiceImpl;
import movie.vo.MovieInfoVO;

/**
 * 상단 검색창에 키워드(kwd)를 검색하면 해당 키워드가 포함된 영화정보, 인물정보, 관련기사정보를 불러오기 위한 컨트롤러
 * 
 * @author 홍진영
 */
@WebServlet("/search.do")
public class SearchContentsController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		doPost(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 검색창으로 입력 받은 키워드
		String kwd = req.getParameter("search");

		// 영화 정보 및 포스터 가져오기
		IMovieInfoService movieInfoService = MovieInfoServiceImpl.getInstance();

		List<MovieInfoVO> movieInfoList = movieInfoService.getMovieList(kwd);
		
		List<MovieInfoVO> actMovList = movieInfoService.getActMovList(kwd);
		
		System.out.println(movieInfoList);
		System.out.println(actMovList);
		if (actMovList != null) {

			req.setAttribute("actMovList", actMovList);

		}
		
		if (movieInfoList != null) {

			req.setAttribute("movieInfoList", movieInfoList);

		}

		// 인물정보 가져오기

		ICharacterService charService = CharacterServiceImpl.getInstance();

		List<CharacterVO> charList = charService.getCharList(kwd);
		
		List<CharacterVO> movActList =charService.getMovActList(kwd);

		System.out.println("charList ==> " + charList);
		if (charList != null) {


			req.setAttribute("charList", charList);

		}
		if (movActList != null) {


			req.setAttribute("movActList", movActList);

		}

		// 뉴스기사 가져오기

		// 넘어온 키워드 정보를 url규칙에 맞게 인코딩 처리하기
		// >> url인코딩(퍼센트인코딩) - 문자를 인터넷을 통해 전송할 수 있는 형식으로 변환하는 것
		kwd = URLEncoder.encode(kwd, "utf-8");

		String newsResult = "";

		if (kwd.equals("") || kwd == null) {
			newsResult = Request
				.get("https://news.google.com/rss?hl=ko&gl=KR&ceid=KR:ko")
				.execute().returnContent().toString();

		} else {

			newsResult = Request
				.get("https://news.google.com/rss/search?hl=ko&gl=KR&ceid=KR%3Ako&oc=11&q=" + kwd)
				.execute().returnContent().toString();
		}
		
		newsResult = newsResult.replaceAll("\'", "\"");

		resp.setCharacterEncoding("UTF-8");
		
		System.out.println("newsResult = " + newsResult);
		
		req.setAttribute("newsResult", newsResult);

		req.getRequestDispatcher("/views/search.jsp").forward(req, resp);
	}

}
