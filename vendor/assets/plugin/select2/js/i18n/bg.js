/*! Select2 4.0.0-rc.2 | https://github.com/select2/select2/blob/master/LICENSE.md */

(function(){if(jQuery&&jQuery.fn&&jQuery.fn.select2&&jQuery.fn.select2.amd)var e=jQuery.fn.select2.amd;return e.define("select2/i18n/bg",[],function(){return{inputTooLong:function(e){var t=e.input.length-e.maximum,n="   "+t+" - ";return t>1&&(n+="a"),n},inputTooShort:function(e){var t=e.minimum-e.input.length,n="   "+t+" ";return t>1&&(n+="a"),n},loadingMore:function(){return"  "},maximumSelected:function(e){var t="    "+e.maximum+" ";return e.maximum>1?t+="":t+="",t},noResults:function(){return"  "},searching:function(){return""}}}),{define:e.define,require:e.require}})();