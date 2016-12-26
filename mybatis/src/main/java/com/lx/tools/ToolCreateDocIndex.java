package com.lx.tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.springframework.beans.factory.annotation.Autowired;

import com.lx.macrofiles.MacroConstant;
import com.lx.macrofiles.MacroEnum;
import com.lx.service.DocRecordService;

import net.paoding.analysis.analyzer.PaodingAnalyzer;

public class ToolCreateDocIndex {

	@Autowired
	private static DocRecordService docRecordService;

	/**
	 * 初始化索引
	 */
	public static void init() {
		// Constant.getRootRealPath("pdf");
		// Analyzer analyzer = new StandardAnalyzer(Version.LUCENE_44);
		// String indexDir = SystemConstant.indexDir;
		// File file = new File(indexDir);
		// // 创建目录
		// Directory directory = FSDirectory.open(file);
		//
		// // 表示创建或覆盖当前索引；false表示对当前索引进行追加
		// // Default value is 128
		// IndexWriterConfig iwc = new IndexWriterConfig(Version.LUCENE_44,
		// analyzer);
		// IndexWriter writer = new IndexWriter(directory, iwc);
		// Document document = new Document();
		// writer.addDocument(document);
		// writer.close();

		docRecordService.deleteAllDoc();
	}

	/**
	 * 创建pdf索引
	 */
	public static boolean createPDFIndex(HttpServletRequest request) {
		boolean flag = true;
		String basePath = request.getSession().getServletContext().getRealPath("");
		String pdfDir = basePath + MacroConstant.PDFDIR;
		System.out.println("================pdfDir=================" + pdfDir);
		File[] files = new File(pdfDir).listFiles();

		String contents = "";
		String filename = "";
		String filenameFull = "";
		Document document;

		try {
			System.out.println("*********files.length**********" + files.length);
			System.out.println("*********long files[i].lastModified()**********" + files[0].lastModified());
			System.out.println("*********lu********************" + files[0].lastModified() / 1000);
			System.out.println("*********xiang****getName******" + files[0].getName());

			System.out.println("*********getCanonicalPath******" + files[0].getCanonicalPath());
			// 返回的是数据库表中最新的文件的修改时间(戳s)

			// int LatestTime =
			// docRecordService.getLatestDocument(MacroEnum.KFileExtension.pdf.toString());

			int LatestTime = 0;
			IndexWriter writer = getIndexWriter();
			for (int i = 0; i < files.length; i++) {
				System.out.println("==============i===============" + i);
				if (files[i].lastModified() / 1000 > LatestTime) {
					filenameFull = files[i].getName();
					// DocRecord docRecord = new DocRecord();
					// docRecord.setFileName(filenameFull);
					// docRecord.setDocType(MacroEnum.KFileExtension.pdf.toString());
					// docRecord.setLastModify((int) (files[i].lastModified() /
					// 1000));
					// int id = docRecordService.createDoc(docRecord);

					int id = 1;
					filename = filenameFull.substring(0, filenameFull.lastIndexOf(".pdf"));

					contents = XpdfParser.getPDFFileContents(files[i].getCanonicalPath(), filename);

					if (contents == null) {
						return false;
					} else {
						document = new Document();
						document.add(new StringField("id", "" + id, Field.Store.YES));
						document.add(
								new StringField("type", MacroEnum.KFileFormatType.pdf.toString(), Field.Store.YES));
						document.add(new StringField("fileName", filename, Field.Store.YES));
						document.add(new TextField("contents", contents, Field.Store.YES));
						writer.addDocument(document);
					}
				}
			}

			writer.close();
			// 创建完索引之后，删除txt文档
			// File file = new File(SystemConstant.PDFTxtdir);

			// if (file.exists()){
			// System.out.println("------1.1-----");
			// DelTempDir.delAllFile(file);
			// }
			// System.out.println("------end------2-");

		} catch (IOException e) {
			e.printStackTrace();
			flag = false;
		}
		return flag;
	}

	/**
	 * 创建word索引
	 */
	public static boolean createWordIndex(HttpServletRequest request) {
		boolean flag = true;
		String basePath = request.getSession().getServletContext().getRealPath("");
		String docDir = basePath + MacroConstant.DOCDIR;
		File[] files = new File(docDir).listFiles();

		try {
			System.out.println("*********1**********" + files.length);
			System.out.println("*********2**********" + files[0].lastModified());
			System.out.println("*********3**********" + files[0].lastModified() / 1000);
			System.out.println("*********4**********" + files[0].getName());
			System.out.println("*********4**********" + files[1].getName());
			System.out.println("*********4**********" + files[2].getName());
			System.out.println("*********5**********" + files[0].getCanonicalPath());
			System.out.println("*********6**********" + files[0].getAbsolutePath());

			System.out.println("*********7**********" + "==================================");

			// int LatestTime = docRecordService.getLatestDocument("doc");
			int LatestTime = 0;
			System.out.println("*********LatestTime**********" + LatestTime);

			String contents = "";
			String filenameFull = "";
			Document document; // 文档
			IndexWriter writer = getIndexWriter();
			for (int i = 0; i < files.length; i++) {
				if (files[i].lastModified() > LatestTime) {
					filenameFull = files[i].getName();

					// DocRecord docRecord = new DocRecord();
					// docRecord.setFileName(filenameFull);
					// docRecord.setDocType(MacroEnum.KFileExtension.doc.toString());
					// docRecord.setLastModify((int) (files[i].lastModified() /
					// 1000));
					// int id = docRecordService.createDoc(docRecord);

					int id = 1;
					contents = new WordExtractor(new FileInputStream(files[i].getCanonicalPath())).getText();

					// 创建文档
					document = new Document();
					document.add(new StringField("id", "" + id, Field.Store.YES));
					document.add(new StringField("type", MacroEnum.KFileFormatType.doc.toString(), Field.Store.YES));
					document.add(new StringField("fileName",
							filenameFull.substring(0, filenameFull.lastIndexOf(".doc")), Field.Store.YES));
					document.add(new TextField("contents", contents, Field.Store.YES));
					writer.addDocument(document);
				}
			}
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}
		return flag;
	}

	private static IndexWriter getIndexWriter() {
		IndexWriter writer = null;
		try {
			Directory directory = FSDirectory.open(new File(MacroConstant.INDEXDIR));
			IndexWriterConfig iwc = new IndexWriterConfig(Version.LUCENE_44, new PaodingAnalyzer());
			/* 会创建write.lock文件 */
			writer = new IndexWriter(directory, iwc);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return writer;
	}
}
