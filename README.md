# Конвертер png-изображений в видео
Создает из каждой картинки видосик с заданной длительностью, fps, битрейтом и другими параметрами, т.е. на выходе получается статичное видео.
### Как работает
Скрипт ищет png-шки во всех папках, включая вложенные. Поиск начнется с той папки, где лежит сам файл скрипта. Когда скрипт находит png-шку, он преобразует ее в видео при помощи ffmpeg. 
Параметры кодирования берутся из названий файлов. Перед началом работы скрипт спросит нужно ли перезаписать уже существующие видео и нужно ли удалить png-файлы после преобразования.
### Требования
1. Работает только на Винде
2. Должен быть установлен [ffmpeg](https://ffmpeg.org/)
### Имена файлов
Название png-файла должно быть в формате: `<Заголовок>-<ширина>x<высота>-<длительность>s-<кол-во кадров в секунду>fps-<битрейт>kbps-<mp4/avi/mpg/mov/xvid>`
* Все символы, кроме заголовка должны быть набраны латиницей
* Не разделяйте заголовок внутри знаками минуса «-», используйте для этого пробелы или нижнее подчеркивание

Примеры правильных имен:
- `Взрослые друзья-1280x720-10s-30fps-6000kbps-avi.png`
- `Взрослые_друзья-1280x720-10s-30fps-6000kbps-avi.png`

Некорректные имена (заголовок разделен минусом):
- `Взрослые-друзья-1280x720-10s-30fps-6000kbps-avi.png`

### Примеры названий для конвертации в разные форматы
- mp4 (x264): `Алтай-1440x480-5s-25fps-4000kbps-mp4.png`
- avi (x264): `Алтай-1440x480-5s-25fps-4000kbps-avi.png`
- avi (xvid): `Алтай-1440x480-5s-25fps-4000kbps-xvid.png`
- mov (x264): `Алтай-1440x480-5s-25fps-4000kbps-mov.png`
- mpeg2: `Алтай-1440x480-5s-25fps-4000kbps-mpg.png`
### Как пользоваться
1. Установить [ffmpeg](https://ffmpeg.org/), если он еще не установлен
2. Скачать файл скрипта
3. Положить скрипт в корневую папку задачи (где все папки с городами) или в любую папку, где хранятся картинки
4. Убедиться, что все имена png-файлов соответствуют формату, который описан выше
5. Запустить скрипт
6. Скрипт спросит нужно ли перезаписать существующие видео (y — да, n — нет)
7. Скрипт спросит нужно ли удалить png-файлы после конвертации (y — да, n — нет)