package member.servive;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Part;

import member.dao.AtchFileDaoImpl;
import member.dao.IAtchFileDao;
import member.vo.AtchFileVO;
import member.vo.MemberVO;

public class AtchFileServiceImpl implements IAtchFileService {


	private IAtchFileDao fileDao;

	private static IAtchFileService fileService;

	private AtchFileServiceImpl() {
		fileDao = AtchFileDaoImpl.getInstance();
	}

	public static IAtchFileService getInstance() {
		if (fileService == null) {
			fileService = new AtchFileServiceImpl();
		}

		return fileService;
	}

	public AtchFileVO saveAtchFile(Collection<Part> parts, String memId) {
	    // 웹애플리케이션 루트 디렉토리를 기준으로 업로드 경로 설정하기
//	    String uploadPath = "C:\\Users\\Administrator\\Desktop\\setting\\workspace\\FilmSquare\\WebContent\\images\\pf";
	    String uploadPath = "D:\\D_setting\\A_TeachingMaterial\\04_MiddelProject\\workspace\\FilmSquare\\WebContent\\images\\pf";
	    File uploadDir = new File(uploadPath);

	    if (!uploadDir.exists()) {
	        uploadDir.mkdir();
	    }
	    boolean isFirstFile = true;
	    AtchFileVO fileVO = null;

	    for (Part part : parts) {
	        String fileName = part.getSubmittedFileName();

	        if (fileName != null && !fileName.equals("")) {
	            if (isFirstFile) {
	                isFirstFile = false;
	                fileVO = new AtchFileVO();
	            }

	            String orignFileName = fileName;
	            long fileSize = part.getSize();
	            String saveFileName = "";
	            String saveFilePath = "";

	            String fileExt = orignFileName.lastIndexOf(".") < 0 ? "" : orignFileName.substring(orignFileName.lastIndexOf(".") + 1);

	            saveFileName = UUID.randomUUID().toString().replace("-", "") + "." + fileExt;
	            saveFilePath = uploadPath + "\\" + saveFileName; // 역슬래시 사용

	            try {
	                part.write(saveFilePath);
	            } catch (IOException ex) {
	                throw new RuntimeException("업로드 파일 저장중 예외발생", ex);
	            }

	            // 추가된 디버깅 코드
	            System.out.println("orignFileName: " + orignFileName);
	            System.out.println("fileSize: " + fileSize);
	            System.out.println("saveFileName: " + saveFileName);
	            System.out.println("saveFilePath: " + saveFilePath);
	            System.out.println("fileExt: " + fileExt);

	            fileVO.setMempOrgnNm(orignFileName);
	            fileVO.setMempStreNm(saveFileName);
	            fileVO.setMempSize(fileSize);
	            fileVO.setMempPath(saveFilePath);
	            fileVO.setMempExtsn(fileExt);
	            fileVO.setMempSn(1);
	            // memId 추가
	            fileVO.setMemId(memId);

	            // 추가된 디버깅 코드
	            System.out.println("FileVO: " + fileVO);

	            fileDao.updateAtchFile(fileVO);

	            // 업로드 파일 저장하기
	            try {
	                part.delete(); // 임시 업로드 파일 삭제하기
	            } catch (IOException e) {
	                throw new RuntimeException("업로드 파일 삭제중 예외발생", e);
	            }
	        }
	    }

	    return fileVO;
	}


	


	@Override
	public List<AtchFileVO> getAtchFileList(AtchFileVO atchFileVO) {
		List<AtchFileVO> atchFileList = fileDao.getAtchFileList(atchFileVO);
		return atchFileList;
	}

	@Override
	public AtchFileVO getAtchFileDetail(AtchFileVO atchFileVO) {

		return fileDao.getAtchFileDetail(atchFileVO);
	}

	@Override
	public AtchFileVO getMember(MemberVO memId) {

		AtchFileVO mv = fileDao.getMember(memId);
		return mv;
	}

	@Override
	public int insertFile(AtchFileVO av) {

		return fileDao.insertFile(av);
	}

	@Override
	public int exist(String memId) {
		return fileDao.exist(memId);
	}

	@Override
	public AtchFileVO getAFile(String memId) {
		return fileDao.getAFile(memId);
	}



}
