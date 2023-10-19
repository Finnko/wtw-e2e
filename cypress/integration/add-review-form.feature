Feature: Форма отправки отзыва о фильме

  Background: Мокаю запросы к серверу
    Given пользователь авторизован
    Given подменяю данные об тестовом фильме
    Given подменяю данные об избранных фильмах
    Given подменяю данные о фильмах
    When нахожусь на странице Add review
    When запрос на получение данных о тестовом фильме завершён

  Scenario: Форма отправки отзыва отображается только для авторизованных пользователей
    Then элемент '.add-review__form' видим
    Given пользователь неавторизован
    When нахожусь на странице Film
    When запрос на получение данных о тестовом фильме завершён
    Then элемента 'add-review__form' нет на странице

  Scenario: Пока пользователь не выбрал оценку и не ввёл текст, кнопка отправки не активна
    Then элемент '[type="submit"]' заблокирован
#    в верстке обратный порядок
    When кликаю на элемент '.rating__label:nth-of-type(8)'
    Then выбран элемент '#star-3'
    When кликаю на элемент '.rating__label:nth-of-type(1)'
    Then выбран элемент '#star-10'
    Then элемент '[type="submit"]' заблокирован
    When в поле '.add-review__textarea' ввожу текст 'not long enough...'
    Then элемент '[type="submit"]' заблокирован
    When в поле '.add-review__textarea' ввожу текст ' but now it should be long enough!'
    Then элемент '[type="submit"]' не заблокирован
    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Ut enim ad minim veniam, quis nostrud exercitation ullamco'
    Then элемент '[type="submit"]' заблокирован
#
  Scenario: Данные об отзыве отправляются в правильном формате
    Given подменяю запрос на отправку отзыва
    When кликаю на элемент '.rating__label:nth-of-type(1)'
    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '[type="submit"]'
    Then запрос на отправку отзыва отправлен с правильными данными

  Scenario: При отправке данных форма блокируется
    Given отзыв отправляется с задержкой
    When кликаю на элемент '.rating__label:nth-of-type(4)'
    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '[type="submit"]'
    Then элемент '[type="submit"]' заблокирован
    Then элемент '#star-1' заблокирован
    Then элемент '#star-8' заблокирован
    Then элемент '.add-review__textarea' заблокирован
    When запрос на отправку отзыва завершён
    Then элемент '[type="submit"]' не заблокирован
    Then элемент '#star-1' не заблокирован
    Then элемент '#star-8' не заблокирован
    Then элемент '.add-review__textarea' не заблокирован

  Scenario: При успешной отправке данных пользователь перенаправляется на страницу фильма
    Given подменяю запрос на отправку отзыва
    When кликаю на элемент '.rating__label:nth-of-type(1)'
    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '[type="submit"]'
    When запрос на отправку отзыва завершён
    When нахожусь на странице Film

  Scenario: Если при отправке произошла ошибка, форма не очищается, пользователь остается на странице формы
    Given сервер не принимает отзывы
    When кликаю на элемент '.rating__label:nth-of-type(1)'
    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '[type="submit"]'
    When запрос на отправку отзыва завершён
    Then выбран элемент '#star-10'
    Then значение поля '.add-review__textarea' равно 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    Then элемент '.add-review__textarea' не заблокирован
    Then элемент '[type="submit"]' не заблокирован

#  Scenario: Новый отзыв добавляется в начало списка
#    Given подменяю запрос на отправку отзыва
#    When кликаю на элемент '[title="perfect"]'
#    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
#    When кликаю на элемент '[type="submit"]'
#    When запрос на отправку отзыва завершён
#    Then элемент '.reviews__amount' содержит текст '13'
#    Then на странице '10' отзывов
#    Then элемент '.reviews__item:nth-child(1) .reviews__text' содержит текст 'New Comment'
#    Then элемент '.reviews__item:nth-child(1) .reviews__stars span:nth-child(1)' имеет ширину '58'
#    Then элемент '.reviews__item:nth-child(1) .reviews__user-name' содержит текст 'Test user'
#
#  Scenario: Пользователь может оставить любое количество отзывов
#    Given подменяю запрос на отправку отзыва
#    When кликаю на элемент '[title="perfect"]'
#    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
#    When кликаю на элемент '[type="submit"]'
#    When запрос на отправку отзыва завершён
#    Then элемент '.reviews__item:nth-child(1) .reviews__text' содержит текст 'New Comment'
#    When кликаю на элемент '[title="perfect"]'
#    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
#    When кликаю на элемент '[type="submit"]'
#    When запрос на отправку отзыва завершён
#    Then элемент '.reviews__amount' содержит текст '14'
#    Then на странице '10' отзывов
#    Then элемент '.reviews__item:nth-child(1) .reviews__text' содержит текст 'New Comment'
#    Then элемент '.reviews__item:nth-child(2) .reviews__text' содержит текст 'New Comment'
#
#  Scenario: При переключении страниц форма очищается
#    When кликаю на элемент '[title="perfect"]'
#    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
#    When кликаю на элемент '.header__logo-link'
#    When кликаю на элемент '.cities__card:nth-child(1) .place-card__name a'
#    Then элемент '#5-stars' не выбран
#    Then значение поля '.add-review__textarea' равно ''
#    When в поле '.add-review__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
#    When в поле '.add-review__textarea' ввожу текст '{enter}'
#    When кликаю на элемент '.header__logo-link'
#    When кликаю на элемент '.cities__card:nth-child(1) .place-card__name a'
#    Then элемент '#5-stars' не выбран
#    Then значение поля '.add-review__textarea' равно ''
#    When кликаю на элемент '[title="perfect"]'
#    When в поле '.add-review__textarea' ввожу текст 'not long enough...'
#    When в поле '.add-review__textarea' ввожу текст '{enter}'
#    When кликаю на элемент '.header__logo-link'
#    When кликаю на элемент '.cities__card:nth-child(1) .place-card__name a'
#    Then элемент '#5-stars' не выбран
#    Then значение поля '.add-review__textarea' равно ''
