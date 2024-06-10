package movie.service;

import java.util.List;

import movie.vo.PosterInfoVO;
import movie.vo.PosterVO;

public interface IPosterService {

	PosterVO getPosterByMvId(int mvId);

	List<PosterVO> getStillListByMvId(int mvId);
	
	List<PosterInfoVO> pstInfo(long psId);
	

}
