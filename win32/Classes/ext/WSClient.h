#ifndef __WS_CLIENT_H__
#define __WS_CLIENT_H__

#include "cocos2d.h"
#include "extensions/cocos-ext.h"
#include "network/WebSocket.h"

#define RECV_BUFFER_LEN 2048 * 1024
#define SEND_BUFFER_LEN 1024

#define WS_CONNECTED 0
#define WS_BROKEN 1
#define WS_ERROR 2
#define WS_CONNECTING 3

class  WSClient : public cocos2d::network::WebSocket::Delegate
{
public:
	WSClient();
	virtual ~WSClient();
	void connect(const char* addr);
	virtual void onOpen(cocos2d::network::WebSocket* ws)override;
	virtual void onMessage(cocos2d::network::WebSocket* ws, const cocos2d::network::WebSocket::Data& data)override;
	virtual void onClose(cocos2d::network::WebSocket* ws)override;
	virtual void onError(cocos2d::network::WebSocket* ws, const cocos2d::network::WebSocket::ErrorCode& error)override;

	void send(const char* msg, unsigned int len);
	void close();
	int status;		//当前状态 0:正常 1:未连接 2:连接出错
	std::queue<std::string> msglist;
private:
	cocos2d::network::WebSocket* _ws;
	std::string addr;	

	char netbuffer[RECV_BUFFER_LEN];
	char msgbuffer[RECV_BUFFER_LEN];
	int startpos;
	int endpos;

	void parse();
};

#endif
