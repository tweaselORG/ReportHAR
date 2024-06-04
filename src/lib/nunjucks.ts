import Nunjucks from '@tweasel/nunjucks';
import { translations, type SupportedLanguage } from './translations';

export type RenderNunjucksOptions = {
    template: string;
    language: SupportedLanguage;
    context: Record<string, unknown>;
};

export const renderNunjucks = (options: RenderNunjucksOptions) => {
    const nunjucks = Nunjucks.configure({ autoescape: true, throwOnUndefined: true });
    nunjucks.addFilter('dateFormat', (date: Date | string | undefined, includeTime = true) =>
        date
            ? new Date(date).toLocaleString(options.language, {
                  dateStyle: 'long',
                  timeStyle: includeTime ? 'long' : undefined,
              })
            : undefined
    );
    nunjucks.addFilter('timeFormat', (date: Date | string | undefined) =>
        date ? new Date(date).toLocaleTimeString(options.language) : undefined
    );
    // Wrap content in a raw/code block, properly escaping user input.
    nunjucks.addFilter(
        'code',
        (s: string | undefined) =>
            new Nunjucks.runtime.SafeString(s === undefined ? '' : `\`\`\` ${(s + '').replace(/`/g, '`\u200b')}\`\`\``)
    );
    // Convert string from TrackHAR's markup language to Typst.
    nunjucks.addFilter('trackharMl', (str: string) => str.replace(/\s*\[(https?:\/\/.+?)\]/g, '#footnote[$1]'));
    // Translate.
    nunjucks.addGlobal(
        't',
        <TScope extends keyof (typeof translations)['en']>(
            scope: TScope,
            key: keyof (typeof translations)['en'][TScope] & string
        ) => (
            (() => {
                const translation = translations[options.language][scope][key];
                if (!translation) throw new Error(`Translation not found: ${scope}::${key}`);
            })(),
            translations[options.language][scope][key]
        )
    );

    return nunjucks.renderString(options.template, options.context);
};
