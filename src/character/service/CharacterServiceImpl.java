package character.service;

import java.util.List;
import java.util.Map;

import character.dao.CharacterDaoImpl;
import character.dao.ICharacterDao;
import character.vo.CharacterVO;
import character.vo.PersonImageVO;
import character.vo.PersonInfoVO;
import character.vo.PersonLikeVO;

public class CharacterServiceImpl implements ICharacterService {
	
	private static ICharacterService charService;
	
	private static ICharacterDao charDao;
	
	private CharacterServiceImpl() {
		charDao = CharacterDaoImpl.getInstance();
	}
	
	public static ICharacterService getInstance() {
		if(charService == null) {
			charService = new CharacterServiceImpl();
		}
		return charService;
	}

	@Override
	public List<CharacterVO> getCharList(String kwd) {
		return charDao.getCharList(kwd);
	}

	@Override
	public List<PersonImageVO> searchImage(long psId) {
		return charDao.searchImage(psId);
	}

	@Override
	public List<PersonInfoVO> searchInfo(long psId) {
		
		return charDao.searchInfo(psId);
	}

	@Override
	public List<PersonLikeVO> personLk(long psId) {
		
		return charDao.personLk(psId);
	}

	@Override
	public int createlike(Map<String, Object> map) {
		
		return charDao.createlike(map);
	}

	@Override
	public int updatelike(Map<String, Object> map) {
		
		return charDao.updatelike(map);
	}

	@Override
	public int updatelikeReverse(Map<String, Object> map) {
		
		return charDao.updatelikeReverse(map);
	}


	@Override
	public List<CharacterVO> getMovActList(String kwd) {
		return charDao.getMovActList(kwd);
	}

	@Override
	public PersonLikeVO plvoinfo(Map<String, Object> map) {
		return charDao.plvoinfo(map);
	}

	

	

}
