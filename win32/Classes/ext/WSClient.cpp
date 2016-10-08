#include "WSClient.h"

USING_NS_CC;
using namespace std;

WSClient::WSClient():
	_ws(nullptr)
{	
	status = WS_BROKEN;
}

WSClient::~WSClient()
{
	if (_ws)
		_ws->close();
	CC_SAFE_DELETE(_ws);
}

void WSClient::connect(const char* addr)
{	
	//已连接状态
	if (WS_CONNECTED == status || WS_CONNECTING == status)
		return;

	log("connect %s", addr);
	status = WS_CONNECTING;
	this->addr = addr;
	_ws = new network::WebSocket();
	if (!_ws->init(*this, addr))
	{
		CC_SAFE_DELETE(_ws);
		log("%s  connect failed..", addr);		
	}	
}

void WSClient::close()
{
	if (_ws)
		_ws->close();
	_ws = nullptr;
	status = WS_BROKEN;
}

void WSClient::onOpen(network::WebSocket* ws)
{
	log("%s  connection opened..", addr.c_str());
	startpos = endpos = 0;	
	netbuffer[RECV_BUFFER_LEN - 1] = (char)0xEF;	//结尾标记
	status = WS_CONNECTED;

	while (!msglist.empty()) msglist.pop();
}

void WSClient::onMessage(network::WebSocket* ws, const network::WebSocket::Data& data)
{			
	memcpy(netbuffer + endpos, data.bytes, data.len);
	endpos += data.len;

	parse();
}

void WSClient::onClose(network::WebSocket* ws)
{
	if (ws == this->_ws)
	{
		this->_ws = nullptr;
	}
	CC_SAFE_DELETE(ws);
	status = WS_BROKEN;
	while (!msglist.empty()) msglist.pop();
}

void WSClient::onError(network::WebSocket* ws, const network::WebSocket::ErrorCode& error)
{
	log("Error was fired, error code: %d", static_cast<int>(error));
	status = WS_BROKEN;
	while (!msglist.empty()) msglist.pop();
}

void WSClient::parse()
{
	CC_ASSERT(endpos < (RECV_BUFFER_LEN - 1));
	char* p = netbuffer + RECV_BUFFER_LEN - 1;
	CC_ASSERT((unsigned char)(*p) == (unsigned char)0xEF);

	if (startpos == endpos) return;
	unsigned char* temp = (unsigned char*)(netbuffer + startpos + 1);
	int c0 = *(temp + 4);
	int c1 = (*(temp + 3) << 8);
	int c2 = (*(temp + 2) << 16);
	int c3 = (*(temp + 1) << 24);

	int len = c0 + c1 + c2 + c3;

	if ((endpos - startpos) < (len + 10)){
		return;
	}
	
	memset(msgbuffer, 0, RECV_BUFFER_LEN);
	memcpy(msgbuffer, netbuffer + startpos + 10, len);

	std::string jsonstr(msgbuffer);
	msglist.push(jsonstr);

	startpos += (10 + len);
	if (startpos == endpos){
		startpos = endpos = 0;
	}
	parse();
}

void WSClient::send(const char* msg, unsigned int len)
{
	unsigned char buff[SEND_BUFFER_LEN] = {0};
	buff[0] = 0x01;
	buff[1] = 0x01;
	unsigned char* p = (unsigned char*)&len;
	buff[2] = *(p+3);
	buff[3] = *(p+2);
	buff[4] = *(p+1);
	buff[5] = *(p);

	buff[6] = 0;
	buff[7] = 0;
	buff[8] = 0;
	buff[9] = 0;

	memcpy(buff + 10, msg, len);
	_ws->send(buff, len + 10);
}
