<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>WebSocket</title>
    <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
</head>
<body>
    <input id="message" type="text" value=""/>
    <input id="send" type="button" value="发送" /><br/>
    <div id="returnMessage"></div><br/>
    <input id="createWebsocket" type="button" value="创建WebSocket"/>
    <input id="close" type="button" value="关闭Websocket" />
</body>
<script type="text/javascript">
    /**
     *  创建WebSocket
     *  WebScoket 的地址为ws协议
     */
    function createWebSocket(url) {
        if ("WebSocket" in window) {
            return new WebSocket(url);
        }
        if ("MozWebSocket" in window) {
            return new MozWebSocket(url);
        }
        console.error("浏览器不支持WebSocket");
    }

    var webSocket = null;
    var urlValue = "ws://127.0.0.1:8080/serverEndpoint";
    $('#createWebsocket').on('click ', function () {
        webSocket = createWebSocket(urlValue);
        webSocket.onmessage = function (msg) {
            console.log(msg.data);
        }
        webSocket.onclose = function () {
            console.log(arguments);
        }
    });
    /**
     * close
     */
    $('#close').on('click',function () {
        if (null != webSocket) {
            webSocket.close();

        }
    });
    /**
     * send
     */
    $('#send').on('click',function(){
        var message = $('#message').val().trim();
        if(message == ""){
            console.error("发送的内容不能为空!");
            return;
        }
        if (webSocket == null) {
            console.error("未创建WebSocket");
            return;
        }
        webSocket.send(message);
        $('#message').val("");
    });

</script>
</html>
