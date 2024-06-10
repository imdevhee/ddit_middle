package movie.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import movie.dao.IReleasingMovieDao;
import movie.dao.ReleasingMovieDaoImple;
import movie.vo.ReleasingMovieVO;

public class ReleasingMovieServiceImpl implements IReleasingMovieService {
	
	IReleasingMovieDao relaeingeMovieDao;
	
	private static IReleasingMovieService releaseMoviingService;
	
	private ReleasingMovieServiceImpl() {
		relaeingeMovieDao = ReleasingMovieDaoImple.getInstance();
	}
	
	public static IReleasingMovieService getInstance() {
		if(releaseMoviingService == null) {
			releaseMoviingService = new ReleasingMovieServiceImpl();
		}
		return releaseMoviingService;
	}

	@Override
	public List<ReleasingMovieVO> getReleaseList(LocalDate calDate) {
		return relaeingeMovieDao.getReleaseList(calDate);
	}

}
