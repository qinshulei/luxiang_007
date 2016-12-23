package com.lx.service;

import java.util.List;

import com.lx.model.Category;

public interface CategoryService {

	/** 添加一个文件类别
	 * @author luxiang
	 * @param categoryUserId 用户id
	 * @param categoryName 类别名
	 * @param categoryBelongTo 指定类别所属的上一级类别名
	 * @return boolean,true表示添加成功,false表示添加失败
	 */
	public boolean addCategory(Integer categoryUserId, String categoryName, String categoryBelongTo);
	
	/** 删除一个类别,注意:删除当前类别后,其子类别也将被删除(方法有待完善)
	 * @author luxiang
	 * @param categoryUserId 指定用户Id
	 * @param categoryName 指定删除类别的名称
	 * @return
	 */
	public boolean delCategory(Integer categoryUserId, String categoryName);

	/** 获取所有类别
	 * @author luxiang
	 * @param categoryUserId 指定用户Id
	 * @return
	 */
	public List<Category> getAllCategory(Integer categoryUserId);
	
	/** 检查类别是否存在,注意:一个用户的所有类别名必须唯一
	 * @author luxiang
	 * @param categoryUserId 指定用户Id
	 * @param categoryName 指定删除类别的名称
	 * @return
	 */
	public boolean checkCategoryIsExist(Integer categoryUserId, String categoryName);
	
}
