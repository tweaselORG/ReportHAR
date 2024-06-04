import { readFileSync } from 'fs';
import type trackHarTranslationsEn from 'trackhar/i18n/en.json';

export const translations = {
    en: JSON.parse(
        readFileSync(new URL('../../node_modules/trackhar/i18n/en.json', import.meta.url), 'utf-8')
    ) as typeof trackHarTranslationsEn,
};

export const templates = {
    en: {
        report: readFileSync(new URL('../../templates/en/report.typ', import.meta.url), 'utf-8'),
        notice: readFileSync(new URL('../../templates/en/notice.typ', import.meta.url), 'utf-8'),
        complaint: readFileSync(new URL('../../templates/en/complaint.typ', import.meta.url), 'utf-8'),
        style: readFileSync(new URL('../../templates/en/style.typ', import.meta.url), 'utf-8'),
    },
};

/** A language that translations are available for. */
export type SupportedLanguage = keyof typeof templates & keyof typeof translations;
