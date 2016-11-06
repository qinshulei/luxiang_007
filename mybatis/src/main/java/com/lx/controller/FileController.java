package com.lx.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lx.macrofiles.MacroEnum.KCheckType;
import com.lx.macrofiles.MacroEnum.KFilePropertyType;
import com.lx.model.FileInfo;
import com.lx.service.FileInfoService;

@Controller
@RequestMapping("/FileInfoController")
public class FileController {

	@Autowired
	FileInfoService fileInfoService;

	@RequestMapping("/fy")
	public String showFileInfo(HttpServletRequest request) {
		System.out.println("=====================");
		// FileInfo fileInfo = fileInfoServiceImpl.getFileInfoById(fileId);

		FileInfo fileInfo = new FileInfo();
		fileInfo.setFileCategory("专利类");
		fileInfo.setFileName("哈利波特");

		request.setAttribute("fileInfo", fileInfo);

		return "showFileInfo";
		// System.out.println;
	}

	// ********************普通用户操作权限********************
	/**
	 * 公有文件
	 */
	@RequestMapping(value = "/publicfile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> publicfile(HttpSession httpSession, HttpServletRequest httpServletRequest) {
		Map<String, Object> map = new HashMap<String, Object>();

		List<FileInfo> pub_file = fileInfoService.selectFileByIsPass(KCheckType.pass);
		map.put("pub_file", pub_file);
		return map;
	}

	/**
	 * 上传文件
	 */
	public String uploadFile() {
		return null;
	}

	/**
	 * 我的上传
	 */
	@RequestMapping(value = "/myuploadfile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> myuploadfile(HttpSession httpSession, HttpServletRequest httpServletRequest) {
		Map<String, Object> map = new HashMap<String, Object>();
		String username = (String) httpSession.getAttribute("username");
		System.out.println(username + "hahahaha");
		List<FileInfo> pri_file = fileInfoService.selectMyFileInfo(username, KCheckType.pass);

		map.put("pri_file", pri_file);
		return map;
	}

	/**
	 * 我的下载
	 */
	public String myDownloadFile(){
		
		
		return null;
	}
	

	/**
	 * 下载文件
	 */
	@RequestMapping(value = "/down_check_file", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public void deleteuser(String select_filename, HttpServletRequest httpServletRequest) {
		
		
	}
	
	
	/**
	 * 用户删除文件,仅仅放入垃圾箱
	 */
	public String pushWithRecycleBin(){
		
		boolean d = fileInfoService.batchFilesIsPass(KCheckType.invalid, fileIds);
		return null;
	}
	
	/**
	 * 用户还原垃圾箱的文件
	 */
	public String popWithRecycleBin(){
		
		boolean d = fileInfoService.batchFilesIsPass(KCheckType.pass, fileIds);
		return null;
	}
	
	/**
	 * 用户删除文件,从垃圾箱里再次删除
	 */
	@RequestMapping(value = "/delete_file", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete_file(Integer[] delete_array, HttpServletRequest httpServletRequest) {

		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("传入数据=========");
		// System.out.println("传入数据========="+delete_array.toString());
		boolean result = fileInfoService.delFilesById(delete_array);
		map.put("flag", result);
		return map;
	}
	
	
	// **********查询**********
	public String ddd(){
		String param1 = "";  // 类别
		String param2 = "author";  // 属性(标题，作者……)
		String param3 = "";  // 值 是什么
		
		
		
		// 将第二个String转化成枚举类型的 , 注意： param2  只能是枚举里面有的。
		KFilePropertyType filePropertyType = KFilePropertyType.valueOf(param2); 
		fileInfoService.getFileByLikeFileProperty(fileCategory, filePropertyType, value);
		return null;
	}
	
	
	
	
	// ********************管理员操作权限********************
	/**
	 * 资源审核
	 */
	@RequestMapping(value = "/get_all_checkfile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> get_all_checkfile(HttpSession httpSession, HttpServletRequest httpServletRequest) {
		Map<String, Object> map = new HashMap<String, Object>();

		List<FileInfo> all_checkfile = fileInfoService.selectFileByIsPass(KCheckType.waitForCheck);

		map.put("checkfile", all_checkfile);
		return map;
	}

	/**
	 * 审核通过
	 */
	@RequestMapping(value = "/pass_file", method = RequestMethod.POST)

	@ResponseBody
	public Map<String, Object> pass_file(Integer[] pass_array, HttpSession httpSession,
			HttpServletRequest httpServletRequest) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("传入数据=========");
		boolean result = fileInfoService.batchFilesIsPass(KCheckType.pass, pass_array);
		map.put("flag", result);
		return map;
	}
	
	
	/**
	 * 审核不通过
	 */
	@ResponseBody
	public String notpass_file() {
		
		// fileIds ： 文件id 数组
		boolean d = fileInfoService.batchFilesIsPass(KCheckType.notPass, fileIds); 

	}


}
