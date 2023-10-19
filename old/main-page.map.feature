Feature: 1.1.1.2 Главная страница. Список предложений

  Background: Мокаю запросы к серверу
    Given пользователь неавторизован
    Given подменяю данные о предложениях
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён

  Scenario: Предложения отображаются на карте в виде синих маркеров
    Then элемент '.leaflet-container' видим
    Then на карте '2' синих маркеров
    When кликаю на элемент '.locations__item:nth-child(2)'
    Then элемент '.leaflet-container' видим
    Then на карте '1' синих маркеров
    When кликаю на элемент '.locations__item:nth-child(3)'
    Then элемента '.leaflet-container' нет на странице
    Then на карте '0' синих маркеров

  Scenario: При наведении курсора на карточку предложения, маркер становится оранжевым
    Then на карте '0' оранжевых маркеров
    When навожу курсор на элемент '.cities__card:nth-child(1)'
    Then на карте '1' синих маркеров
    Then на карте '1' оранжевых маркеров
    Given запоминаю положение оранжевого маркера
    When убираю курсор с элемента '.cities__card:nth-child(1)'
    Then на карте '2' синих маркеров
    Then на карте '0' оранжевых маркеров
    When навожу курсор на элемент '.cities__card:nth-child(2)'
    Then на карте '1' синих маркеров
    Then на карте '1' оранжевых маркеров
    Then положение оранжевого маркера изменилось
    When убираю курсор с элемента '.cities__card:nth-child(2)'
    Then на карте '2' синих маркеров
    Then на карте '0' оранжевых маркеров
    When кликаю на элемент '.locations__item:nth-child(2)'
    Then на карте '1' синих маркеров
    Then на карте '0' оранжевых маркеров
    When навожу курсор на элемент '.cities__card:nth-child(1)'
    Then на карте '0' синих маркеров
    Then на карте '1' оранжевых маркеров
    When убираю курсор с элемента '.cities__card:nth-child(1)'
    Then на карте '1' синих маркеров
    Then на карте '0' оранжевых маркеров