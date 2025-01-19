import fs from 'fs';

const readmePath = './README.md';

const successBadge = '![Success](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)';
const failureBadge = '![Failure](https://img.shields.io/badge/test-failure-red)';

// Aquí puedes pasar el resultado de la prueba como argumento del script
const testResult = process.argv[2] === 'Correcto' ? 'success' : 'failure';

const badge = testResult === 'success' ? successBadge : failureBadge;

const readmeContent = fs.existsSync(readmePath) ? fs.readFileSync(readmePath, 'utf-8') : '';

const updatedContent = readmeContent.includes('Resultados de los últimos tests')
  ? readmeContent.replace(/Resultados de los tests.*/s, `Resultados\n\n${badge}`)
  : `${readmeContent}\n\n## Resultados de los tests\n\n${badge}`;

fs.writeFileSync(readmePath, updatedContent, 'utf-8');

console.log(`README.md actualizado (${testResult}).`);
