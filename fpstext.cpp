#include "fpstext.h"

FPSText::FPSText(QQuickItem *parent): QQuickPaintedItem(parent), _currentFPS(0), _cacheCount(0), m_averageTimer(new QTimer(this))
{
    _times.clear();
    setFlag(QQuickItem::ItemHasContents);

    connect(m_averageTimer, SIGNAL(timeout()),
            this, SLOT(calculateAverageFrequency()));
    m_averageTimer->start(1000);

}

FPSText::~FPSText()
{
}

void FPSText::recalculateFPS()
{
    _currentFPS++;
}

void FPSText::calculateAverageFrequency()
{
    fpsChanged(_currentFPS);
    _currentFPS = 0;
}

int FPSText::fps()const
{
    return _currentFPS;
}

void FPSText::paint(QPainter *painter)
{
    recalculateFPS();

    QBrush brush(Qt::yellow);

    painter->setBrush(brush);
    painter->setPen(Qt::NoPen);
    painter->setRenderHint(QPainter::Antialiasing);
    painter->drawRoundedRect(0, 0, boundingRect().width(), boundingRect().height(), 0, 0);
    update();
}
