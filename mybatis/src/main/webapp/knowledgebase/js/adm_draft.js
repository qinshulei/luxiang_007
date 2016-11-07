/**
 * Created by 95 on 2016/11/7.
 */
//草稿箱页面出来，加载表格
$(function(){
    get_all_draft_file();

})



//获取我的所有草稿箱文件
function get_all_draft_file(){
    $.ajax({
        type:'post',
        url:"/mybatis/FileInfoController/draftfile.do",
        dataType:"json",
        success:function(data){
            var _table = $("#draft_file>tr");
            _table.remove();
            var all_draft_file = data["all_file"];
            for(var i = 0;i < all_draft_file.length;i++){
                var tr_begin = "<tr>";
                var tr_end = "</tr>";
                var td_1 = "<td style='padding-top:15px;'><input type='checkbox' name='checkAll' onclick='select_one(this)' value="+all_draft_file[i].fileId+"></td>"
                var td_2 = "<td style='padding-top:15px;width:180px;' id="+all_draft_file[i].fileId+">"+all_draft_file[i].fileName+"</td>";
                var td_3 = "<td><button class='btn btn-primary' data-toggle='modal'data-target='' onclick=''>下载</button></td>";
                var td_4 = "<td><button class='btn btn-primary' data-toggle='modal'data-target='' onclick=''>预览</button></td>";
                var td_5 = "<td><button class='btn btn-primary' onclick='delete_one_file(this)' value="+all_draft_file[i].fileId+">删除</button></td>";
                var td_6 = "<td><button class='btn btn-primary'  onclick='recovery_one_file(this)' value="+all_draft_file[i].fileId+">恢复</button></td>";
                var content = tr_begin  + td_1 + td_2 + td_3 + td_4 + td_5 +td_6+ tr_end;
                $("#draft_file").append(content);
            }
        }
    })
}

function recovery(recovery_array){
    //var file_id = $(obj).attr("value");
    //console.log(file_id);
    //var recovery_array = [];
    //recovery_array.push(file_id);
    //console.log(recovery_array);
    $.ajax({
        type:'post',
        url:"/mybatis/FileInfoController/recovery_file.do",
        dataType:"json",
        traditional:true,
        data:{"recovery_array":recovery_array},
        success:function(data)
        {
            if(data["flag"]){
                get_all_draft_file();
            }else{
                alert("网络故障，请稍后重试");
            }

        }
    })
}

function deleteFile(delete_array){
    $.ajax({
        type:'post',
        url:"/mybatis/FileInfoController/delete_file.do",
        dataType:"json",
        traditional:true,
        data:{"delete_array":delete_array},
        success:function(data)
        {
            if(data["flag"]){

                get_all_draft_file();
            }else{
                alert("网络故障,稍后重试");
            }

        }
    })
}

function delete_one_file(obj){
    var file_id = $(obj).attr("value");
    var delete_array = [];
    delete_array.push(file_id);
    deleteFile(delete_array);
}



function delete_all_file_modal(obj){
    var delete_count = 0;
    $("input[name=checkAll]").each(function(){
        if($(this).is(':checked')){
            delete_count += 1;
        }
    });
    console.log("选中的文件个数："+delete_count);
    if(delete_count == 0){
        $(obj).attr({"data-toggle":"modal","data-target":"#delete-modal"});
        $("#myModalLabel-delete_title").html("删除文件提示");
        $("#delete_p_info").html("请选择需要删除的文件");
    }else{
        $(obj).attr({"data-toggle":"modal","data-target":"#delete-modal"});
        $("#myModalLabel-delete_title").html("删除文件提示");

        $("#delete_p_info").html("确定删除选中文件？此次删除后不可恢复");
        $("#ok_btn").attr("onclick","delete_selected_file()");
    }
}

function delete_selected_file(){
    var delete_array = [];
    $("input[name=checkAll]").each(function(){
        if($(this).is(':checked')){
            var arr = $(this).attr("value");
            delete_array.push(arr);
        }
    });
    deleteFile(delete_array);
}
function recovery_one_file(obj){
    var file_id = $(obj).attr("value");
    //console.log(file_id);
    var recovery_array = [];
    recovery_array.push(file_id);
    recovery(recovery_array);
}
function recovery_all_file_modal(obj){
    var recovery_count = 0;
    $("input[name=checkAll]").each(function(){
        if($(this).is(':checked')){
            recovery_count += 1;
        }
    });
    console.log("选中的文件个数："+recovery_count);
    if(recovery_count == 0){
        $(obj).attr({"data-toggle":"modal","data-target":"#delete-modal"});
        $("#myModalLabel-delete_title").html("恢复文件提示");
        $("#delete_p_info").html("请选择需要恢复的文件");
    }else{
        $(obj).attr({"data-toggle":"modal","data-target":"#delete-modal"});
        $("#myModalLabel-delete_title").html("恢复文件提示");

        $("#delete_p_info").html("确定恢复选中文件？");
        $("#ok_btn").attr("onclick","recovery_selected_file()");
    }
}
function recovery_selected_file(){
    var recovery_array = [];
    $("input[name=checkAll]").each(function(){
        if($(this).is(':checked')){
            var arr = $(this).attr("value");
            recovery_array.push(arr);
        }
    });
    recovery(recovery_array);
}