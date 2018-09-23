package net.yuanma.control;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import net.yuanma.dto.UserInfoDto;
import net.yuanma.model.UserInfo;
import net.yuanma.service.LoginService;
@Controller
@RequestMapping("/user")
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public String login(UserInfo user,HttpSession session){
		UserInfo login = loginService.login(user);
		if(login!=null){
			session.setAttribute("userInfo", login);
			return "0";
		}else{
			return "1";
		}
	}
	
	/*
	 * 
	 * 根据id获得用户信息
	 */
	@RequestMapping(value = "/userInfo",method=RequestMethod.POST)
	@ResponseBody
	public UserInfoDto getUserInfo(@RequestParam("id")int id){
		UserInfoDto findUserInfo = loginService.findUserInfo(id);
		return findUserInfo;
	}
	
	
}
