import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import tailwind from '@astrojs/tailwind';
import simplePlantUML from '@akebifiky/remark-simple-plantuml';
import remarkGemoji from 'remark-gemoji';
import remarkGfm from 'remark-gfm';
import starlightOpenAPI, { openAPISidebarGroups } from 'starlight-openapi'
import yaml from 'js-yaml';

import vercelStatic from '@astrojs/vercel/static';


const targetDir = 'src/openapi/proto'
const openAPIDef = fs.readdirSync(targetDir, { recursive: true })
    .filter(file => file.endsWith('.yaml'))
    .map(path => {
        const doc = yaml.load(fs.readFileSync(targetDir + '/' + path, 'utf8'));
        return {
            base: path.replace(/\/[^/]*$/, ''),
            collapsed: true,
            label: doc.info.title,
            schema: targetDir + '/' + path
        }
    })
    .filter(sidebar => sidebar.label != '')

// https://astro.build/config
export default defineConfig({
    integrations: [starlight({
        plugins: [
            starlightOpenAPI(openAPIDef),
        ],
        title: "GarajonAI Docs",
        social: {
            github: 'https://github.com/garajonai/proto'
        },
        editLink: {
            baseUrl: 'https://github.com/garajonai/proto/edit/main/scripts/doc-registry/'
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
