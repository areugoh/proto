import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import tailwind from '@astrojs/tailwind';
import simplePlantUML from '@akebifiky/remark-simple-plantuml';
import remarkEmoji from 'remark-emoji';
import remarkGfm from 'remark-gfm';

import vercelStatic from '@astrojs/vercel/static';

// https://astro.build/config
export default defineConfig({
    integrations: [starlight({
        title: "Hoguera Docs",
        social: {
            github: 'https://github.com/areugoh/proto'
        },
        editLink: {
            baseUrl: 'https://github.com/areugoh/proto/edit/main/scripts/doc-registry/'
        },
        sidebar: [{
            label: 'Start here',
            autogenerate: {
                directory: 'start',
                collapsed: true
            },
            collapsed: false
        }, {
            label: 'SDK',
            autogenerate: {
                directory: 'sdk'
            },
            collapsed: false
        }, {
            label: 'Design documents',
            autogenerate: {
                directory: 'design'
            },
            collapsed: true
        }, {
            label: 'Protobuf',
            autogenerate: {
                directory: 'proto'
            },
            badge: {
                text: 'Auto',
                variant: 'note'
            },
            collapsed: true
        }, {
            label: 'OpenAPI',
            autogenerate: {
                directory: 'openapi'
            },
            collapsed: true,
            badge: {
                text: 'Auto',
                variant: 'note'
            }
        }, {
            label: 'Guides',
            autogenerate: {
                directory: 'guides'
            },
            collapsed: true
        }],
        customCss: ['./src/tailwind.css'],
        lastUpdated: true
    }), tailwind({
        applyBaseStyles: false
    })],
    markdown: {
        remarkPlugins: [simplePlantUML, remarkEmoji, remarkGfm],
        shikiConfig: {
            theme: 'github-dark'
        }
    },
    output: "static",
    adapter: vercelStatic(),
});
