import { When } from 'cypress-cucumber-preprocessor/steps';

When('нахожусь на странице Main', () => {
  cy.visit('/');
});

When('нахожусь на странице Login', () => {
  cy.visit('/login');
});

When('нахожусь на странице My List', () => {
  cy.visit('/mylist');
});

When('нахожусь на странице Film', () => {
  cy.visit('/films/regular-film');
});

When('нахожусь на странице Add review', () => {
  cy.visit('/films/regular-film/review');
});

When('нахожусь на несуществующей странице', () => {
  cy.visit('/test');
});

When('нахожусь на странице несуществующего фильма', () => {
  cy.visit('/offer/test');
});

When(/^кликаю на элемент '(.*)'$/, (selector) => {
  cy.get(selector).click();
});

When(/^кликаю на первый элемент в коллекции '(.*)'$/, (selector) => {
  cy.get(selector).eq(0).click();
});


When(/^навожу курсор на элемент '(.*)'$/, (selector) => {
  cy.get(selector).trigger('mouseenter');
  cy.get(selector).trigger('mouseover');
});

When(/^убираю курсор с элемента '(.*)'$/, (selector) => {
  cy.get(selector).trigger('mouseleave');
  cy.get(selector).trigger('mouseout');
});

When(/^прокручиваю страницу$/, () => {
  cy.window().scrollTo('bottom');
});

When(/^в поле '(.*)' ввожу текст '(.*)'$/, (selector, text) => {
  cy.get(selector).type(text);
});

