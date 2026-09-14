# Pétanque Pro Global – Cloudflare Worker

## Warum dein bisheriger Upload die Warnung zeigt

Die Cloudflare-Seite auf deinem Screenshot ist der **Upload für statische Dateien**.
Der Ordner `functions/` wird dort nicht als Pages Function ausgeführt. Genau deshalb
erscheint „Pages functions are not supported“.

Diese Version verwendet stattdessen **einen einzigen Worker (`_worker.js`)**.
Er liefert die App aus und stellt gleichzeitig die `/api/*`-Schnittstelle bereit.

## D1 einrichten

1. Cloudflare Dashboard → Workers & Pages → D1.
2. Create database, z. B. `petanque-pro-db`.
3. `schema.sql` aus dieser ZIP-Datei in der D1-SQL-Konsole ausführen.
4. Beim Worker unter Settings → Bindings eine D1 Database hinzufügen:
   - Variable name: `DB`
   - Database: `petanque-pro-db`

## Deployment

Am zuverlässigsten:
- den Inhalt dieser ZIP in ein GitHub-Repository laden,
- in Cloudflare Workers & Pages → Create application → Import repository,
- als Worker-Konfiguration `wrangler.json` verwenden.

Alternativ mit Wrangler:
`npx wrangler deploy`

Die Datei `_worker.js` ist für einen Worker mit statischen/inline Assets vorbereitet.

## Danach

Die App kann:
- Benutzerkonten anlegen
- eigene Daten zentral speichern
- Statistiken synchronisieren
- Trainingszeiten zentral speichern
- globale Tireur-Rangliste anzeigen
- öffentliche Spielerstatistiken anzeigen

Die Tireur-Rangliste nimmt pro Spielernamen das beste Ergebnis.

Videos bleiben aktuell lokal auf dem jeweiligen iPad.
