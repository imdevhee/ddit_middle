package comm.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginChkFilter
 */
public class LoginChkFilter implements Filter {

    

	
	public void destroy() {
		
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
	
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		// 로그인 없이 허용 가능URL 목록
		List<String> okUrlList = Arrays.asList("/memLogin.do", "/admin/mboard/list.do", "/kakaoLogin.do", "/delete.do");// 맴버 리스트 위치 넣어야함
		
		String reqURI = req.getRequestURI();
		
		boolean isAllowed = okUrlList.contains(
				reqURI.substring(req.getContextPath().length()));
		
		HttpSession session = req.getSession(false);
		
		if(isAllowed ||
				(session != null && session.getAttribute("LOGIN_MEMBER") != null)) {
			// 이용가능 URI, 로그인한 사람
			chain.doFilter(req, resp);
		}else {
			
			Enumeration<String> paramNames = req.getParameterNames();
			StringBuffer queryStrBuff = new StringBuffer();
			
			int cnt = 0;
			
			while(paramNames.hasMoreElements()) {
				
				String paramName = paramNames.nextElement();
				
				if(cnt == 0) {
					queryStrBuff.append("?");
				}else {
					queryStrBuff.append("&");
				}
				queryStrBuff.append(paramName);
				queryStrBuff.append("=");
				queryStrBuff.append(req.getParameter(paramName));
				
				cnt++;
			}
			req.getSession().setAttribute("redirectURL", reqURI + queryStrBuff.toString());
			resp.sendRedirect(req.getContextPath() + "/memLogin.do");
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		
	}

}
