package com.km.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.km.model.dto.ChattingData;
import com.km.model.service.ChattingService;

public class ChattingServer extends TextWebSocketHandler {
	@Autowired
	private ChattingService chattingService;
	
	private Map<String,WebSocketSession> clients=new HashMap<>();
	//DB저장전 데이터를 임시 보관
	// 데이터가 100가 되면 DB에 일괄저장 후 초기화
	private List<ChattingData> cacheData=new ArrayList<>();
	
	private ObjectMapper mapper=new ObjectMapper();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		ChattingData msg=mapper.readValue(message.getPayload(), ChattingData.class);
		System.out.println(msg);
		switch(msg.getChattingCategory()) {
			case "open" : addClient(msg,session); break;
			case "msg": sendMessage(msg); break;
		}
		
		
		
	}


	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
	}
	
	private void sendMessage(ChattingData msg) {
		
	}
	
	private void addClient(ChattingData msg,WebSocketSession session) {
		clients.put(msg.getSender(), session);
	}
}
