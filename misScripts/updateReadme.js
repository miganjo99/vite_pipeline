const fs = require('fs');

const readmePath = './README.md';

const successBadge = '![Success](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)';
const failureBadge = '![Failure](https://img.shields.io/badge/test-failure-red)';

const testResult = 'success';

const badge = testResult === 'success' ? successBadge : failureBadge;

const readmeContent = fs.existsSync(readmePath) ? fs.readFileSync(readmePath, 'utf-8') : '';

const updatedContent = readmeContent.includes('Resultado de los últimos tests')
     ? readmeContent.replace(/Resultados de los tests.*/s, `Resultaods\n\n${badge}`)
     : `${readmeContent}\n\n## Resultados de los tests\n\n${badge}`;

fs.writeFileSync(readmePath, updatedContent, 'utf-8');

console.log(`README.md actualizado (${testResult}).`);