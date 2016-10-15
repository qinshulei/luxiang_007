<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%  
   String swfFilePath=session.getAttribute("swfPath").toString();
   String fileName=swfFilePath.substring(swfFilePath.lastIndexOf("/")+1);//
   String savePath="/swf文件/"+fileName;
   System.out.println("++不错++"+savePath);
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <script type="text/javascript" src="js/jquery.min.js"></script>  
        <script type="text/javascript" src="js/flexpaper.js"></script>  
        <script type="text/javascript" src="js/flexpaper_handler.js"></script>  
        <style type="text/css" media="screen">  
html,body {  
    height: 100%;  
}  
   
body {  
    margin: 0;  
    padding: 0;  
    overflow: auto;  
}  
   
#flashContent {  
    display: none;  
}  
</style>  
        <title>文档在线预览系统</title>  
    </head>  
    <body>  
        <div style="text-align:center">
<div id="documentViewer" class="flexpaper_viewer"  style="height:650px"></div>
<script type="text/javascript">
    function getDocumentUrl(document){
        return "php/services/view.php?doc={doc}&format={format}&page={page}".replace("{doc}",document);
    }

    var startDocument = "Paper";
    
    $('#documentViewer').FlexPaperViewer(
            { config : {

                SWFFile : '<%=savePath%>',

                Scale : 2.0,   
                ZoomTransition : 'easeOut',
                ZoomTime : 0.5,
                ZoomInterval : 0.2,
                FitPageOnLoad : true,
                FitWidthOnLoad : false,
                FullScreenAsMaxWindow : false,
                ProgressiveLoading : false,
                MinZoomSize : 0.2,
                MaxZoomSize : 5,
                SearchMatchAll : false,
                InitViewMode : 'Portrait',
                RenderingOrder : 'flash',
                StartAtPage : '',

                ViewModeToolsVisible : true,
                ZoomToolsVisible : true,
                NavToolsVisible : true,
                CursorToolsVisible : true,
                SearchToolsVisible : true,
                WMode : 'window',
                localeChain: 'en_US'
            }}
    );
</script>
</div>  
    </body>  
</html> 