package com.spring.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.comcode.service.ComcodeService;
import com.spring.comcode.vo.ComcodeVo;
import com.spring.common.CommonUtil;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Controller
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	ComcodeService comcodeService;
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/user/userLogin.do", method = RequestMethod.GET)
	public String userLogin(Locale locale) {
		return "user/userLogin";
	}
	@RequestMapping(value = "/user/userLoginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String userLoginAction(Locale locale, UserVo userVo,
			HttpServletRequest request) throws Exception{
		CommonUtil commonUtil = new CommonUtil();
		int userIdCnt = userService.selectUserIdCheck(userVo.getUserId());
		String msg;
		HashMap<String, String> result = new HashMap<String, String>();
		String callbackMsg;
		if(userIdCnt==1) {
			UserVo checkVo = userService.selectUserInfo(userVo.getUserId());
			if(checkVo.getUserPw().equals(userVo.getUserPw())) {
				request.getSession().setAttribute("login", checkVo);
				msg = "loginsuccess";
				result.put("result", msg);
				callbackMsg = commonUtil.getJsonCallBackString("result", result);
				System.out.println("callbackMsg::"+callbackMsg);
				
				return callbackMsg;
			}else {
				msg = "notpw";
				result.put("result", msg);
				callbackMsg = commonUtil.getJsonCallBackString("result", result);
				System.out.println("callbackMsg::"+callbackMsg);
				
				return callbackMsg;
			}
		}
		else {
			msg = "emptyid";
			result.put("result", msg);
			callbackMsg = commonUtil.getJsonCallBackString("result", result);
			System.out.println("callbackMsg::"+callbackMsg);

			return callbackMsg;
		}
		
	}
	
	@RequestMapping(value = "/user/userLogout.do", method = RequestMethod.GET)
	public String userLogout(Locale locale, HttpServletRequest request) {
		UserVo userVo = (UserVo) request.getSession().getAttribute("login");
		logger.info(userVo.getUserId()+"logout");
		request.getSession().invalidate(); //세션 초기화
		
		return "redirect:/board/boardList.do";
	}
	
	@RequestMapping(value = "/user/userJoin.do", method = RequestMethod.GET)
	public String userJoin(Locale locale, Model model) throws Exception {
		List<ComcodeVo> codePhoneList = new ArrayList<ComcodeVo>();
		
		codePhoneList = comcodeService.selectPhone();
		
		model.addAttribute("codePhoneList", codePhoneList);
		return "user/userJoin";
	}
	
	@RequestMapping(value = "/user/userJoinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String userJoinAction(Locale locale, UserVo userVo,
			HttpServletRequest request) throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		userVo.setUserPhone1(request.getParameter("phoneSelectBox"));
		System.out.println("uesrVo postNo::"+userVo.getUserAddr1());
		int resultCnt = userService.userInsert(userVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/userIdOverlapCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String userIdCheck(Locale locale, String id) throws Exception {
		CommonUtil commonUtil = new CommonUtil();
		HashMap<String, String> result = new HashMap<String, String>();
		String callbackMsg;
		
		int idOverlap = userService.selectUserIdCheck(id);
		
		result.put("result", (idOverlap == 0)?"Y":"N");
		callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
			
		
	}
	
}
