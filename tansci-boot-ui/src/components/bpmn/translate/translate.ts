import translations from "./zh";

export default function customTranslate(template:any, replacements:any) {
    replacements = replacements || {};
    template = translations[template] || template;
    return template.replace(/{([^}]+)}/g, function(_, key) {
        let str = replacements[key];
        if (
            translations[replacements[key]] !== null &&
            translations[replacements[key]] !== "undefined"
        ) {
            str = translations[replacements[key]];
        }
        return str || "{" + key + "}";
    });
}