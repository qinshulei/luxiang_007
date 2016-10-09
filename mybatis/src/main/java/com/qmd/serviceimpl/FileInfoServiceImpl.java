package com.qmd.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qmd.dao.FileInfoMapper;
import com.qmd.model.FileInfo;
import com.qmd.service.FileInfoService;

@Service
public class FileInfoServiceImpl implements FileInfoService {

	@Autowired
	private FileInfoMapper fileInfoMapper;

	@Override
	public FileInfo getFileInfoById(int fileId) {
		return fileInfoMapper.selectByPrimaryKey(fileId);
	}

	@Override
	public boolean deleteFileInfoById(int fileId) {
		boolean flag = false;
		if (fileInfoMapper.deleteByPrimaryKey(fileId) == 1)
			flag = true;
		return flag;
	}

	@Override
	public boolean addFileInfo(FileInfo fileInfo){
		int i = fileInfoMapper.insert(fileInfo);
		System.out.println("_____" + i + "----");
		return true;
	}

	@Override
	public FileInfo getFileInfoByName(String fileName) {
		return fileInfoMapper.selectByFileName(fileName);
	}

	@Override
	public int getFileInfoCountByCategory(String fileCategory) {
		int count = fileInfoMapper.selectCountByFileCategory(fileCategory);
		System.out.println(count);
		return count;
	}

	@Override
	public boolean updateFileInfoById(FileInfo fileInfo) {
		int temp = 0;
		temp = fileInfoMapper.updateByPrimaryKey(fileInfo);
		if (temp == 1)
			return true;
		else
			return false;
	}

	@Override
	public boolean updateFileStatusByFileCategory(String fileCategory) {
		int temp = fileInfoMapper.updateFileStatusByCategory(fileCategory);
		System.out.println(temp);
		if (temp >= 0)
			return true;
		else
			return false;
	}

}