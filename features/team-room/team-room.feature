# language: ru

Функционал: Комната команды
    Для получения информации о команде
    А также для управления ею капитаном
    Должна присутствовать комната команды

Сценарий: Член или капитан команды заходит в комнату команды
    Допустим зарегистрирована команда "Mushrooms" под руководством Noel
    Если я захожу в комнату команды
    То должен увидеть "Команда Mushrooms"

Сценарий: Не член команды пытается зайти в комнату команды
    Допустим я залогинен как Iv
    Если я захожу в комнату команды
    То должен увидеть "Вы не авторизованы для посещения этой страницы"

Сценарий: Гость пытается зайти в комнату команды
    Допустим я не залогинен
    Если я захожу в комнату команды
    То должен увидеть "Вы не авторизованы для посещения этой страницы"

Сценарий: Капитан команды видит ссылку на комнату команды в личном кабинете
    Допустим зарегистрирована команда "Mushrooms" под руководством Noel
    Если я захожу в личный кабинет
    То должен увидеть ссылку на /team-room

Сценарий: В комнате команды отображается имя её капитана
    Допустим зарегистрирована команда "Mushrooms" под руководством Noel
    Если я захожу в комнату команды
    То должен увидеть "Noel - капитан"

Сценарий: В комнате команды отображается список её членов
    Допустим зарегистрирована команда "Mushrooms" под руководством Noel
    И пользователь Alisa состоит в команде "Mushrooms"
    И пользователь Aldor состоит в команде "Mushrooms"
    Если я логинюсь как Aldor
    И захожу в комнату команды
    То должен увидеть следующее:        
        | текст |
        | Noel  |
        | Alisa |
        | Aldor |