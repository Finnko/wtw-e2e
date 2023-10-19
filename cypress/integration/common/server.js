import { Given } from 'cypress-cucumber-preprocessor/steps';



const baseApiUrl = Cypress.config('baseApiUrl');

const APIRoute = {
  FILMS: `${baseApiUrl}/films`,
  COMMENTS: `${baseApiUrl}/comments`,
  FAVORITES: `${baseApiUrl}/favorite`,
  LOGIN: `${baseApiUrl}/login`,
  LOGOUT: `${baseApiUrl}/logout`,
  SIMILAR: '/similar',
};

const FilmId = {
  FIRST: 'regular-film',
  NONEXISTENT: 'test',
};

const Token = {
  KEY: 'wtw-token',
  VALUE: 'token'
}

const filmUrl = `${APIRoute.FILMS}/${FilmId.FIRST}`;
const filmCommentsUrl = `${APIRoute.COMMENTS}/${FilmId.FIRST}`;
const filmSimilarUrl = `${filmUrl}${APIRoute.SIMILAR}`;
// const firstOfferFavoritesUrl = `${APIRoute.FAVORITES}/${OfferId.FIRST}`;

// const thirdOfferFavoritesUrl = `${APIRoute.FAVORITES}/${OfferId.THIRD}`;

const nonexistentFilmUrl = `${APIRoute.FILMS}/${FilmId.NONEXISTENT}`;
const nonexistentCommentsUrl = `${APIRoute.COMMENTS}/${FilmId.NONEXISTENT}`;
const nonexistentNearbyUrl = `${nonexistentFilmUrl}${APIRoute.SIMILAR}`;


Given(/^подменяю данные о фильмах$/, () => {
  cy.intercept('GET', APIRoute.FILMS, {
    fixture: 'films.json',
  }).as('getFilms');
});

Given(/^сервер отдаёт пустой список фильмов$/, () => {
  cy.intercept(
    {
      method: 'GET',
      url: APIRoute.FILMS,
    },
    {
      statusCode: 200,
      body: [],
    }
  ).as('getFilms');
});

When(/^запрос на получение данных о фильмах завершён$/, () => {
  cy.wait('@getFilms');
});

Given(/^подменяю данные об тестовом фильме$/, () => {
  cy.intercept(
    'GET',
    filmUrl,
    { fixture: 'film.json' }
  ).as('getFilm');

  cy.intercept(
    'GET',
    filmSimilarUrl,
    { fixture: 'similar.json' }
  ).as('getSimilar');

  cy.intercept(
    'GET',
    filmCommentsUrl,
    { fixture: 'reviews.json' }
  ).as('getComments');
});

Given(/^подменяю данные о несуществующем тестовом фильме$/, () => {
  cy.intercept(
    'GET',
    nonexistentFilmUrl,
    { statusCode: 404 }
  ).as('getFilm');

  cy.intercept(
    'GET',
    nonexistentNearbyUrl,
    { statusCode: 404 }
  ).as('getSimilar');

  cy.intercept(
    'GET',
    nonexistentCommentsUrl,
    { statusCode: 404 }
  ).as('getComments');
});

When(/^запрос на получение данных о тестовом фильме завершён$/, () => {
  cy.wait(['@getFilm', '@getSimilar', '@getComments']);
});

Given(/^подменяю данные об избранных фильмах/, () => {
  cy.intercept({
    method: 'GET',
    url: APIRoute.FAVORITES,
  }, {
    fixture: 'favorites.json',
  }).as('getFavorites');
});

// Given(/^сервер отдаёт пустой список избранных предложений$/, () => {
//   cy.intercept(
//     {
//       method: 'GET',
//       url: APIRoute.FAVORITES,
//     },
//     {
//       statusCode: 200,
//       body: [],
//     }
//   ).as('getFavorites');
// });

// Given(/^запрос на получение данных об избранных предложениях не должен отправляться$/, () => {
//   cy.intercept('GET', APIRoute.FAVORITES, () => {
//     throw new Error('Запрос на получение данных об избранных предложениях отправлен!');
//   })
//     .as('getFavorites');
// });

