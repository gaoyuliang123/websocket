package com.tgl.websocket;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
/**
 * 1, WebSocket可以通过注解的方式声明  @ServerEndpoint("/serverEndpoint")
 * 2, 添加注解之后需要在配置文件中返回, 在配置文件中可以过滤
 * 3, WebSocket 和 Servlet 相同都是多例的, 不会互相干扰
 * 4, WebSocket 请求时访问 open  方法, 可以用注解 @OnOpen 标明
 * 5, WebSocket 关闭时访问 close 方法, 可以用注解 @OnClose 表名
 */
@ServerEndpoint("/serverEndpoint")
public class WebsocketDemo {
    @OnOpen
    public void open(Session session) {
        String id = session.getId();
        System.out.println("通道" + id + "打开");
    }
    @OnClose
    public void close(Session session) {
        String id = session.getId();
        try {
            session.close();
            System.out.println("通道" + id + "关闭成功");
        } catch (Exception e) {
            System.out.println("通道" + id + "关闭失败");
            e.printStackTrace();
        }
    }
    @OnMessage
    public void message(Session session, String msg) {
        String id = session.getId();
        String outMessage = "客户端" + id + "说：" + msg;
        System.out.println(outMessage);
        String returnMessage = "你刚才说：" + msg;
        try {
            session.getBasicRemote().sendText(returnMessage);
        } catch (IOException e) {
            System.out.println(" 返回数据失败");
            e.printStackTrace();
        }

    }
}
