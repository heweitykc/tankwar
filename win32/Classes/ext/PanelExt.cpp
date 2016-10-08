#include "PanelExt.h"
#include "ui/UIHelper.h"

#define MOVE_INCH            7.0f/160.0f
static const int NUMBER_OF_GATHERED_TOUCHES_FOR_MOVE_SPEED = 5;
static const float OUT_OF_BOUNDARY_BREAKING_FACTOR = 0.05f;

static float convertDistanceFromPointToInch(const Vec2& dis)
{
	auto glview = Director::getInstance()->getOpenGLView();
	int dpi = Device::getDPI();
	float distance = Vec2(dis.x * glview->getScaleX() / dpi, dis.y * glview->getScaleY() / dpi).getLength();
	return distance;
}

PanelExt::PanelExt():
  _begin_item(nullptr)
, _end_item(nullptr)
, _rad_180(CC_DEGREES_TO_RADIANS(180))
, _itemMargin(0.0f)
, _NodePos(Vec2::ZERO)
, _LOOPTYPE(LoopType::TYPE1)
, _headNode(nullptr)
, _curNode(nullptr)
, _childFocusCancelOffsetInInch(MOVE_INCH)
, _autoScrolling(false)
, _autoScrollTotalTime(0)
, _autoScrollAccumulatedTime(0)
, _touchTotalTimeThreshold(0.5f)
, _inertiaScrollEnabled(true)
, _autoScrollAttenuate(true)
, _basic_scale(0.5f)
{
	setTouchEnabled(true);
}

PanelExt::~PanelExt()
{
	
	AnnularListNode* cur = _headNode;
	do
	{
		AnnularListNode* next = cur->_next;
		delete cur;
		cur = next;
	} while (cur != _headNode);

	_begin_item = nullptr;
	_end_item = nullptr;
	_headNode = nullptr;
	_curNode = nullptr;


	log("~PanelExt");
}

PanelExt * PanelExt::create()
{
	PanelExt* layout = new (std::nothrow) PanelExt();
	if (layout && layout->init())
	{
		layout->autorelease();
		return layout;
	}
	CC_SAFE_DELETE(layout);
	return nullptr;
}

bool PanelExt::init()
{
	if (Layout::init())
	{
		setClippingEnabled(true);
		return true;
	}
	return false;
}

void PanelExt::pushBackItem(Widget * item)
{
	item->setPositionX(getContentSize().width / 2.0f);
	item->setSwallowTouches(false);
	addChild(item);


	if (_headNode == nullptr)
	{
		auto head = new AnnularListNode();
		head->_node = item;
		head->_next = head;
		head->_pre = head;

		_headNode = _curNode = head;
	}
	else
	{
		auto node = new AnnularListNode();
		node->_node = item;
		node->_next = _headNode;
		node->_pre = _curNode;

		_curNode->_next = node;
		_headNode->_pre = node;

		_curNode = node;
	}

	if (_begin_item == nullptr)
	{
		_begin_item = item;
	}

	if (_begin_item != item)
	{
		auto end_pos = _end_item->getPosition();
		end_pos.y -= (_itemMargin + item->getContentSize().height * _basic_scale);
		item->setPosition(end_pos);
	}

	_end_item = item;
}

bool PanelExt::onTouchBegan(cocos2d::Touch * touch, cocos2d::Event * unusedEvent)
{
	bool pass = Layout::onTouchBegan(touch, unusedEvent);
	if (!_isInterceptTouch)
	{
		if (_hitted)
		{
			handlePressLogic(touch);
		}
	}
	return pass;
}

void PanelExt::onTouchMoved(cocos2d::Touch * touch, cocos2d::Event * unusedEvent)
{
	Layout::onTouchMoved(touch, unusedEvent);
	if (!_isInterceptTouch)
	{
		handleMoveLogic(touch);
	}
}

void PanelExt::onTouchEnded(cocos2d::Touch * touch, cocos2d::Event * unusedEvent)
{
	Layout::onTouchEnded(touch, unusedEvent);
	if (!_isInterceptTouch)
	{
		handleReleaseLogic(touch);
	}
	_isInterceptTouch = false;
}

void PanelExt::onTouchCancelled(cocos2d::Touch * touch, cocos2d::Event * unusedEvent)
{
	Layout::onTouchCancelled(touch, unusedEvent);
	if (!_isInterceptTouch)
	{
		handleReleaseLogic(touch);
	}
	_isInterceptTouch = false;
}

void PanelExt::setItemsMargin(float margin)
{
	_itemMargin = margin;
}

void PanelExt::update(float dt)
{
	if (_autoScrolling)
	{
		processAutoScrolling(dt);
	}
}

void PanelExt::onEnter()
{
	Layout::onEnter();
	scheduleUpdate();
}

