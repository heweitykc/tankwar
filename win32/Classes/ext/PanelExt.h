#ifndef __PANEL_EXTEND_H__
#define __PANEL_EXTEND_H__
#include "cocos2d.h"
#include "cocostudio/CocoStudio.h"
#include "ui/CocosGUI.h"

USING_NS_CC;
using namespace cocos2d::ui;
class PanelExt : public Layout
{
	class AnnularListNode
	{
	public:
		Node* _node;
		AnnularListNode* _next;
		AnnularListNode* _pre;
		AnnularListNode():
			_node(nullptr)
			,_next(nullptr)
			,_pre(nullptr)
		{

		}

		~AnnularListNode()
		{
			_node = nullptr;
			_next = nullptr;
			_pre = nullptr;
			log("~AnnularListNode");
		}
	};

	enum LoopType 
	{
		TYPE1 = 0,
		TYPE2
	};

public:
	PanelExt();
	virtual ~PanelExt();

	static PanelExt* create();
	virtual bool init() override;

	void pushBackItem(Widget* item);
	void moveItems(const Vec2& deltaMove);

	bool onTouchBegan(cocos2d::Touch *touch, cocos2d::Event *unusedEvent);
	void onTouchMoved(cocos2d::Touch *touch, cocos2d::Event *unusedEvent);
	void onTouchEnded(cocos2d::Touch *touch, cocos2d::Event *unusedEvent);
	void onTouchCancelled(cocos2d::Touch *touch, cocos2d::Event *unusedEvent);

	//const Vec2 getInnerContainerPosition() const;

	void setItemsMargin(float margin);

	virtual void update(float dt) override;

	virtual void onEnter() override;
protected:
	virtual void handlePressLogic(cocos2d::Touch *touch);
	virtual void handleMoveLogic(cocos2d::Touch *touch);
	virtual void handleReleaseLogic(cocos2d::Touch *touch);

	virtual void interceptTouchEvent(Widget::TouchEventType event, Widget* sender, Touch *touch) override;

	virtual void initRenderer() override;
	virtual void onSizeChanged() override;

	bool calculateCurrAndPrevTouchPoints(Touch* touch, Vec3* currPt, Vec3* prevPt);

	virtual void scrollChildren(const Vec2& deltaMove);

	void OutOfBoundary(const Vec2& deltaMove);
	bool isInner(const Vec2& pos);
	void ScaleItem();

	void processAutoScrolling(float deltaTime);

	Vec2 flattenVectorByDirection(const Vec2& vector);

	virtual void startAttenuatingAutoScroll(const Vec2& deltaMove, const Vec2& initialVelocity);
	void startAutoScroll(const Vec2& deltaMove, float timeInSec, bool attenuated);

	void gatherTouchMove(const Vec2& delta);
	Vec2 calculateTouchMoveVelocity() const;

	void startInertiaScroll(const Vec2& touchMoveVelocity);
private:
	AnnularListNode* _headNode;
	AnnularListNode* _curNode;

	Node* _begin_item;
	Node* _end_item;

	Vec2 _NodePos;

	Vec2 _autoScrollTargetDelta;
	bool _autoScrollAttenuate;

	LoopType _LOOPTYPE;

	float _rad_180;
	float _itemMargin;

	float _childFocusCancelOffsetInInch;
	bool _autoScrolling;

	float _autoScrollTotalTime;
	float _autoScrollAccumulatedTime;

	bool _inertiaScrollEnabled;

	// Touch move speed
	std::list<Vec2> _touchMoveDisplacements;
	std::list<float> _touchMoveTimeDeltas;
	long long _touchMovePreviousTimestamp;
	float _touchTotalTimeThreshold;

	float _percentage;
	float _basic_scale;
};

#endif//__PANEL_EXTEND_H__