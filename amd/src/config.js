define([], function () {
    window.requirejs.config({
        paths: {
            'ansi_up': M.cfg.wwwroot + '/mod/openstudio/js/ansi_up.min',
            'es5-shim': M.cfg.wwwroot + '/mod/openstudio/js/es5-shim.min',
            'marked': M.cfg.wwwroot + '/mod/openstudio/js/marked.min',
            'notebook': M.cfg.wwwroot + '/mod/openstudio/js/notebook.min',
            'prism': M.cfg.wwwroot + '/mod/openstudio/js/prism.min',
        },
        shim: {
            //Enter the "names" that will be used to refer to your libraries
            'ansi_up': {exports: 'ansi_up'},
            'es5-shim': {exports: 'es5-shim'},
            'marked': {exports: 'marked'},
            'notebook': {deps: ['marked'], exports: 'notebook'},
            'prism': {exports: 'Prism'}
        }
    });
});