void PanelExt::handlePressLogic(cocos2d::Touch * touch)
{
	_autoScrolling = false;

	// Clear gathered touch move information
	{
		_touchMovePreviousTimestamp = utils::getTimeInMilliseconds();
		_touchMoveDisplacements.clear();
		_touchMoveTimeDeltas.clear();
	}
}

void PanelExt::handleMoveLogic(cocos2d::Touch * touch)
{
	//log("handleMoveLogic");
	Vec3 currPt, prevPt;
	if (!calculateCurrAndPrevTouchPoints(touch, &currPt, &prevPt))
	{
		return;
	}
	
	Vec3 delta3 = currPt - prevPt;
	Vec2 delta(delta3.x, delta3.y);

	moveItems(delta);

	// Gather touch move information for speed calculation
	gatherTouchMove(delta);
}

void PanelExt::handleReleaseLogic(cocos2d::Touch * touch)
{
	Vec3 currPt, prevPt;
	if (calculateCurrAndPrevTouchPoints(touch, &currPt, &prevPt))
	{
		Vec3 delta3 = currPt - prevPt;
		Vec2 delta(delta3.x, delta3.y);
		gatherTouchMove(delta);
	}
	if (_inertiaScrollEnabled)
	{
		Vec2 touchMoveVelocity = calculateTouchMoveVelocity();
		if (touchMoveVelocity != Vec2::ZERO)
		{
			startInertiaScroll(touchMoveVelocity);
		}
	}
}

void PanelExt::interceptTouchEvent(Widget::TouchEventType event, Widget * sender, Touch * touch)
{
	if (!_touchEnabled)
	{
		Layout::interceptTouchEvent(event, sender, touch);
		return;
	}

	Vec2 touchPoint = touch->getLocation();
	switch (event)
	{
	case TouchEventType::BEGAN:
	{
		_isInterceptTouch = true;
		_isInterceptTouch;
		_touchBeganPosition = touch->getLocation();
		handlePressLogic(touch);
	}
	break;
	case TouchEventType::MOVED:
	{
		_touchMovePosition = touch->getLocation();
		float offsetInInch = 0;
		offsetInInch = convertDistanceFromPointToInch(Vec2(0, fabs(sender->getTouchBeganPosition().y - touchPoint.y)));
		if (offsetInInch > _childFocusCancelOffsetInInch)
		{
			sender->setHighlighted(false);
			handleMoveLogic(touch);
		}

	}
	break;

	case TouchEventType::CANCELED:
	case TouchEventType::ENDED:
	{
		_touchEndPosition = touch->getLocation();
		handleReleaseLogic(touch);
		if (sender->isSwallowTouches())
		{
			_isInterceptTouch = false;
		}
	}
	break;
	}
}

void PanelExt::initRenderer()
{
	Layout::initRenderer();
}

void PanelExt::onSizeChanged()
{
	Layout::onSizeChanged();

	_NodePos = Vec2(_contentSize.width / 2.0, _NodePos.y);
}

bool PanelExt::calculateCurrAndPrevTouchPoints(Touch * touch, Vec3 * currPt, Vec3 * prevPt)
{
	if (nullptr == _hittedByCamera ||
		false == hitTest(touch->getLocation(), _hittedByCamera, currPt) ||
		false == hitTest(touch->getPreviousLocation(), _hittedByCamera, prevPt))
	{
		return false;
	}
	return true;
}

void PanelExt::moveItems(const Vec2 & deltaMove)
{
	scrollChildren(deltaMove);
	OutOfBoundary(deltaMove);
	ScaleItem();
}

void PanelExt::scrollChildren(const Vec2 & deltaMove)
{
	AnnularListNode* cur = _headNode;
	do
	{
		auto item = cur->_node;
		auto item_newPosY = item->getPositionY() + deltaMove.y;
		item->setPositionY(item_newPosY);

		cur = cur->_next;
	} while (cur != _headNode);
}

void PanelExt::OutOfBoundary(const Vec2 & deltaMove)
{
	AnnularListNode* cur = _headNode;
	auto CSize = getContentSize();
	if (deltaMove.y > 0)
	{//up
		do
		{
			auto item = cur->_node;
			auto item_newPosY = item->getPositionY();
			auto itemSize = item->getContentSize();
			auto ac_pos = item->getAnchorPoint();
			float scale_y = item->getScaleY();

			if (item_newPosY - ac_pos.y * itemSize.height * scale_y >= CSize.height)
			{
				auto end = cur->_pre;
				item_newPosY = end->_node->getPositionY()
					- (_itemMargin + item->getContentSize().height * _basic_scale);
				item->setPositionY(item_newPosY);
				_headNode = cur->_next;
			}
			else
			{
				break;
			}
			cur = cur->_next;
		} while (true);
	}
	else
	{//down
		do
		{
			cur = cur->_pre;
			auto item = cur->_node;
			auto item_newPosY = item->getPositionY();
			auto itemSize = item->getContentSize();
			auto ac_pos = item->getAnchorPoint();
			float scale_y = item->getScaleY();

			if (item_newPosY + (1 - ac_pos.y) * itemSize.height * scale_y <= 0)
			{
				auto next = cur->_next;
				item_newPosY = next->_node->getPositionY()
					+ (_itemMargin + item->getContentSize().height * _basic_scale);
				item->setPositionY(item_newPosY);
				_headNode = cur;
			}
			else
			{
				break;
			}
		} while (true);
	}
}

