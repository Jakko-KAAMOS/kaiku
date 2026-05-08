# BUGS.md — kaiku/contrib

*Filed against väri.html and the colour vocabulary. Not against the world.*

---

## open

### BUG-001 · violetti gap — no violet in kaiku palette
**Filed:** 2026-05-05  
**Where:** kaiku/contrib/väri.html — the 27-tone subset  
**What:** The games (birch, kuule) use deep violet. The kaiku palette has none. The gap between the cool register (järvi, taivas) and the foliage register (lehto, sammal) contains no violet or lilac family. A graphic designer working in kaiku cannot reach for violet without leaving the system.  
**Severity:** Aesthetic. Not blocking. The games render correctly because they define their colours locally. The gap becomes visible when someone reads the full palette and notices the spectral skip.  
**Resolution path:** Name the colour. Place it in the spectrum. Defend the rekoturokaija. Then add it.

---

## closed

### BUG-002 · järvi anchor — empty fragment in exemplar.html
**Filed:** 2026-05-05  
**Closed:** 2026-05-05  
**Where:** rebraining/exemplar.html line 624 — prose demo section  
**What:** `<a href="#">järvi</a>` — the fragment was empty. Clicking järvi scrolled to top.  
**Fix:** `href="/kaiku/väri#järvi"`. järvi is in the kaiku 27-tone subset; colour links that resolve within the kaiku palette now point into the kaiku palette, not into the larger exemplar. The graphic designer's workflow stays inside the tool.  
**Rule established:** If a colour exists in the kaiku palette, colour links resolve to `/kaiku/väri#colour-name`. Only reach out to `exemplar.html` for colours outside the 27-tone subset.

### BUG-003 · napit.html site-mark — rebraining.org linked to /sanasto
**Filed:** 2026-05-05  
**Closed:** 2026-05-05  
**Where:** rebraining/napit.html line 270 — header site-mark  
**What:** `<a href="sanasto">rebraining.org</a>` — the home breadcrumb pointed to /sanasto instead of /.  
**Fix:** `href="/"`.
