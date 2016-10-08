#include "ScrollViewExtend.h"
#include "ui/UIHelper.h"

ScrollViewExtend::ScrollViewExtend()
	:itemMargin(5.0f)
	,itemContenSize(Size(600, 100))
{
	this->setTouchEnabled(true);
}

ScrollViewExtend::~ScrollViewExtend()
{
}

ScrollViewExtend * ScrollViewExtend::create()
{
	ScrollViewExtend* widget = new (std::nothrow) ScrollViewExtend();
	if (widget && widget->init())
	{
		widget->autorelease();
		return widget;
	}
	CC_SAFE_DELETE(widget);
	return nullptr;
}

bool ScrollViewExtend::init()
{
	if (ScrollView::init())
	{
		setDirection(Direction::VERTICAL);
		return true;
	}
	return false;
}

void ScrollViewExtend::setItemsMargin(float margin)
{
	itemMargin = margin;
}

void ScrollViewExtend::setItemContentSize(const Size & size)
{
	itemContenSize = size;
}

void ScrollViewExtend::onSizeChanged()
{
	ScrollView::onSizeChanged();
	scaleRect = Rect(0, 0, _contentSize.width, _contentSize.height);
	float h = itemContenSize.height;
	auto centerRect = Rect(0, _contentSize.height / 2.0 - h / 2.0, _contentSize.width, h);
	_topBoundary = centerRect.getMaxY() - h/2.0;
	_bottomBoundary = centerRect.getMinY() - h/2.0;
	_leftBoundary = centerRect.getMinX();
	_rightBoundary = centerRect.getMaxX();
}

void ScrollViewExtend::handleReleaseLogic(Touch * touch)
{
	log("ScrollViewExtend  handleReleaseLogic");
	ScrollView::handleReleaseLogic(touch);
}

void ScrollViewExtend::moveInnerContainer(const Vec2 & deltaMove, bool canStartBounceBack)
{
	ScrollView::moveInnerContainer(deltaMove, canStartBounceBack);
	remedyChildren(deltaMove);
}

void ScrollViewExtend::scrollChildren(const Vec2 & deltaMove)
{
	//log("scroll <%f, %f> %d", deltaMove.x, deltaMove.y);
	ScrollView::scrollChildren(deltaMove);
}

void ScrollViewExtend::remedyChildren(const Vec2 & deltaMove)
{
	auto pos = getInnerContainerPosition();
	auto CSize = getContentSize();
	auto center = Vec2(CSize.width, CSize.height / 2.0);
	float radius = center.y;

	for (auto child : getChildren())
	{
		auto c_pos = child->getPosition() + pos;
		auto c_size = child->getContentSize();
		if (abs(c_pos.y - center.y) <= radius)
		{
			float R_theta = (radius - c_pos.y) / radius;
			R_theta = acosf(R_theta);

			float SizeW = c_size.width / 2.0;
			float new_W = radius * sin(R_theta);
			float p = new_W / radius;
			child->setScale(0.5+ 0.5 * p);
			child->setPositionX((radius - new_W) + (CSize.width / 2 - SizeW*p));
		}
		else
		{
			child->setScale(0.5);
			child->setPositionX(CSize.width);
		}
	}
}

Rect ScrollViewExtend::intersectionRect(const Rect & a, const Rect & rect) const
{
	auto origin = a.origin;
	auto size = a.size;

	float thisLeftX = origin.x;
	float thisRightX = origin.x + size.width;
	float thisTopY = origin.y + size.height;
	float thisBottomY = origin.y;

	if (thisRightX < thisLeftX)
	{
		std::swap(thisRightX, thisLeftX);   // This rect has negative width
	}

	if (thisTopY < thisBottomY)
	{
		std::swap(thisTopY, thisBottomY);   // This rect has negative height
	}

	float otherLeftX = rect.origin.x;
	float otherRightX = rect.origin.x + rect.size.width;
	float otherTopY = rect.origin.y + rect.size.height;
	float otherBottomY = rect.origin.y;

	if (otherRightX < otherLeftX)
	{
		std::swap(otherRightX, otherLeftX);   // Other rect has negative width
	}

	if (otherTopY < otherBottomY)
	{
		std::swap(otherTopY, otherBottomY);   // Other rect has negative height
	}

	float intersectionLeftX = std::max(thisLeftX, otherLeftX);
	float intersectionRightX = std::min(thisRightX, otherRightX);
	float intersectionTopY = std::min(thisTopY, otherTopY);
	float intersectionBottomY = std::max(thisBottomY, otherBottomY);

	return Rect(intersectionLeftX, intersectionTopY, intersectionRightX - intersectionLeftX, intersectionTopY - intersectionBottomY);
}