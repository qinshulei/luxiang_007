
$(function() {
	get_category_select_file();
	// sub.onclick = uploadFile;
})

function get_category_select_file() {
	$.ajax({
		type : 'post',
		url : "/mybatis/CategoryController/get_category.do",
		dataType : "json",
		success : function(data) {
			var _select = $(".select-class-name>option");
			_select.remove();
			var all_select_category = data["category"];
			// console.log(all_select_category.length);
			for (var i = 0; i < all_select_category.length; i++) {
				var op = "<option value='"
						+ all_select_category[i].categoryName + "'>"
						+ all_select_category[i].categoryName + "</option>";
				$(".select-class-name").append(op);
				// console.log(all_select_category[i].categoryName);
			}
		}
	})
}
function add_one_click(obj) {
	var input_id = $(obj).attr("bid");
	return $("#" + input_id).click();
}

function del_one_click(obj) {
	var input_id = $(obj).attr("bid");
	var file_name = $(obj).attr("pid");
	$("#" + input_id).val("");
	$("#" + file_name).val("");
	// if($("#"+input_id).val() == ""){//不能写$("#"+input_id).val() == null
	// alert("xx");
	// }
	// console.log($("#"+input_id).val());

}

function changeFile(obj) {
	var file = $(obj).val();
	var input_text = $(obj).attr("pid");
	var result_text = $(obj).attr("rid");
	var arr = file.split('\\');
	var filename = arr[arr.length - 1];
	var realname_arr = filename.split('.');
	var file_last = realname_arr[realname_arr.length - 1];
	if (file_last != "pdf" && file_last != "doc" && file_last != "xls"
			&& file_last != "ppt" && file_last != "txt") {
		alert("不支持选中的文件格式！！");
		$(obj).val("");
		return;
	}
	console.log("上传文件" + file_last);
	$("#" + input_text).val(filename);
	var fileid = $(obj).attr("id");
	console.log(file);
	$.ajaxFileUpload({
		url : "/mybatis/FileUploadController/fileUpload.do",
		secureuri : false,
		fileElementId : fileid,
		data : {},
		dataType : 'json',
		success : function(data) {
			$("#info-p").html(data["message"]);
			$("#info-modal").modal("show");
			$("#" + result_text).val(data["dirPath"]);
		},
		error : function(data) {
			$("#info-p").html("网络故障，请稍后重试！！！");
			$("#info-modal").modal("show");
		}
	})
}

function changeFile_test(obj) {
	var file = $(obj).val();
	console.log(file);
	$.ajaxFileUpload({
		url : "/mybatis/FileUploadController/fileUpload.do",
		secureuri : false,
		data : {
			"filename" : "hahah",
			"age" : "12",
			"sex" : "man"
		},
		fileElementId : 'file-test',
		dataType : 'json',
		success : function(data) {
			alert(data["message"]);
		}
	})
}

