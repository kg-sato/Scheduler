"""Copy the canonical HTML into the native app bundle before building."""
from pathlib import Path
import shutil

root = Path(__file__).resolve().parent.parent
shutil.copyfile(root / 'Application.html', root / 'Scheduler' / 'Application.html')
print('Synced Application.html into the iPhone app bundle.')
