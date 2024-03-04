import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import tailwind from '@astrojs/tailwind';
import simplePlantUML from '@akebifiky/remark-simple-plantuml';
import remarkGemoji from 'remark-gemoji';
import remarkGfm from 'remark-gfm';
import starlightOpenAPI, { openAPISidebarGroups } from 'starlight-openapi'

import vercelStatic from '@astrojs/vercel/static';

// https://astro.build/config
export default defineConfig({
    integrations: [starlight({
        plugins: [
            starlightOpenAPI([
                {
                    base: 'penapi/pet',
                    collapsed: true,
                    label: 'Pet',
                    schema: 'src/openapi/test/petstore-expanded.yaml',
                },
            ]),
        ],
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
            collapsed: true
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
            items: openAPISidebarGroups,
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
        remarkPlugins: [simplePlantUML, remarkGemoji, remarkGfm],
        shikiConfig: {
            theme: 'github-dark'
        }
    },
    output: "static",
    adapter: vercelStatic(),
});