bool PanelExt::isInner(const Vec2 & pos)
{
	return  (pos.y >= 0 && pos.y <= getContentSize().height);
}

void PanelExt::ScaleItem()
{
	auto center = getContentSize() / 2.0f;
	AnnularListNode* cur = _headNode;
	do
	{
		auto item = cur->_node;
		auto item_Pos = item->getPosition();
		float dis_center = abs(item_Pos.y - center.height);
		item->setLocalZOrder(center.height - dis_center);
		if (isInner(item_Pos))
		{
			float p = 1 - dis_center / center.height;
			item->setScale(_basic_scale + (1 - _basic_scale) * p);
		}
		else
		{
			item->setScale(_basic_scale);
		}
		cur = cur->_next;
	} while (cur != _headNode);
}

void PanelExt::processAutoScrolling(float deltaTime)
{
	float brakingFactor = OUT_OF_BOUNDARY_BREAKING_FACTOR;

	// Elapsed time
	_autoScrollAccumulatedTime += deltaTime * (1 / brakingFactor);

	// Calculate the progress percentage
	float percentage = MIN(1, _autoScrollAccumulatedTime / _autoScrollTotalTime);
	//if (_autoScrollAttenuate)
	//{
	//	// Use quintic(5th degree) polynomial
	//	percentage = tweenfunc::quintEaseOut(percentage);
	//}
	percentage = tweenfunc::quintEaseOut(percentage);
	Vec2 deltaMove =  _autoScrollTargetDelta * percentage;
	_percentage = percentage;
	bool reachedEnd = (percentage == 1);

	// Finish auto scroll if it ended
	if (reachedEnd)
	{
		_autoScrolling = false;
	}

	moveItems(deltaMove);
}

Vec2 PanelExt::flattenVectorByDirection(const Vec2 & vector)
{
	Vec2 result = vector;
	result.x = 0;

	return result;
}

static float calculateAutoScrollTimeByInitialSpeed(float initialSpeed)
{
	// Calculate the time from the initial speed according to quintic polynomial.
	float time = sqrtf(sqrtf(initialSpeed / 5));
	return time;
}

void PanelExt::startAttenuatingAutoScroll(const Vec2 & deltaMove, const Vec2 & initialVelocity)
{
	float time = calculateAutoScrollTimeByInitialSpeed(initialVelocity.length());
	startAutoScroll(deltaMove, time, true);
}

void PanelExt::startAutoScroll(const Vec2 & deltaMove, float timeInSec, bool attenuated)
{
	Vec2 adjustedDeltaMove = flattenVectorByDirection(deltaMove);

	_autoScrolling = true;
	_autoScrollTargetDelta = adjustedDeltaMove;
	_autoScrollAttenuate = attenuated;
	_autoScrollTotalTime = timeInSec;
	_autoScrollAccumulatedTime = 0;
	_percentage = 0.0f;
}

void PanelExt::gatherTouchMove(const Vec2 & delta)
{
	while (_touchMoveDisplacements.size() >= NUMBER_OF_GATHERED_TOUCHES_FOR_MOVE_SPEED)
	{
		_touchMoveDisplacements.pop_front();
		_touchMoveTimeDeltas.pop_front();
	}
	_touchMoveDisplacements.push_back(delta);

	long long timestamp = utils::getTimeInMilliseconds();
	_touchMoveTimeDeltas.push_back((timestamp - _touchMovePreviousTimestamp) / 1000.0f);
	_touchMovePreviousTimestamp = timestamp;
}

Vec2 PanelExt::calculateTouchMoveVelocity() const
{
	float totalTime = 0;
	for (auto &timeDelta : _touchMoveTimeDeltas)
	{
		totalTime += timeDelta;
	}
	if (totalTime == 0 || totalTime >= _touchTotalTimeThreshold)
	{
		return Vec2::ZERO;
	}

	Vec2 totalMovement;
	for (auto &displacement : _touchMoveDisplacements)
	{
		totalMovement += displacement;
	}
	totalMovement = totalMovement / totalTime;
	return totalMovement;
}

void PanelExt::startInertiaScroll(const Vec2 & touchMoveVelocity)
{
	const float MOVEMENT_FACTOR = 0.7f;
	Vec2 inertiaTotalMovement = touchMoveVelocity * MOVEMENT_FACTOR;
	startAttenuatingAutoScroll(inertiaTotalMovement, touchMoveVelocity);
}