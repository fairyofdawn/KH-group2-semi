package com.user.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.shop.controller.Action;
import com.shop.controller.ActionForward;
import com.shop.model.Ks_ProductDAO;
import com.shop.model.Ks_ProductDTO;

public class PagingAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//// 페이징 처리 작업 진행
		int rowsize = 3;         // 한 페이지당 보여질 게시물의 수		
		int block = 3;           // 아래에 보여질 페이지의 최대 수 - 예) [1][2][3]/[4][5][6]		
		int totalRecord = 0;     // DB상의 게시물의 전체 수
		int allPage = 0;         // 전체 페이지 수
		
		int page = 0;             // 현재 페이지 변수
		
		if(request.getParameter("page") != null) {
			
			page = Integer.parseInt(request.getParameter("page").trim());
			
		}else {       // 처음으로 "전체 게시글 목록" a태그를 선택한 경우
			page = 1;
		}

		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize -1);
		
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);
		
		// 해당 페이지에서 시작 블럭
		int startBlock = (((page - 1) / block) * block) +1;
		
		// 해당 페이지에서 끝 블럭
		int endBlock = (((page - 1) / block) * block) + block;
		
		Ks_ProductDAO dao = Ks_ProductDAO.getInstance();
		
		// DB상의 전체 게시물의 수를 확인하는 메서드 호출
		totalRecord = dao.getProductCount();
		
		// ceil : 무조건 올림해주는 메서드 - 더블 자료형으로 allPage는 int 타입 이기때문에 형변환 해주어야함
		// 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 주어야함
		// 이 과정을 거치면 전체 페이기 수가 나옴
		// 전체 페이지 수가 나올때 나머지가 있으면 무조건 페이지 올림
		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
		
		if(endBlock > allPage) {
			endBlock = allPage;
		}
		
		// 현재 페이지에 해당하는 게시물을 가져오는 메서드
		List<Ks_ProductDTO> pageList = dao.getProductList(page, rowsize);
		
		// 지금까지 페이징 처리 시 작업했던 모든 값들을 view page로 이동시키자
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("List", pageList);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user/food.jsp");
	
		return forward;
	}

}
