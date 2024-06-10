package movie.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections4.map.HashedMap;

import movie.service.IReleasingMovieService;
import movie.service.ReleasingMovieServiceImpl;
import movie.vo.CalendarVO;
import movie.vo.ReleasingMovieVO;

@WebServlet("/releasingCal.do")
public class ReleasingMovieController extends HttpServlet {

	IReleasingMovieService releasingMovieService = ReleasingMovieServiceImpl.getInstance();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
		
		Calendar cal = Calendar.getInstance();
		
		// year, month 기본적으로 오늘로 설정
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int date = cal.get(Calendar.DAY_OF_MONTH);
		
		// 파라미터 받아오기
		String sy = request.getParameter("year");
		String sm = request.getParameter("month");;
		String sd = request.getParameter("date");
		
		// 파라미터 넘어왔는지 확인
		// 처음 접속 시 파라미터 없음
		if( sy != null) {
			year = Integer.parseInt(sy);
		}
		if( sm != null) {
			month = Integer.parseInt(sm);
		}
		if( sd != null) {
			date = Integer.parseInt(sd);
		}

		
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, (month-1));
		int lastDay = cal.getActualMaximum(Calendar.DATE);
		
		if( date >lastDay ) {
			date = lastDay;
		}
		
		// 1월에서 이전 누르거나 12월에서 다음 눌렀을 때 처리
		if( month == 0 ) {
			month = 12;
			year--;
		} else if( month == 13 ) {
			month = 1;
			year ++;
		}
		
		// 1일에서 말일까지
		List<Map<LocalDate, List<ReleasingMovieVO>>> releasingList = new ArrayList<Map<LocalDate,List<ReleasingMovieVO>>>();
		
		for(int i=1; i<=lastDay; i++) {
			LocalDate calDate = LocalDate.of(year,month,i);
			List<ReleasingMovieVO> dayMovieList = releasingMovieService.getReleaseList(calDate);
			Map<LocalDate, List<ReleasingMovieVO>> dayMovieMap = new HashedMap<LocalDate, List<ReleasingMovieVO>>();
			dayMovieMap.put(calDate, dayMovieList);
			releasingList.add(dayMovieMap);
		}
		
		LocalDate calDate = LocalDate.of(year, month, date);
		
		
		CalendarVO calVo = new CalendarVO(calDate, releasingList);
		
		request.setAttribute("calVo", calVo);
		request.getRequestDispatcher("/views/figmaTest.jsp").forward(request, resp);

	}


	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
