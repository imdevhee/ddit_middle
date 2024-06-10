package movie.service;

import java.time.LocalDate;
import java.util.List;

import movie.dao.IMovieGradeDao;
import movie.dao.MovieGradeDaoImpl;
import movie.vo.GradeVOforYE;
import movie.vo.MovieInfoVO;
import movie.vo.MvCommentVO;
import movie.vo.MvGradeVO;

public class MovieGradeServiceImpl implements IMovieGradeService {

	IMovieGradeDao dao;
	
	private static IMovieGradeService singleTon;
	
	private MovieGradeServiceImpl() {
		dao = MovieGradeDaoImpl.getInstance();
	};
	
	public static IMovieGradeService getInstance() {
		if( singleTon ==null) {
			singleTon = new MovieGradeServiceImpl();
		}
		return singleTon;
	}

	@Override
	public int getGradeAvg(int mvId) {
		return dao.getGradeAvg(mvId);
	}

	@Override
	public int countAGrade(MvGradeVO grade) {
		return dao.countAGrade(grade);
	}
	
	@Override
	public int countAllGrade(MvGradeVO grade) {
		return dao.countAllGrade(grade);
	}

	@Override
	public List<GradeVOforYE> getGradeList(MvGradeVO mvGradeVO) {
		return dao.getGradeList(mvGradeVO);
	}

	@Override
	public int countMostCommonGrade(MvGradeVO mvGradeVO) {
		return dao.countMostCommonGrade(mvGradeVO);
	}

	@Override
	public List<GradeVOforYE> getMyDateWatchedList(MvGradeVO mvGradeVO) {
		return dao.getMyDateWatchedList(mvGradeVO);
	}

	@Override
	public GradeVOforYE getAGradeByMvIdNMemId(GradeVOforYE grade) {
		return dao.getAGradeByMvIdNMemId(grade);
	}

	@Override
	public List<GradeVOforYE> getMonthGradeList(MvGradeVO mvGradeVO) {
		return dao.getMonthGradeList(mvGradeVO);
	}

	@Override
	public int countGenre(MvCommentVO param) {
		return dao.countGenre(param);
	}

	@Override
	public int getTotalRtime(String memId) {
		return dao.getTotalRtime(memId);
	}
}
