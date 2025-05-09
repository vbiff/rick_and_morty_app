# Rick & Morty Characters App

Мобильное приложение на **Flutter** для просмотра персонажей из вселенной **"Рик и Морти"**. Поддерживает избранное, оффлайн-режим, пагинацию и переключение темы.

---

## 📲 Функционал

### Главный экран:
- Список персонажей в виде карточек.
- В карточке отображаются:
  - Изображение персонажа.
  - Имя персонажа.
  - Дополнительные характеристики: статус, вид.
  - Кнопка "звездочка" ⭐ для добавления в избранное.

### Экран "Избранное":
- Список добавленных в избранное персонажей.
- Сортировка по имени, статусу или другому параметру.
- Возможность удаления из избранного.

### Навигация:
- **BottomNavigationBar** для переключения между экранами.

### Дополнительно:
- **Пагинация** — подгрузка персонажей при прокрутке.
- **Кеширование** — данные сохраняются локально, приложение работает без интернета.
- Избранное сохраняется в базе данных (**Hive**).
- **Переключение темы** (светлая / тёмная).


---

## 🛠 Стек технологий

- **Flutter**, **Dart**
- **REST API** — [Rick and Morty API](https://rickandmortyapi.com/documentation)
- **Hive** — база данных для кеширования и избранного.
- **InheritedWidget** — управление состоянием (темы и API state).
- **http** — сетевые запросы.

---

## 🗂 Структура проекта

lib/
- ├── models/            # Модели данных (CharacterModel)
- ├── services/          # Работа с API (ApiService)
- ├── provider/             # State management через InheritedWidget (ThemeProvider, CharacterProvider)
- ├── screens/           # Экраны (HomeScreen, FavoritesScreen)
- └── main.dart          # Точка входа



---

## ⚙️ Установка

1. Клонируйте репозиторий:

```bash
git clone https://github.com/your-username/rick-and-morty-flutter-app.git
cd rick-and-morty-flutter-app