// 上传文件信息
function uploadFile() {
	// var src = "/mybatis/FileUploadController/fileUpload.do";
	var aim1 = $("#aim1"), aim2 = $("#aim2"), aim3 = $("#aim3");
	var word1 = $("#word1"), word2 = $("#word2"), word3 = $("#word3");
	var area1 = $("#area1"), area2 = $("#area2"), area3 = $("#area3");
	var proto1 = $("#proto1"), proto2 = $("#proto2"), proto3 = $("#proto3");
	var file1 = $("#file-test1").val();
	var file2 = $("#file-test2").val();
	var file3 = $("#file-test3").val();
	var path1 = $("#file_result1").val();
	var path2 = $("#file_result2").val();
	var path3 = $("#file_result3").val();
	if (aim1.val() == "" && aim2.val() == "" && aim3.val() == "") {
		alert("请选择上传的文件");
		return false;
	}else if(((aim1.val() != "")&&(proto1.val()=="私有" ))
			|| ((aim2.val() != "")&&(proto2.val()=="私有" )) 
			|| ((aim3.val() != "")&&(proto3.val()=="私有" ))){
		return true;
	}
	else if ((aim2.val() != "")
			&& ((area2.val() == "") || (word2.val() == ""))) {

		alert("请完善文件2信息");
		return false;

	} else if ((aim1.val() != "")
			&& ((area1.val() == "") || (word1.val() == ""))) {

		alert("请完善文件1信息");
		return false;

	} else if ((aim3.val() != "")
			&& ((area3.val() == "") || (word3.val() == ""))) {

		alert("请完善文件3信息");
		return false;
	} else {
		var data = {};
		if (aim1.val() != "" && area1.val() != "" && word1.val() != "") {

			data.filepath1 = path1;
			var name1 = aim1.val().split(".");
			// console.log(name1[0]);
			data.filename1 = name1[0];
			data.author1 = $("#author1").attr("placeholder");
			// console.log($("#author1").val()+"!!!!!!!");
			// data.time1 = $("#time1").attr("placeholder");
			data.word1 = word1.val();
			data.pro1 = $("#proto1").val();
			data.cate1 = $("#cate1").val();
			data.area1 = area1.val();
		}
		if (aim2.val() != "" && area2.val() != "" && word2.val() != "") {
			data.filepath2 = path2;
			var name2 = aim2.val().split(".");
			// console.log(name1[0]);
			data.filename2 = name2[0];
			data.author2 = $("#author2").attr("placeholder");
			// data.time2 = $("#time2").attr("placeholder");
			data.word2 = word2.val();
			data.pro2 = $("#proto2").val();
			data.cate2 = $("#cate2").val();
			data.area2 = area2.val();
		}
		if (aim3.val() != "" && area3.val() != "" && word3.val() != "") {
			data.filepath3 = path3;
			var name3 = aim3.val().split(".");
			// console.log(name1[0]);
			data.filename3 = name3[0];
			data.author3 = $("#author3").attr("placeholder");
			// data.time3 = $("#time3").attr("placeholder");
			data.word3 = word3.val();
			data.pro3 = $("#proto3").val();
			data.cate3 = $("#cate3").val();
			data.area3 = area3.val();
		}
		console.log(data);
		sendAjaxRequest("/mybatis/FileInfoController/add_file_info.do", data,
				upload_success_cb, function() {
					alert("网络故障，请稍后重试！！！")
				});
	}
}

// 文件上传成功，清空页面内容
function upload_success_cb(data) {
	var message1 = "";
	var message2 = "";
	var message3 = "";
	var cate = $("#cate1>option:eq(0)").val();
	var info = "";
	if (data["message1"] != null) {
		// console.log(data["result1"]);
		if (data["result1"] == true) {
			message1 = "文件1上传成功!";
			$("#file-test1").val("");
			$("#file-result1").val("");
			$("#aim1").val("");
			$("#proto1").val("私有");
			$("#word1").val("");
			$("#area1").val("");
			$("#cate1").val(cate);
		} else {
			message1 = "文件1上传失败!";
		}
	}
	if (data["message2"] != null) {
		// console.log(data["result2"]);
		if (data["result2"] == true) {
			message2 = "文件2上传成功!";
			$("#file-test2").val("");
			$("#file-result2").val("");
			$("#aim2").val("");
			$("#proto2").val("私有");
			$("#word2").val("");
			$("#area2").val("");
			$("#cate2").val(cate);
		} else {
			message2 = "文件2上传失败!";
		}
	}
	if (data["message3"] != null) {
		// console.log(data["result3"]);
		if (data["result3"] == true) {
			message3 = "文件3上传成功!";
			$("#file-test3").val("");
			$("#file-result3").val("");
			$("#aim3").val("");
			$("#proto3").val("私有");
			$("#word3").val("");
			$("#area3").val("");
			$("#cate3").val(cate);
		} else {
			message3 = "文件3上传失败!";
		}
	}
	info = message1 + message2 + message3;
	if (info != "") {
		$("#info-p").html(info);
		$("#info-modal").modal("show");
	}
}