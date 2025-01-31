import fs from 'fs';
import type trackHarTranslationsDe from 'trackhar/i18n/de.json';
import type trackHarTranslationsEn from 'trackhar/i18n/en.json';

/** The string translations. */
export const translations = {
    en: JSON.parse(
        fs.readFileSync(__dirname + '/../../node_modules/trackhar/i18n/en.json', 'utf-8')
    ) as typeof trackHarTranslationsEn,
    de: JSON.parse(
        fs.readFileSync(__dirname + '/../../node_modules/trackhar/i18n/de.json', 'utf-8')
    ) as typeof trackHarTranslationsDe,
};

/** The Typst template files. */
export const templates = {
    en: {
        report: fs.readFileSync(__dirname + '/../../templates/en/report.typ', 'utf-8'),
        notice: fs.readFileSync(__dirname + '/../../templates/en/notice.typ', 'utf-8'),
        complaint: fs.readFileSync(__dirname + '/../../templates/en/complaint.typ', 'utf-8'),
        style: fs.readFileSync(__dirname + '/../../templates/en/style.typ', 'utf-8'),
    },
    de: {
        report: fs.readFileSync(__dirname + '/../../templates/de/report.typ', 'utf-8'),
        notice: fs.readFileSync(__dirname + '/../../templates/de/notice.typ', 'utf-8'),
        complaint: fs.readFileSync(__dirname + '/../../templates/de/complaint.typ', 'utf-8'),
        style: fs.readFileSync(__dirname + '/../../templates/de/style.typ', 'utf-8'),
    },
};

/** The languages that translations and templates are available for. */
export const supportedLanguages = Object.keys(translations).filter((l) =>
    Object.keys(templates).includes(l)
) as SupportedLanguage[];

/** A language that translations and templates are available for. */
export type SupportedLanguage = keyof typeof templates & keyof typeof translations;
