package movie.dao;

import java.util.List;

import movie.vo.MovieInfoVO;

public interface IMovieInfoDao {
	
	/**
	 * 검색창에 키워드르를 입력하면 해당 키워드가 포함된 영화리스트를 가져오기 위한 메서드
	 * @param kwd : 검색창에 입력한 키워드
	 * @return : kwd가 포함된 영화 리스트 리턴
	 */
	public List<MovieInfoVO> getMovieList(String kwd);

	public MovieInfoVO getAMovie(int mvId);

	public List<MovieInfoVO> getActMovList(String kwd);

	public List<MovieInfoVO> getBoxOffice();

	public List<Integer> getWatchedList(String memId);



}
