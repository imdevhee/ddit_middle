package admin.dao;

import admin.vo.AdminVO;

public interface IAdminDao {
	/**
	 * 관리자 로그인 정보를 가져오기 위한 메서드
	 * @param av
	 * @return 관리자 로그인 정보를 담은 AdminVO 객체
	 */
	public AdminVO getAdminLoginInfo(AdminVO av);
}
