package com.lx.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.lx.model.DocumentEntity;
import com.lx.tools.Page;
import com.lx.tools.PageNumBean;
import com.lx.tools.ToolDocIndex;

/**
 * 索引文档搜索
 */
@Controller
public class SearchController {

	private static Logger logger = Logger.getLogger(SearchController.class);

	// 文档搜索
	@RequestMapping("/searchIndex")
	public ModelAndView searchIndex(HttpServletRequest request) {
		logger.info("=================searchIndex==================");
		String queryStr = request.getParameter("queryStr").trim(); // 检索内容
		String searchType = request.getParameter("searchType"); // 精确还是模糊
		String filetype = request.getParameter("filetype");// pdf doc all
		int topNum = Integer.parseInt(request.getParameter("topNum"));// 检索前topNum条
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));// 页大小
		String page_Now = request.getParameter("page_Now"); // 当前页

		int pageNow = 1;
		if (page_Now != null) {
			pageNow = Integer.valueOf(page_Now);
		}

		Page page = new Page(pageNow, pageSize);

		List<DocumentEntity> documentEntities = ToolDocIndex.searchDocIndex(queryStr, searchType, filetype, topNum,
				page);

		// 得到总的记录数
		int totalCount = page.getTotalCount();

		PageNumBean pageBean = new PageNumBean(pageNow, totalCount, pageSize, pageSize);
		Integer downPageNum = pageNow + 1;
		if (downPageNum > pageBean.getTotalPageCount())
			downPageNum = null;
		Integer upPageNum = pageNow - 1;
		if (upPageNum == 0)
			upPageNum = null;

		pageBean.setDownPageNum(downPageNum);
		pageBean.setUpPageNum(upPageNum);
		pageBean.setPageNow(pageNow);

		request.setAttribute("pageNumBean", pageBean);
		request.setAttribute("queryStr", queryStr);
		request.setAttribute("searchType", searchType);
		request.setAttribute("filetype", filetype);
		request.setAttribute("topNum", topNum);
		request.setAttribute("pageSize", pageSize);

		// request.setAttribute("sk1", URLEncoder.encode(queryStr, "UTF-8"));
		return new ModelAndView("result").addObject("totalCount", totalCount)
				.addObject("documentEntities", documentEntities).addObject("pageUrl", "searchIndex.do?page_Now=");

		// tomcat默认采用ISO-8859-1方式获取URI中的参数
		// fieldname = new String(fieldname.getBytes("ISO-8859-1"), "utf-8");
		// 转换为utf-8
	}

}
