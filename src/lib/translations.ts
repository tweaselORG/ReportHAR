import { readFileSync } from 'fs';
import trackHarTranslationsEn from 'trackhar/i18n/en.json';

export const translations = {
    en: trackHarTranslationsEn,
};

export const templates = {
    en: {
        report: readFileSync(new URL('../../templates/en/report.typ', import.meta.url), 'utf-8'),
        notice: readFileSync(new URL('../../templates/en/notice.typ', import.meta.url), 'utf-8'),
        complaint: readFileSync(new URL('../../templates/en/complaint.typ', import.meta.url), 'utf-8'),
        style: readFileSync(new URL('../../templates/en/style.typ', import.meta.url), 'utf-8'),
    },
};

export type SupportedLanguage = keyof typeof templates & keyof typeof translations;
