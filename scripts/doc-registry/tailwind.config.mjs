import colors from 'tailwindcss/colors';
import starlightPlugin from '@astrojs/starlight-tailwind';

/** @type {import('tailwindcss').Config} */
export default {
    content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
    theme: {
        extend: {
            fontFamily: {
                sans: ['"Onest Variable"'],
            },
            colors: {
                // Your preferred accent color. Indigo is closest to Starlight’s defaults.
                accent: {
                    DEFAULT: "#00A36C",
                    50: "#00A86B",
                    100: "#00a86b",
                    200: "#009760",
                    300: "#008656",
                    400: "#00764b",
                    500: "#006540",
                    600: "#005436",
                    700: "#00432b",
                    800: "#003220",
                    900: "#00A36C"
                },
                // Your preferred gray scale. Zinc is closest to Starlight’s defaults.
                gray: colors.zinc,

                // Your preferred language colors.
                jade: '#00A36C',
                golang: '#29beb0',
                rust: '#ce422b',
                nodejs: '#215732',
            },
        },
    },
    plugins: [starlightPlugin()],
};
