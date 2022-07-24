// Types for compiled templates
declare module 'liturgical-year/templates/*' {
  import type { TemplateFactory } from 'htmlbars-inline-precompile';
  const tmpl: TemplateFactory;
  export default tmpl;
}

declare module '*.css' {
  const styles: Record<string, string>;
  export default styles;
}
