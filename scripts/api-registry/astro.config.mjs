import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import tailwind from '@astrojs/tailwind';

// https://astro.build/config
export default defineConfig({
    integrations: [
        starlight({
            title: "Hoguera's Docs",
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
        }),
        tailwind({ applyBaseStyles: false }),
    ],
});
