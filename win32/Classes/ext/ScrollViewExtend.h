#ifndef __SCROLLVIEW_EXTEND_H__
#define __SCROLLVIEW_EXTEND_H__
#include "cocos2d.h"
#include "cocostudio/CocoStudio.h"
#include "ui/CocosGUI.h"

USING_NS_CC;
using namespace cocos2d::ui;
class ScrollViewExtend : public ScrollView
{
public:
	ScrollViewExtend();
	virtual ~ScrollViewExtend();

	static ScrollViewExtend* create();
	virtual bool init() override;

	void setItemsMargin(float margin);
	void setItemContentSize(const Size& size);

	void remedyChildren(const Vec2 & deltaMove = Vec2::ZERO);
protected:
	virtual void onSizeChanged() override;

	//´¥ÃþÊÍ·Å Âß¼­
	virtual void handleReleaseLogic(Touch *touch) override;

	virtual void moveInnerContainer(const Vec2& deltaMove, bool canStartBounceBack);

	virtual void scrollChildren(const Vec2& deltaMove) ;

	//±ß½çÅÐ¶Ï
	//virtual Vec2 getHowMuchOutOfBoundary(const Vec2& addition = Vec2::ZERO);
	Rect intersectionRect(const Rect & a, const Rect & rect) const;

private:
	Rect scaleRect;
	float itemMargin;
	Size itemContenSize;
};

#endif//__SCROLLVIEW_EXTEND_H__