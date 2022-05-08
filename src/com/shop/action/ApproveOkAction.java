package com.shop.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.model.UserDAO;

public class ApproveOkAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		int user_no = Integer.parseInt(request.getParameter("user_no").trim());
		UserDAO dao = UserDAO.getInstance();
		
		int check = dao.approve(user_no);
		System.out.println("check= " +check);
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		if (check > 0) {
			forward.setRedirect(false);
			forward.setPath("view/_admin.jsp");
 
		} else {
			out.println("<script>");
			out.println("alert('제품 정보 수정 실패~~~')");
			out.println("history.back()");
			out.println("</script>");
		}

		return forward;
	}

}
