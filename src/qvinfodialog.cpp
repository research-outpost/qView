#include "qvinfodialog.h"
#include "ui_qvinfodialog.h"
#include <QDateTime>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QMimeDatabase>
#include <QTimer>
#include <QtEndian>

static int getGcd(int a, int b)
{
    return (b == 0) ? a : getGcd(b, a % b);
}

// VRCMetadata/VRCX store the session as JSON in the PNG's iTXt "Description" chunk.
// QImageReader would decode the whole image to hand that over, so walk the chunk list
// instead: the text chunks always precede IDAT.
static QByteArray pngDescription(const QString &path)
{
    static const char pngSignature[8] = { static_cast<char>(0x89), 'P', 'N', 'G', 13, 10, 26, 10 };
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly) || file.read(8) != QByteArray(pngSignature, 8))
        return QByteArray();

    while (file.pos() < 1024 * 1024) {
        const QByteArray header = file.read(8);
        if (header.size() < 8)
            break;
        const quint32 length = qFromBigEndian<quint32>(header.constData());
        const QByteArray type = header.mid(4, 4);
        if (type == "IDAT" || type == "IEND" || length > 16384)
            break;
        QByteArray data = file.read(length);
        file.skip(4); // CRC
        if (data.size() < int(length))
            break;

        const int keywordEnd = data.indexOf('\0');
        if (keywordEnd < 0 || data.left(keywordEnd) != QByteArrayLiteral("Description"))
            continue;

        if (type == "iTXt") {
            // keyword NUL, compression flag, method, language NUL, translated keyword NUL, text
            int pos = data.indexOf('\0', keywordEnd + 3);
            if (pos < 0)
                continue;
            pos = data.indexOf('\0', pos + 1);
            if (pos < 0)
                continue;
            return data.mid(pos + 1);
        }
        if (type == "tEXt")
            return data.mid(keywordEnd + 1);
    }
    return QByteArray();
}

QVInfoDialog::QVInfoDialog(QWidget *parent) : QDialog(parent), ui(new Ui::QVInfoDialog)
{
    ui->setupUi(this);
    setWindowFlags(windowFlags() & (~Qt::WindowContextHelpButtonHint | Qt::CustomizeWindowHint));

    width = 0;
    height = 0;
    frameCount = 0;
}

QVInfoDialog::~QVInfoDialog()
{
    delete ui;
}

void QVInfoDialog::setInfo(const QFileInfo &value, const int &value2, const int &value3,
                           const int &value4)
{
    selectedFileInfo = value;
    width = value2;
    height = value3;
    frameCount = value4;

    // If the dialog is visible, it means we've just navigated to a new image. Instead of running
    // updateInfo immediately, add it to the event queue. This is a workaround for a
    // (Windows-specific?) delay when calling adjustSize on the window if the font contains certain
    // characters (e.g. Chinese) the first time that happens for a given font. At least on Windows,
    // by making the work happen later in the event loop, it allows the main window to repaint
    // first, giving the appearance of better responsiveness. If the dialog is not visible, however,
    // it means we're preparing to display for an image already opened. In this case there is no
    // urgency to repaint the main window, and we need to process the updates here synchronously to
    // avoid the caller showing the dialog before it's ready (i.e. to avoid showing outdated info or
    // placeholder text).
    if (isVisible())
        QTimer::singleShot(0, this, &QVInfoDialog::updateInfo);
    else
        updateInfo();
}

void QVInfoDialog::updateInfo()
{
    QLocale locale = QLocale::system();
    QMimeDatabase mimedb;
    QMimeType mime = mimedb.mimeTypeForFile(selectedFileInfo.absoluteFilePath(),
                                            QMimeDatabase::MatchContent);
    // this is just math to figure the megapixels and then round it to the tenths place
    const double megapixels =
            static_cast<double>(
                    qRound(((static_cast<double>((width * height)))) / 1000000 * 10 + 0.5))
            / 10;

    ui->nameLabel->setText(selectedFileInfo.fileName());
    ui->typeLabel->setText(mime.name());
    ui->locationLabel->setText(selectedFileInfo.path());
    ui->sizeLabel->setText(tr("%1 (%2 bytes)")
                                   .arg(formatBytes(selectedFileInfo.size()),
                                        locale.toString(selectedFileInfo.size())));
    ui->modifiedLabel->setText(selectedFileInfo.lastModified().toString(locale.dateTimeFormat()));
    ui->dimensionsLabel->setText(tr("%1 x %2 (%3 MP)")
                                         .arg(QString::number(width), QString::number(height),
                                              QString::number(megapixels)));
    int gcd = getGcd(width, height);
    if (gcd != 0)
        ui->ratioLabel->setText(QString::number(width / gcd) + ":" + QString::number(height / gcd));
    if (frameCount != 0) {
        ui->framesLabel2->show();
        ui->framesLabel->show();
        ui->framesLabel->setText(QString::number(frameCount));
    } else {
        ui->framesLabel2->hide();
        ui->framesLabel->hide();
    }

    // VRChat session metadata, if this file carries any: each row hides itself when empty.
    const QJsonObject session =
            QJsonDocument::fromJson(pngDescription(selectedFileInfo.absoluteFilePath())).object();
    const QJsonObject author = session.value("author").toObject();
    const QJsonObject world = session.value("world").toObject();

    QStringList players;
    const QJsonArray playerArray = session.value("players").toArray();
    for (const QJsonValue &player : playerArray)
        players.append(player.toObject().value("displayName").toString());

    QDateTime captured =
            QDateTime::fromString(session.value("timestamp").toString(), Qt::ISODateWithMs);
    if (captured.isValid())
        captured = captured.toLocalTime();

    ui->worldValueLabel->setText(world.value("name").toString());
    ui->worldValueLabel->setToolTip(world.value("id").toString());
    ui->instanceValueLabel->setText(world.value("instanceId").toString());
    ui->authorValueLabel->setText(author.value("displayName").toString());
    ui->authorValueLabel->setToolTip(author.value("id").toString());
    ui->playersValueLabel->setText(players.isEmpty()
                                           ? QString()
                                           : tr("%1 (%2)").arg(QString::number(players.count()),
                                                               players.join(", ")));
    ui->playersValueLabel->setToolTip(players.join(", "));
    ui->capturedValueLabel->setText(captured.isValid() ? captured.toString(locale.dateTimeFormat())
                                                       : QString());

    const QList<QPair<QLabel *, QLabel *>> sessionRows = {
        { ui->worldLabel, ui->worldValueLabel },
        { ui->instanceLabel, ui->instanceValueLabel },
        { ui->authorLabel, ui->authorValueLabel },
        { ui->playersLabel, ui->playersValueLabel },
        { ui->capturedLabel, ui->capturedValueLabel },
    };
    for (const QPair<QLabel *, QLabel *> &row : sessionRows) {
        const bool hasValue = !row.second->text().isEmpty();
        row.first->setVisible(hasValue);
        row.second->setVisible(hasValue);
    }

    window()->adjustSize();
}
