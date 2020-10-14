package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.BoardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.comcode.service.ComcodeService;
import com.spring.comcode.vo.ComcodeVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ComcodeService comcodeService;
	
	ObjectMapper om = new ObjectMapper();
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<ComcodeVo> codeMenuList = new ArrayList<ComcodeVo>();
		List<Integer> pageList = new ArrayList<Integer>();
		int lastPage = 0;
		int pageTmp = 0;
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		boardList = boardService.selectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt();
		codeMenuList = comcodeService.selectMenu();
		
		lastPage =  totalCnt / 10;
		if(totalCnt % 10 > 0) {
			lastPage++;
		}
		
		pageTmp = pageVo.getPageNo() / 5;
		if(pageVo.getPageNo() % 5 == 0) {
			pageTmp--;
		}
		
		for (int i=pageTmp*5+1; i<=pageTmp*5+5; i++) {
			if(i>lastPage) {
				break;
			}
			pageList.add(i);
		}
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", pageList);
		model.addAttribute("codeMenuList", codeMenuList);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/boardCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardCheck(Locale locale, HttpServletRequest request) throws Exception{
		String[] checkValues = request.getParameterValues("check");
		HashMap<String, List<String>> result = new HashMap<String, List<String>>();
		CommonUtil commonUtil = new CommonUtil();
		String value = null;
		String[] vs;	
		List<String> checkList = new ArrayList<String>();
		
		value = om.writeValueAsString(checkValues);
		
		vs = value.substring(1, value.length()-1).split(",");
		for(int i=0; i<vs.length; i++) {
			checkList.add(vs[i].substring(1, vs[i].length()-1));
		}
		System.out.println("checkList::"+checkList);
		result.put("result", checkList);
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}

	
	@RequestMapping(value = "/board/boardCheck.do", method = RequestMethod.GET)
	public ModelAndView redirectBoard(HttpServletRequest request, Locale locale, 
			String check, PageVo pageVo) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<ComcodeVo> codeMenuList = new ArrayList<ComcodeVo>();
		List<String> checkList = new ArrayList<String>();
		List<Integer> pageList = new ArrayList<Integer>();
		int lastPage = 0;
		int pageTmp = 0;
		String[] vs;
		int totalCnt = 0;
		int page = 1;
		ModelAndView mv = new ModelAndView();
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		vs = check.split(",");
		for(int i=0; i<vs.length; i++) {
			checkList.add(vs[i]);
		}
		map.put("checked", checkList);
		map.put("pageVo", pageVo);
		
		boardList = boardService.selectCheckList(map);
		totalCnt = boardService.boardCheckCnt(map);
		codeMenuList = comcodeService.selectMenu();
		
		lastPage =  totalCnt / 10;
		if(totalCnt % 10 > 0) {
			lastPage++;
		}
		
		pageTmp = pageVo.getPageNo() / 5;
		if(pageVo.getPageNo() % 5 == 0) {
			pageTmp--;
		}
		
		for (int i=pageTmp*5+1; i<=pageTmp*5+5; i++) {
			if(i>lastPage) {
				break;
			}
			pageList.add(i);
		}
		
		mv.setViewName("board/boardList");
		mv.addObject("boardList", boardList);
		mv.addObject("codeMenuList", codeMenuList);
		mv.addObject("totalCnt", totalCnt);
		mv.addObject("pageNo", pageList);
		
		return mv;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("board", boardVo);
		
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale, BoardVo boardVo) throws Exception{
		CommonUtil commonUtil = new CommonUtil();
		HashMap<String, String> result = new HashMap<String, String>();
		String msg;
		String callbackMsg;
		
		int updateCnt = boardService.boardUpdate(boardVo);
		
		result.put("success", (updateCnt > 0)?"Y":"N");
		callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		List<ComcodeVo> codeMenuList = new ArrayList<ComcodeVo>();
		
		codeMenuList = comcodeService.selectMenu();
		model.addAttribute("codeMenuList", codeMenuList);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo,
			HttpServletRequest request) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		String selectType = request.getParameter("boardTypeSelectBox");
		System.out.println(selectType);
		boardVo.setBoardType(selectType);
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/boardDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDelete(Locale locale, BoardVo boardVo) throws Exception{
		CommonUtil commonUtil = new CommonUtil();
		HashMap<String, String> result = new HashMap<String, String>();
		String msg;
		String callbackMsg;
		int deleteCnt = boardService.boardDelete(boardVo);
		
		result.put("success", (deleteCnt > 0)?"Y":"N");
		callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
}
