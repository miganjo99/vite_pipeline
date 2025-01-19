// src/__tests__/sum.test.js
const sum = require('../../sum'); 

test('Suma 1 + 2 para dar 3', () => {
  expect(sum(1, 2)).toBe(3);
});

test('Suma 2 + 2 para dar 4', () => {
  expect(sum(2, 2)).toBe(4);
});

test('Suma 5 + 5 para dar 10', () => {
  expect(sum(5, 5)).toBe(10);
});
