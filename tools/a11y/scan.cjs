/*
 * Accessibility scan for the built book.
 *
 * Prerequisites (installed globally on this machine):
 *   npm i -g playwright @axe-core/playwright
 *   playwright install chromium
 *
 * Usage, from the project root, with the built site served locally:
 *   python3 -m http.server 8765 -d docs &
 *   NODE_PATH=$(npm root -g) node tools/a11y/scan.cjs --base http://localhost:8765 \
 *     / /chapters/chapter-01.html ... /chapters/appendix-glossary.html
 *
 * Set VW and VH to test a narrow viewport, for example VW=390 VH=844.
 * The JSON report is written to a11y-results.json next to this script.
 * The process exits 1 if any page has a violation or an error, otherwise 0.
 */
const { chromium } = require('playwright');
const { AxeBuilder } = require('@axe-core/playwright');
const fs = require('fs');
const path = require('path');

const args = process.argv.slice(2);
let base = 'http://localhost:8765';
const pages = [];
for (let i = 0; i < args.length; i++) {
  if (args[i] === '--base') { base = args[++i]; } else { pages.push(args[i]); }
}
const viewport = {
  width: Number(process.env.VW || 1280),
  height: Number(process.env.VH || 900)
};
const outFile = path.join(__dirname, 'a11y-results.json');

(async () => {
  const browser = await chromium.launch();
  const results = [];
  for (const p of pages) {
    const context = await browser.newContext({ viewport });
    const page = await context.newPage();
    try {
      await page.goto(base + p, { waitUntil: 'networkidle', timeout: 30000 });
      const r = await new AxeBuilder({ page })
        .withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa', 'best-practice'])
        .analyze();
      results.push({
        page: p,
        violations: r.violations.map(v => ({
          id: v.id, impact: v.impact, help: v.help,
          nodes: v.nodes.map(n => ({
            target: n.target.join(' '),
            summary: (n.failureSummary || '').split('\n').filter(Boolean).slice(0, 3).join(' | ')
          }))
        }))
      });
    } catch (e) {
      results.push({ page: p, error: e.message.split('\n')[0] });
    }
    await context.close();
  }
  await browser.close();
  fs.writeFileSync(outFile, JSON.stringify(results, null, 2));

  const totals = {};
  for (const r of results) for (const v of (r.violations || [])) {
    totals[v.id] = totals[v.id] || { impact: v.impact, pages: 0, nodes: 0 };
    totals[v.id].pages++;
    totals[v.id].nodes += v.nodes.length;
  }
  console.log(JSON.stringify({
    pages: results.length,
    viewport,
    errors: results.filter(r => r.error),
    totals
  }, null, 2));

  // Exit 1 when any page has a violation or failed to load, so scripts can gate on it.
  if (results.some(r => r.error || (r.violations || []).length > 0)) process.exitCode = 1;
})();
