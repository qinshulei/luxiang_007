<%--
  Created by IntelliJ IDEA.
  User: 95
  Date: 2016/11/10
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel panel-primary" style="height:625px;display: none;" id="search_panel" >
    <div class="panel-heading">
        <h3 class="panel-title">搜索结果</h3>
    </div>
    <div class="panel-body" style="padding-top:0px;">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>文件名</th>
                <th style="padding-left:0px;">上传者</th>
                <th>上传时间</th>
                <th style="padding-left:20px;">下载</th>
                <th style="padding-left:20px;">预览</th>
                <th style="padding-left:0px;">下载量</th>
            </tr>
            </thead>
            <tbody id="search_file">

            </tbody>
        </table>
    </div>
</div>