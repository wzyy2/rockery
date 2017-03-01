#ifndef FPSTEXT_H
#define FPSTEXT_H

#include <QQuickItem>
#include <QQuickPaintedItem>
#include <QDateTime>
#include <QBrush>
#include <QPainter>
#include <QTimer>

class FPSText: public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(int fps READ fps NOTIFY fpsChanged)

public:
    FPSText(QQuickItem *parent = 0);
    ~FPSText();
    void paint(QPainter *);
    Q_INVOKABLE int fps()const;
    Q_INVOKABLE void recalculateFPS();

signals:
    void fpsChanged(int);

private slots:
    void calculateAverageFrequency();

private:
    int _currentFPS;
    int _cacheCount;
    QVector<qint64> _times;
    QTimer *m_averageTimer;
};

#endif // FPSTEXT_H
