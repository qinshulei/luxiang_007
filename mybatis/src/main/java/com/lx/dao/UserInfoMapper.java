package com.lx.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lx.model.UserInfo;

public interface UserInfoMapper {
	
	int deleteByPrimaryKey(Integer userId);

	int insert(UserInfo record);

	int insertSelective(UserInfo record);

	UserInfo selectByPrimaryKey(Integer userId);

	int updateByPrimaryKeySelective(UserInfo record);

	int updateByPrimaryKey(UserInfo record);

	//**********用于处理一些业务逻辑的方法**********
	int delUsersByUserName(@Param("userNames") String... userNames);
	UserInfo selectUserByUserName(String userName);
	int updateUsersCheck(@Param("userNames") String... userNames);
	int updateUserPasswordByUserName(@Param("userName") String userName, @Param("newPwd") String newPwd);
	List<UserInfo> selectUserByUserCheck(int userCheck);
	
	//**********用于获取一些智能下拉提示**********
	List<UserInfo> selectAllUserInfoByLikeUserName(@Param("userName") String userName);
	List<String> getUserNames(String userName);

}