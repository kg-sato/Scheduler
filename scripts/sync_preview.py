"""Generate the isolated student design preview from the canonical application."""
from pathlib import Path

root = Path(__file__).resolve().parent.parent
source = (root / 'Application.html').read_text(encoding='utf-8')
preview = source.replace('<html lang="en">', '<html lang="en" data-preview="true">', 1)
preview = preview.replace('<title>Scheduler</title>', '<title>Scheduler · Study edition preview</title>', 1)
target = root / 'design' / 'scheduler-ui-preview' / 'index.html'
target.parent.mkdir(parents=True, exist_ok=True)
target.write_text(preview, encoding='utf-8')
print('Synced the isolated, fictional student preview.')
