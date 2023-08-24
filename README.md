# AI Audio для Windows от VladimirGav

## Официальные репозитории
- https://github.com/suno-ai/bark

## Возможности сборки
- Автоматическая установка для Windows
- Генерация речи по тексту
- Генерация песен по тексту
- Поддержка нескольких языков
    - `English (en)`
    - `German (de)`
    - `Spanish (es)`
    - `French (fr)`
    - `Hindi (hi)`
    - `Italian (it)`
    - `Japanese (ja)`
    - `Korean (ko)`
    - `Polish (pl)`
    - `Portuguese (pt)`
    - `Russian (ru)`
    - `Turkish (tr)`
    - `Chinese, simplified (zh)`
- Поддержка эмоций
    - `[laughter]` - смех
    - `[laughs]` - смеётся
    - `[sighs]` - вздыхает, выдох, обычно после стресса
    - `[music]` - музыка
    - `[gasps]` - вздыхает, резкий вдох, удивление
    - `[clears throat]` - прокашливается
    - `—` или `...` для колебаний
    - `♪` для текстов песен
    - ЗАГЛАВНЫЕ буквы для выделения слова
- Поддержка нескольких голосов, [список спикеров](https://suno-ai.notion.site/8b8e8749ed514b0cbf3f699013548683?v=bc67cff786b04b50b3ceb756fd05f68c)
- Подключение к телеграм боту https://github.com/VladimirGav/telegrambot
- Автоматическая загрузка и обновление моделей из https://huggingface.co/
- Работает со слабыми видеокартами, протестировал на NVIDIA GeForce RTX 3050 Laptop GPU

## Установка на Windows
Видео инструкция Скоро
1. Установите Windows Cuda local версии 11.7.0 для своей видеокарты
- Для NVIDIA https://developer.nvidia.com/cuda-11-7-0-download-archive
2. Загружаем zip архив репозитория VladimirGav/ai-audio-vg на компьютер и распаковываем.
3. Запускаем автоматическую установку на Windows [vladimirgav/StartInstallWindows.bat](vladimirgav/StartInstallWindows.bat)

## Как генерировать изображения по текстовому описанию в Windows
Видео инструкция Скоро
1. Вводим `текст, голос и другое` в файл [vladimirgav/inputdata/txt2audio.json](vladimirgav/inputdata/txt2audio.json)
2. Запускаем файл [vladimirgav/vg_txt2audio.bat](vladimirgav/vg_txt2audio.bat)
3. Получаем готовые аудио файлы, например в `vladimirgav/audio`

Разработчик: VladimirGav