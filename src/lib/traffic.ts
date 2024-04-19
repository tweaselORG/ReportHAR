import type { Har } from 'har-format';
import { adapters, type Adapter, type AnnotatedResult, type processRequest } from 'trackhar';
import { unhar, type HarEntry } from '../lib/har2pdf';

export type PrepareTrafficOptions = {
    har: Har;
    trackHarResult: ReturnType<typeof processRequest>[];

    entryFilter?: (entry: {
        harIndex: number;
        harEntry?: HarEntry;
        adapter: string;
        transmissions: AnnotatedResult;
    }) => boolean;
};

export const prepareTraffic = (options: PrepareTrafficOptions) => {
    const harEntries = unhar(options.har);
    const trackHarResult = options.trackHarResult
        .map((transmissions, harIndex) =>
            !transmissions || transmissions.length === 0
                ? null
                : {
                      harIndex,
                      harEntry: harEntries[harIndex],
                      // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                      adapter: transmissions[0]!.adapter,
                      transmissions,
                  }
        )
        .filter((e): e is NonNullable<typeof e> => e !== null)
        .filter(options.entryFilter ?? (() => true));
    const findings = trackHarResult.reduce<
        Record<
            string,
            { adapter: Adapter; requests: typeof trackHarResult; receivedData: Record<string, Array<string>> }
        >
    >((acc, req) => {
        if (!acc[req.adapter]) {
            const adapter = adapters.find((a) => a.tracker.slug + '/' + a.slug === req.adapter);
            if (!adapter) throw new Error(`Unknown adapter: ${req.adapter}`);
            acc[req.adapter] = {
                adapter,
                requests: [],
                receivedData: {},
            };
        }

        // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
        acc[req.adapter]!.requests.push(req);

        for (const transmission of req.transmissions) {
            const property = String(transmission.property);

            if (!acc[req.adapter]?.receivedData[property]) {
                // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                acc[req.adapter]!.receivedData[property] = [];
            }

            // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
            acc[req.adapter]!.receivedData[property] = [
                // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                ...new Set([...acc[req.adapter]!.receivedData[property]!, transmission.value]),
            ];
        }

        return acc;
    }, {});

    return { harEntries, trackHarResult, findings };
};
