package net.yuanma.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.yuanma.dao.UserInfoMapper;
import net.yuanma.dto.UserInfoDto;
import net.yuanma.model.UserInfo;

@Service
public class LoginService {

	@Autowired
	private UserInfoMapper userInfoMapper;
	
	public UserInfo login(UserInfo user){
		UserInfo selectUserByName = null;
		if(user!=null){
			selectUserByName = userInfoMapper.selectUserByName(user.getUsername(), user.getPassword());
		}
		return selectUserByName;
	}
	
	public UserInfoDto findUserInfo(int id){
		return userInfoMapper.selectUserInfoById(id);
	}
}
