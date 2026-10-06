"""Copy canonical HTML into the native bundle, omitting web-only install metadata."""
from pathlib import Path
import re

root = Path(__file__).resolve().parent.parent
source = (root / 'Application.html').read_text(encoding='utf-8')
source = re.sub(r'<link\s+rel="(?:manifest|apple-touch-icon)"[^>]*>\s*', '', source)
(root / 'Scheduler' / 'Application.html').write_text(source, encoding='utf-8')
print('Synced Application.html into the iPhone app bundle.')
