package com.qmd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qmd.tools.DocConverter;
import com.qmd.tools.FileTransfer;

@Controller
@RequestMapping("/ReadOnlineController")
public class ReadOnlineController {

	@RequestMapping("/readOnline")
	protected void readOnline(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String temp = "F:/Users/";
		String fileName = request.getParameter("filename");
		String from = temp + fileName;
		String savePath = "D:/SWFTools";

		System.out.println("+++++======" + from);

		FileTransfer fileTransfer = new FileTransfer(savePath, from);
		fileTransfer.transfer();// 将文件移动到swftools文件夹

		System.out.println("//////////" + fileTransfer.getSavePath());

		DocConverter docConverter = new DocConverter(fileTransfer.getSavePath());
		docConverter.convert();// 生成swf文件

		System.out.println("nice++++" + docConverter.getSwfFilePath());

		String savePath2 = "E:/swf文件";
		FileTransfer fileTransfer2 = new FileTransfer(savePath2, docConverter.getSwfFilePath());
		fileTransfer2.transfer();
		request.getSession().setAttribute("swfPath", fileTransfer2.getSavePath());
		response.sendRedirect("../Flexpaper2.10/documentView.jsp");
		// request.getRequestDispatcher("/Flexpaper2.10/documentView.jsp").forward(request,response);
		// TODO Auto-generated method stub

	}

}