// When(/^запрос на получение данных об избранных предложениях завершён$/, () => {
//   cy.wait('@getFavorites');
// });

Given(/^пользователь неавторизован$/, () => {
  cy.intercept(
    {
      method: 'GET',
      url: APIRoute.LOGIN,
    },
    {
      statusCode: 401,
    }
  ).as('getLogin');
});

Given(/^пользователь авторизован$/, () => {
  cy.intercept('GET', APIRoute.LOGIN, {
    fixture: 'user.json',
  }).as('getLogin');
  window.localStorage.setItem(Token.KEY, Token.VALUE);
});

When(/^запрос на получение данных об авторизации завершён$/, () => {
  cy.wait('@getLogin');
});

Given(/^подменяю запрос на логин$/, () => {
  cy.intercept('POST', APIRoute.LOGIN, {
    fixture: 'user.json',
  }).as('postLogin');
});

Given(/^сервер не даёт залогиниться$/, () => {
  cy.intercept({
    method: 'POST',
    url: APIRoute.LOGIN,
  }, {
    statusCode: 500,
  })
    .as('postLogin');
});

When(/^запрос на логин завершён$/, () => {
  cy.wait('@postLogin');
});

Then(/^запрос на логин отправлен с правильными данными$/, () => {
  cy.wait('@postLogin')
    .its('request.body')
    .then(({ email, password }) => {
      expect(email).to.eq('Lorem@test.com');
      expect(password).to.eq('i1');
    });
});

Given(/^подменяю запрос на логаут$/, () => {
  cy.intercept(
    {
      method: 'DELETE',
      url: APIRoute.LOGOUT,
    },
    {
      statusCode: 204,
    }
  ).as('deleteLogout');
});

When(/^запрос на логаут$/, () => {
  cy.wait('@deleteLogout');
});

// Given(/^подменяю запрос на добавление в избранное$/, () => {
//   cy.intercept('POST', `${firstOfferFavoritesUrl}/1`, {
//     fixture: 'favorite-offer.json',
//   })
//     .as('addFavorite');
// });

// Given(/^подменяю запрос на удаление из избранного$/, () => {
//   cy.intercept('POST', `${firstOfferFavoritesUrl}/0`, {
//     fixture: 'regular-offer.json',
//   })
//     .as('deleteFavorite');
//   cy.intercept('POST', `${secondOfferFavoritesUrl}/0`, {
//     fixture: 'premium-offer.json',
//   })
//     .as('deleteFavorite');
//
//   cy.intercept('POST', `${thirdOfferFavoritesUrl}/0`, {
//     fixture: 'cologne-offer.json',
//   })
//     .as('deleteFavorite');
// });

// When(/^запрос на добавление в избранное завершён$/, () => {
//   cy.wait('@addFavorite');
// });
//
// When(/^запрос на удаление из избранного завершён$/, () => {
//   cy.wait('@deleteFavorite');
// });

Given(/^подменяю запрос на отправку отзыва$/, () => {
  cy.intercept('POST', filmCommentsUrl, {
    fixture: 'new-review.json',
  })
    .as('postReview');
});

Given(/^отзыв отправляется с задержкой$/, () => {
  cy.intercept({
    method: 'POST',
    url: filmCommentsUrl
  }, {
    statusCode: 201,
    delayMs: 500,
    fixture: 'new-review.json'
  })
    .as('postReview');
});

Given(/^сервер не принимает отзывы$/, () => {
  cy.intercept({
    method: 'POST',
    url: filmCommentsUrl,
  }, {
    statusCode: 500,
  })
    .as('postReview');
});

When(/^запрос на отправку отзыва завершён$/, () => {
  cy.wait('@postReview');
});

Then(/^запрос на отправку отзыва отправлен с правильными данными$/, () => {
  cy.wait('@postReview')
    .its('request.body')
    .then(({ comment, rating }) => {
      expect(comment).to.eq('Lorem ipsum dolor sit amet, consectetur porta ante.');
      expect(rating).to.eq(10);
    });
});
