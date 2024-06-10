import { readFileSync } from 'fs';
import type trackHarTranslationsEn from 'trackhar/i18n/en.json';

/** The string translations. */
export const translations = {
    en: JSON.parse(
        readFileSync(new URL('../../node_modules/trackhar/i18n/en.json', import.meta.url), 'utf-8')
    ) as typeof trackHarTranslationsEn,
};

/** The Typst template files. */
export const templates = {
    en: {
        report: readFileSync(new URL('../../templates/en/report.typ', import.meta.url), 'utf-8'),
        notice: readFileSync(new URL('../../templates/en/notice.typ', import.meta.url), 'utf-8'),
        complaint: readFileSync(new URL('../../templates/en/complaint.typ', import.meta.url), 'utf-8'),
        style: readFileSync(new URL('../../templates/en/style.typ', import.meta.url), 'utf-8'),
    },
};

/** The languages that translations and templates are available for. */
export const supportedLanguages = Object.keys(translations).filter((l) =>
    Object.keys(templates).includes(l)
) as SupportedLanguage[];

/** A language that translations and templates are available for. */
export type SupportedLanguage = keyof typeof templates & keyof typeof translations;
