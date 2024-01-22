import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import tailwind from '@astrojs/tailwind';

import simplePlantUML from '@akebifiky/remark-simple-plantuml';


// https://astro.build/config
export default defineConfig({
    integrations: [
        starlight({
            title: "Hoguera Docs",
            social: {
                github: 'https://github.com/areugoh/proto',
            },
            sidebar: [
                {
                    label: 'Design documents',
                    autogenerate: { directory: 'design' },
                    collapsed: true,
                },
                {
                    label: 'Protobuf',
                    autogenerate: { directory: 'protobuf' },
                    collapsed: true,
                },
                {
                    label: 'OpenAPI',
                    autogenerate: { directory: 'openapi' },
                    collapsed: true,
                },
            ],
            customCss: ['./src/tailwind.css'],
            lastUpdated: true,

        }),
        tailwind({ applyBaseStyles: false }),
    ],
    markdown: {
        remarkPlugins: [
            simplePlantUML,
        ],
    },
});
