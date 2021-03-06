package com.lx.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lx.macrofiles.MacroConstant;
import com.lx.model.Category;
import com.lx.service.CategoryService;

@Controller
@RequestMapping("/CategoryController")
public class CategoryController {

	private static Logger logger = Logger.getLogger(CategoryController.class);

	@Autowired
	CategoryService categortservice;

	// 添加类别
	@RequestMapping(value = "/add_cate", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> add_cate(Integer userid, String catename, String categoryBelongTo) {
		logger.info("=================add_cate==================");
		System.out.println("====add_cate====" + catename + "===catebelongto===" + categoryBelongTo);
		Map<String, Object> map = new HashMap<>();
		if (categortservice.checkCategoryIsExist(userid, catename)) {
			map.put("flag", "cunzai");
			return map;
		}
		if (categoryBelongTo == null) {
			categoryBelongTo = MacroConstant.level0_category;
		}
		if (categortservice.addCategory(userid, catename, categoryBelongTo)) {
			map.put("flag", "chenggong");
			return map;
		} else {
			map.put("flag", "shibai");
			return map;
		}
	}

	// 删除类别
	@RequestMapping(value = "/del_cate", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> del_cate(Integer userid, String cate_name) {
		logger.info("=================del_cate==================");
		Map<String, Object> map = new HashMap<>();
		System.out.println("==userid==" + userid + "===cate_name====" + cate_name);
		boolean result = categortservice.delCategory(userid, cate_name);
		map.put("flag", result);
		return map;
	}

	// 修改类别
	@RequestMapping(value = "/change_cate", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> alertCategory(Integer userid, String username, String old_catename,
			String new_catename) {
		logger.info("=================change_cate==================");
		System.out.println(userid + "========" + username + "========" + old_catename + "======" + new_catename);
		Map<String, Object> map = new HashMap<>();
		if (categortservice.checkCategoryIsExist(userid, new_catename)) {
			map.put("flag", "cunzai");
			return map;
		}
		if (categortservice.alterCategory(userid, username, old_catename, new_catename)) {
			map.put("flag", "chenggong");
			return map;
		} else {
			map.put("flag", "shibai");
			return map;
		}
	}

	// 获取(公有)类别
	@RequestMapping(value = "/get_category", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> get_category(Integer userid) {
		logger.info("=================get_category==================" + userid);
		List<Category> category = categortservice.getAllCategory(userid);
		List<Category> newcate = new ArrayList<>();

		if (category != null) {
			for (Category cate : category) {
				if (cate.getCategoryBelongTo().equals(MacroConstant.level0_category))
					newcate.add(cate);
			}
		}

		Map<String, Object> map = new HashMap<>();
		map.put("category", newcate);
		return map;
	}

	// 获取子类别
	@RequestMapping(value = "/get_child_category", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> get_child_category(Integer userid, String categoryBelongTo) {
		logger.info("=================get_child_category==================");
		logger.info("========" + userid + "==================" + categoryBelongTo + "=========");
		Map<String, Object> map = new HashMap<>();
		List<Category> category = categortservice.getAllCategory(userid);
		List<Category> newcate = new ArrayList<Category>();

		if (category != null) {
			for (Category cate : category) {
				if (cate.getCategoryBelongTo().equals(categoryBelongTo))
					newcate.add(cate);
			}
		}

		map.put("category", newcate);
		return map;
	}
}