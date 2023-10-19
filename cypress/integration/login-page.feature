Feature: 1.1.3 Страница Login

  Background: Мокаю запросы к серверу
    Given пользователь неавторизован
    Given подменяю запрос на логин
    When нахожусь на странице Login

  Scenario: Валидация логина и пароля
#    Given подменяю данные о фильмах
    When кликаю на элемент '[name="user-email"]'
    When кликаю на элемент '[name="user-password"]'
    When в поле '[name="user-password"]' ввожу текст '{enter}'
    Then значение поля '[name="user-email"]' равно ''
    Then значение поля '[name="user-password"]' равно ''
    When в поле '[name="user-email"]' ввожу текст 'Lorem'
    When в поле '[name="user-password"]' ввожу текст 'i'
    When в поле '[name="user-password"]' ввожу текст '{enter}'
    Then значение поля '[name="user-email"]' равно 'Lorem'
    Then значение поля '[name="user-password"]' равно 'i'
    When в поле '[name="user-email"]' ввожу текст '@test.com'
    When в поле '[name="user-password"]' ввожу текст '{enter}'
    Then значение поля '[name="user-email"]' равно 'Lorem@test.com'
    Then значение поля '[name="user-password"]' равно 'i'
    When в поле '[name="user-password"]' ввожу текст '{enter}'
    Then элемент '.sign-in__form > *:nth-child(1)' содержит класс 'sign-in__message'
    When в поле '[name="user-password"]' ввожу текст '1'
    When в поле '[name="user-password"]' ввожу текст '{enter}'
    Then запрос на логин отправлен с правильными данными
    Then элемент '.catalog__genres-list' видим

  Scenario: Если произошла ошибка, форма не очищается
    Given сервер не даёт залогиниться
    When в поле '[name="user-email"]' ввожу текст 'Lorem@test.com'
    When в поле '[name="user-password"]' ввожу текст 'i1'
    When в поле '[name="user-password"]' ввожу текст '{enter}'
    When запрос на логин завершён
    Then значение поля '[name="user-email"]' равно 'Lorem@test.com'
    Then значение поля '[name="user-password"]' равно 'i1'

  Scenario: При переключении страниц форма очищается
    Given подменяю запрос на логаут
    Given подменяю данные о фильмах
#    Given подменяю данные об избранных предложениях
    When в поле '[name="user-email"]' ввожу текст 'Lorem'
    When в поле '[name="user-password"]' ввожу текст 'i'
    When в поле '[name="user-password"]' ввожу текст '{enter}'
    When кликаю на первый элемент в коллекции '.logo__link'
    When кликаю на элемент '.user-block .user-block__link'
    Then значение поля '[name="user-email"]' равно ''
    Then значение поля '[name="user-password"]' равно ''
    When в поле '[name="user-email"]' ввожу текст 'Lorem@test.com'
    When в поле '[name="user-password"]' ввожу текст 'i1'
    When в поле '[name="user-password"]' ввожу текст '{enter}'
    When запрос на логин завершён
    Then элемент '.catalog__genres-list' видим
    When кликаю на элемент '.user-block__item .user-block__link'
    When кликаю на элемент '.user-block .user-block__link'
    Then значение поля '[name="user-email"]' равно ''
    Then значение поля '[name="user-password"]' равно ''

