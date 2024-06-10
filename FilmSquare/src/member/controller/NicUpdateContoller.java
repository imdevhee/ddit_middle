package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.servive.IMemberService;
import member.servive.MemberServiceImpl;
import member.vo.MemberVO;

@WebServlet("/updateNic.do")
public class NicUpdateContoller extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // doGet 메서드에서는 doPost 메서드를 호출하도록 수정
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String memId = req.getParameter("memId");
            String memNic = req.getParameter("newNic");

            // 보안 검사: memIntro과 memId가 null 또는 빈 문자열인 경우 에러 처리
            if (memNic == null || memNic.trim().isEmpty() || memId == null || memId.trim().isEmpty()) {
                throw new IllegalArgumentException("유효하지 않은 입력 값이 있습니다.");
            }

            System.out.println("닉네임 수정 요청: " + memId + " " + memNic);

            // 여기서 mv 객체 생성과 memService 호출은 필요한 로직에 맞게 수정
            MemberVO mvNic = new MemberVO();
            mvNic.setMemId(memId); // 추가: memId를 설정
            mvNic.setMemNcnm(memNic);

            HttpSession session = req.getSession();

            MemberVO oldMvNic = (MemberVO) session.getAttribute("LOGIN_MEMBER");
            
            if(oldMvNic != null) {
            	oldMvNic.setMemNcnm(mvNic.getMemNcnm());
            
            
            	session.setAttribute("LOGIN_MEMBER", oldMvNic);
            }
            IMemberService memService = MemberServiceImpl.getInstance();
            int cnt = memService.updateNic(mvNic);

            System.out.println("cnt>>>>>>cococoo: " + cnt);

            String msg = "";

            if (cnt > 0) {
                msg = "성공";
                
            } else {
                msg = "실패";
            }

            // forward는 여기서 한번만 호출하면 됨
            resp.sendRedirect(req.getContextPath() + "/views/member/mypage.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/views/member/mypage.jsp?msg=에러가 발생했습니다.");
        }
    }
}
