import fs from 'fs';
import { join } from 'path';
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

const templateFolder = join(__dirname, '/../../templates');

/** The Typst template files. */
export const templates = {
    mobile: {
        en: {
            report: fs.readFileSync(join(templateFolder, 'mobile/en/report.typ'), 'utf-8'),
            notice: fs.readFileSync(join(templateFolder, 'mobile/en/notice.typ'), 'utf-8'),
            complaint: fs.readFileSync(join(templateFolder, 'mobile/en/complaint.typ'), 'utf-8'),
            style: fs.readFileSync(join(templateFolder, 'mobile/en/style.typ'), 'utf-8'),
        },
        de: {
            report: fs.readFileSync(join(templateFolder, 'mobile/de/report.typ'), 'utf-8'),
            notice: fs.readFileSync(join(templateFolder, 'mobile/de/notice.typ'), 'utf-8'),
            complaint: fs.readFileSync(join(templateFolder, 'mobile/de/complaint.typ'), 'utf-8'),
            style: fs.readFileSync(join(templateFolder, 'mobile/de/style.typ'), 'utf-8'),
        },
    },
    web: {
        en: {
            report: fs.readFileSync(join(templateFolder, 'web/en/report.typ'), 'utf-8'),
            notice: fs.readFileSync(join(templateFolder, 'web/en/notice.typ'), 'utf-8'),
            complaint: fs.readFileSync(join(templateFolder, 'web/en/complaint.typ'), 'utf-8'),
            style: fs.readFileSync(join(templateFolder, 'web/en/style.typ'), 'utf-8'),
        },
        de: {
            report: fs.readFileSync(join(templateFolder, 'web/en/report.typ'), 'utf-8'),
            notice: fs.readFileSync(join(templateFolder, 'web/en/notice.typ'), 'utf-8'),
            complaint: fs.readFileSync(join(templateFolder, 'web/en/complaint.typ'), 'utf-8'),
            style: fs.readFileSync(join(templateFolder, 'web/en/style.typ'), 'utf-8'),
        },
    },
};

/** The languages that translations and templates are available for. */
export const supportedLanguages = Object.keys(translations).filter((l) =>
    Object.keys(templates).includes(l)
) as SupportedLanguage[];

/** A language that translations and templates are available for. */
export type SupportedLanguage = keyof (typeof templates)['mobile'] &
    keyof (typeof templates)['web'] &
    keyof typeof translations;
