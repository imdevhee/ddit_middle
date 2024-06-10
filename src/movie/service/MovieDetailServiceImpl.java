package movie.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import collection.vo.CollectionVO;
import comment.vo.ReplyVO;
import movie.dao.IMovieDetailDao;
import movie.dao.MovieDetailDaoImpl;
import movie.vo.MvGradeVO;
import movie.vo.MvLaterVO;
import movie.vo.MvPosterVO;
import movie.vo.MvcLikeVO;
import movie.vo.ActorVO;
import movie.vo.MvCollectionVO;
import movie.vo.MovieInfoVO;
import movie.vo.MvCommentVO;
import movie.vo.PosterVO;
import movie.vo.SottVO;
import movie.vo.VodVO;

public class MovieDetailServiceImpl implements IMovieDetailService{

	static IMovieDetailDao movieDetailDao = MovieDetailDaoImpl.getInstance();
	private static IMovieDetailService movieDetailService;
	
	private MovieDetailServiceImpl() {}
	
	public static IMovieDetailService getInstance() {
		
		if(movieDetailService == null) {
			movieDetailService = new MovieDetailServiceImpl();
		}
		return movieDetailService;
		
	}
	
	@Override
	public MovieInfoVO getMovieDetail(int mvId) {
		return movieDetailDao.getMovieDetail(mvId);
	}

	@Override
	public MvPosterVO getMoviePoster(int mvId) {
		return movieDetailDao.getMoviePoster(mvId);
	}

	@Override
	public MvGradeVO getMovieGrade(int mvId) {
		return movieDetailDao.getMovieGrade(mvId);
	}

	@Override
	public int laterInsert(MvLaterVO mlv) {
		return movieDetailDao.laterInsert(mlv);
	}

	@Override
	public boolean isAlreadyAdded(MvLaterVO mlv) {
		return movieDetailDao.isAlreadyAdded(mlv);
	}

	@Override
	public int cmtInsert(MvCommentVO cmtv) {
		return movieDetailDao.cmtInsert(cmtv);
	}

	@Override
	public List<ActorVO> getActorList(int mvId) {
		return movieDetailDao.getActorList(mvId);
	}

	@Override
	public List<VodVO> getVodList(int mvId) {
		return movieDetailDao.getVodList(mvId);
	}

	@Override
	public List<MvCollectionVO> getCltList(int mvId) {
		return movieDetailDao.getCltList(mvId);
	}

	@Override
	public List<MvCommentVO> getCmtList(int mvId) {
		return movieDetailDao.getCmtList(mvId);
	}

	@Override
	public int mvcLikeInsert(MvcLikeVO mvcLikev) {
		return movieDetailDao.mvcLikeInsert(mvcLikev);
	}

	@Override
	public int mvGradeInsert(MvGradeVO mvgv) {
		return movieDetailDao.mvGradeInsert(mvgv);
	}

	@Override
	public int mvgExist(MvGradeVO mvgv) {
		return movieDetailDao.mvgExist(mvgv);
	}

	@Override
	public int mvGradeUpdate(MvGradeVO mvgv) {
		return movieDetailDao.mvGradeUpdate(mvgv);
	}

	@Override
	public MvGradeVO getMemGrade(MvGradeVO memGrade) {
		return movieDetailDao.getMemGrade(memGrade);
	}
	
	@Override
	public List<MvPosterVO> getCltPoster(int clid) {
		return movieDetailDao.getCltPoster(clid);
	}


	@Override
	public Map<String, Object> getCltPoster2(int mvId) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// cl_id 5개 가져오는 리스트
		List<MvCollectionVO> mvcList = movieDetailDao.getCltList(mvId);
		

		// 각 cl_id에 해당되는 영화리스트
		List<List<MvPosterVO>> pLists = new ArrayList<List<MvPosterVO>>();
		
		List<MvPosterVO> pList = null;
		
		for (MvCollectionVO mcv : mvcList) {
			
			pList = movieDetailDao.getCltPoster(mcv.getClId());
			
			pLists.add(pList);
			
		}
		
		map.put("mvcList", mvcList);
		map.put("pLists", pLists);
		
				
		return map;
		
	}

	@Override
	public List<MvCollectionVO> getMemCl(String memId) {
		return movieDetailDao.getMemCl(memId);
	}

	@Override
	public int myClInsert(MvCollectionVO cv) {
		return movieDetailDao.myClInsert(cv);
	}

	@Override
	public MvCommentVO getMvMvc(MvCommentVO mvc) {
		
		return movieDetailDao.getMvMvc(mvc);
	}

	@Override
	public int clExist(MvCollectionVO cv) {
		return movieDetailDao.clExist(cv);
	}

	@Override
	public int clInsert(MvCollectionVO cv) {
		return movieDetailDao.clInsert(cv);
	}


	@Override
	public MvCommentVO getCmtDetail(int mvcId) {
		return movieDetailDao.getCmtDetail(mvcId);
	}

	@Override
	public List<ReplyVO> getCmtReply(int mvcId) {
		return movieDetailDao.getCmtReply(mvcId);
	}

	@Override
	public int mvcLikeExist(MvcLikeVO mvcLikev) {
		return movieDetailDao.mvcLikeExist(mvcLikev);
	}

	@Override
	public int mvcLikeDelete(MvcLikeVO mvcLikev) {
		return movieDetailDao.mvcLikeDelete(mvcLikev);
	}

	@Override
	public List<SottVO> getSottList(int mvId) {
		return movieDetailDao.getSottList(mvId);
	}

	@Override
	public int mvcRpUpdate(ReplyVO rv) {
		return movieDetailDao.mvcRpUpdate(rv);
	}

	@Override
	public int mvcRpDelete(int mvcreId) {
		return movieDetailDao.mvcRpDelete(mvcreId);
	}
	
	


}
