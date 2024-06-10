package movie.service;

import java.util.List;

import movie.dao.IMovieDetailDao;
import movie.dao.IMovieInfoDao;
import movie.dao.IPosterDao;
import movie.dao.MovieDetailDaoImpl;
import movie.dao.MovieInfoDaoImpl;
import movie.vo.MovieInfoVO;
import movie.vo.MvGradeVO;
import movie.vo.MvPosterVO;
import movie.vo.PosterVO;

public class MovieInfoServiceImpl implements IMovieInfoService {

	private static IMovieInfoService movieInfoService;

	IMovieInfoDao movieInfoDao;

	IMovieDetailDao movieDetailDao;

	private MovieInfoServiceImpl() {

		movieInfoDao = MovieInfoDaoImpl.getInstance();

		movieDetailDao = MovieDetailDaoImpl.getInstance();

	}

	public static IMovieInfoService getInstance() {

		if (movieInfoService == null) {
			movieInfoService = new MovieInfoServiceImpl();
		}
		return movieInfoService;
	}

	@Override
	public List<MovieInfoVO> getMovieList(String kwd) {

		List<MovieInfoVO> mList = movieInfoDao.getMovieList(kwd);

		if (mList != null) {

			for (int i = 0; i < mList.size(); i++) {
				MvPosterVO url = movieDetailDao.getMoviePoster(mList.get(i).getMvId());

				MvGradeVO grade = movieDetailDao.getMovieGrade(mList.get(i).getMvId());

				mList.get(i).setPosterImg(url.getPosterImg());
				mList.get(i).setGradeAvg(grade.getGradeAvg());

			}
		}

		return mList;
	}

	@Override
	public MovieInfoVO getAMovie(int mvId) {
		return movieInfoDao.getAMovie(mvId);
	}

	
	@Override
	public List<MovieInfoVO> getActMovList(String kwd) {
	    System.out.println("asdfasdfas" + kwd);
	    List<MovieInfoVO> mList = movieInfoDao.getActMovList(kwd);
	    if (mList != null) {
	        for (int i = 0; i < mList.size(); i++) {
	        	MvPosterVO url = movieDetailDao.getMoviePoster(mList.get(i).getMvId());
	            MvGradeVO grade = movieDetailDao.getMovieGrade(mList.get(i).getMvId());

	            mList.get(i).setPosterImg(url != null ? url.getPosterImg() : null);
	            mList.get(i).setGradeAvg(grade != null ? grade.getGradeAvg() : null);
	        }
	    }
	    return mList;
	}

	@Override
	public List<MovieInfoVO> getBoxOffice() {
		return movieInfoDao.getBoxOffice();
	}

	@Override
	public List<Integer> getWatchedList(String memId) {
		return movieInfoDao.getWatchedList(memId);
	}


}
