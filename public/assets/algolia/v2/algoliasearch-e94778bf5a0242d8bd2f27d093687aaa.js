function AlgoliaExplainResults(e,t,s){function n(e,t){var s=[];if("object"==typeof e&&"matchedWords"in e&&"value"in e){for(var i=!1,o=0;o<e.matchedWords.length;++o){var a=e.matchedWords[o];a in t||(t[a]=1,i=!0)}i&&s.push(e.value)}else if("[object Array]"===Object.prototype.toString.call(e))for(var r=0;r<e.length;++r){var c=n(e[r],t);s=s.concat(c)}else if("object"==typeof e)for(var u in e)e.hasOwnProperty(u)&&(s=s.concat(n(e[u],t)));return s}function i(e,t,s){var o=e._highlightResult||e;if(-1===s.indexOf("."))return s in o?n(o[s],t):[];for(var a=s.split("."),r=o,c=0;c<a.length;++c){if("[object Array]"===Object.prototype.toString.call(r)){for(var u=[],h=0;h<r.length;++h)u=u.concat(i(r[h],t,a.slice(c).join(".")));return u}if(!(a[c]in r))return[];r=r[a[c]]}return n(r,t)}var o={},a={},r=i(e,a,t);if(o.title=r.length>0?r[0]:"",o.subtitles=[],"undefined"!=typeof s)for(var c=0;c<s.length;++c)for(var u=i(e,a,s[c]),h=0;h<u.length;++h)o.subtitles.push({attr:s[c],value:u[h]});return o}var ALGOLIA_VERSION="2.9.7",AlgoliaSearch=function(e,t,s,n,i){var o=this;this.applicationID=e,this.apiKey=t,this.dsn=!0,this.dsnHost=null,this.hosts=[],this.currentHostIndex=0,this.requestTimeoutInMs=2e3,this.extraHeaders=[],this.jsonp=null,this.options={},this.cache={};var a,r="net";if("string"==typeof s)a=s;else{var c=s||{};this.options=c,this._isUndefined(c.method)||(a=c.method),this._isUndefined(c.tld)||(r=c.tld),this._isUndefined(c.dsn)||(this.dsn=c.dsn),this._isUndefined(c.hosts)||(i=c.hosts),this._isUndefined(c.dsnHost)||(this.dsnHost=c.dsnHost),this._isUndefined(c.requestTimeoutInMs)||(this.requestTimeoutInMs=+c.requestTimeoutInMs),this._isUndefined(c.jsonp)||(this.jsonp=c.jsonp)}this._isUndefined(i)&&(i=[this.applicationID+"-1.algolianet.com",this.applicationID+"-2.algolianet.com",this.applicationID+"-3.algolianet.com"]),this.host_protocol="http://",this._isUndefined(a)||null===a?this.host_protocol=("https:"==document.location.protocol?"https":"http")+"://":("https"===a||"HTTPS"===a)&&(this.host_protocol="https://");for(var u=0;u<i.length;++u)this.hosts.push(this.host_protocol+i[u]);(this.dsn||null!=this.dsnHost)&&this.hosts.unshift(this.dsnHost?this.host_protocol+this.dsnHost:this.host_protocol+this.applicationID+"-dsn.algolia."+r),this.options.angular&&this.options.angular.$injector.invoke(["$http","$q",function(e,t){o.options.angular.$q=t,o.options.angular.$http=e}]),this._ua=this.options._ua||"Algolia for vanilla JavaScript "+window.ALGOLIA_VERSION};AlgoliaSearch.JSONPCounter=0,AlgoliaSearch.prototype={deleteIndex:function(e,t){return this._jsonRequest({method:"DELETE",url:"/1/indexes/"+encodeURIComponent(e),callback:t})},moveIndex:function(e,t,s){var n={operation:"move",destination:t};return this._jsonRequest({method:"POST",url:"/1/indexes/"+encodeURIComponent(e)+"/operation",body:n,callback:s})},copyIndex:function(e,t,s){var n={operation:"copy",destination:t};return this._jsonRequest({method:"POST",url:"/1/indexes/"+encodeURIComponent(e)+"/operation",body:n,callback:s})},getLogs:function(e,t,s){return this._isUndefined(t)&&(t=0),this._isUndefined(s)&&(s=10),this._jsonRequest({method:"GET",url:"/1/logs?offset="+t+"&length="+s,callback:e})},listIndexes:function(e,t){var s="undefined"!=typeof t?"?page="+t:"";return this._jsonRequest({method:"GET",url:"/1/indexes"+s,callback:e})},initIndex:function(e){return new this.Index(this,e)},listUserKeys:function(e){return this._jsonRequest({method:"GET",url:"/1/keys",callback:e})},getUserKeyACL:function(e,t){return this._jsonRequest({method:"GET",url:"/1/keys/"+e,callback:t})},deleteUserKey:function(e,t){return this._jsonRequest({method:"DELETE",url:"/1/keys/"+e,callback:t})},addUserKey:function(e,t){return this.addUserKeyWithValidity(e,0,0,0,t)},addUserKeyWithValidity:function(e,t,s,n,i){var o={};return o.acl=e,o.validity=t,o.maxQueriesPerIPPerHour=s,o.maxHitsPerQuery=n,this._jsonRequest({method:"POST",url:"/1/keys",body:o,callback:i})},setSecurityTags:function(e){if("[object Array]"===Object.prototype.toString.call(e)){for(var t=[],s=0;s<e.length;++s)if("[object Array]"===Object.prototype.toString.call(e[s])){for(var n=[],i=0;i<e[s].length;++i)n.push(e[s][i]);t.push("("+n.join(",")+")")}else t.push(e[s]);e=t.join(",")}this.tagFilters=e},setUserToken:function(e){this.userToken=e},startQueriesBatch:function(){this.batch=[]},addQueryInBatch:function(e,t,s){var n="query="+encodeURIComponent(t);this._isUndefined(s)||null===s||(n=this._getSearchParams(s,n)),this.batch.push({indexName:e,params:n})},clearCache:function(){this.cache={}},sendQueriesBatch:function(e,t){for(var s=this,n={requests:[]},i=0;i<s.batch.length;++i)n.requests.push(s.batch[i]);if(window.clearTimeout(s.onDelayTrigger),this._isUndefined(t)||null===t||!(t>0))return this._sendQueriesBatch(n,e);var o=window.setTimeout(function(){s._sendQueriesBatch(n,e)},t);s.onDelayTrigger=o},setRequestTimeout:function(e){e&&(this.requestTimeoutInMs=parseInt(e,10))},Index:function(e,t){this.indexName=t,this.as=e,this.typeAheadArgs=null,this.typeAheadValueOption=null,this.cache={}},setExtraHeader:function(e,t){this.extraHeaders.push({key:e,value:t})},_sendQueriesBatch:function(e,t){if(null===this.jsonp){var s=this;return this._jsonRequest({cache:this.cache,method:"POST",url:"/1/indexes/*/queries",body:e,callback:function(n,i){n?(s.jsonp=!1,t&&t(n,i)):(s.jsonp=!0,s._sendQueriesBatch(e,t))}})}if(this.jsonp){for(var n="",i=0;i<e.requests.length;++i){var o="/1/indexes/"+encodeURIComponent(e.requests[i].indexName)+"?"+e.requests[i].params;n+=i+"="+encodeURIComponent(o)+"&"}var a={params:n};return this._jsonRequest({cache:this.cache,method:"GET",url:"/1/indexes/*",body:a,callback:t})}return this._jsonRequest({cache:this.cache,method:"POST",url:"/1/indexes/*/queries",body:e,callback:t})},_jsonRequest:function(e){var t=this,s=e.callback,n=null,i=e.url,o=null;if(this.options.jQuery?(o=this.options.jQuery.$.Deferred(),o.promise=o.promise()):this.options.angular&&(o=this.options.angular.$q.defer()),this._isUndefined(e.body)||(i=e.url+"_body_"+JSON.stringify(e.body)),!this._isUndefined(e.cache)&&(n=e.cache,!this._isUndefined(n[i])))return!this._isUndefined(s)&&s&&setTimeout(function(){s(!0,n[i])},1),o&&o.resolve(n[i]),o&&o.promise;e.successiveRetryCount=0;var a=function(){if(e.successiveRetryCount>=t.hosts.length){var r={message:"Cannot connect the Algolia's Search API. Please send an email to support@algolia.com to report the issue."};return!t._isUndefined(s)&&s&&(e.successiveRetryCount=0,s(!1,r)),void(o&&o.reject(r))}e.callback=function(r,c,u){c&&!t._isUndefined(e.cache)&&(n[i]=u),!c&&r?(t.currentHostIndex=++t.currentHostIndex%t.hosts.length,e.successiveRetryCount+=1,a()):(e.successiveRetryCount=0,o&&(c?o.resolve(u):o.reject(u)),!t._isUndefined(s)&&s&&s(c,u))},e.hostname=t.hosts[t.currentHostIndex],t._jsonRequestByHost(e)};return a(),o&&o.promise},_jsonRequestByHost:function(e){var t=e.hostname+e.url;this.jsonp?this._makeJsonpRequestByHost(t,e):this.options.jQuery?this._makejQueryRequestByHost(t,e):this.options.angular?this._makeAngularRequestByHost(t,e):this._makeXmlHttpRequestByHost(t,e)},_makeAngularRequestByHost:function(e,t){var s=null;this._isUndefined(t.body)||(s=JSON.stringify(t.body)),e+=(-1===e.indexOf("?")?"?":"&")+"X-Algolia-API-Key="+this.apiKey,e+="&X-Algolia-Application-Id="+this.applicationID,this.userToken&&(e+="&X-Algolia-UserToken="+encodeURIComponent(this.userToken)),this.tagFilters&&(e+="&X-Algolia-TagFilters="+encodeURIComponent(this.tagFilters)),e+="&X-Algolia-Agent="+encodeURIComponent(this._ua);for(var n=0;n<this.extraHeaders.length;++n)e+="&"+this.extraHeaders[n].key+"="+this.extraHeaders[n].value;this.options.angular.$http({url:e,method:t.method,data:s,cache:!1,timeout:this.requestTimeoutInMs*(t.successiveRetryCount+1)}).then(function(e){t.callback(!1,!0,e.data)},function(e){0===e.status?t.callback(!0,!1,e.data):400==e.status||403===e.status||404===e.status?t.callback(!1,!1,e.data):t.callback(!0,!1,e.data)})},_makejQueryRequestByHost:function(e,t){var s=null;this._isUndefined(t.body)||(s=JSON.stringify(t.body)),e+=(-1===e.indexOf("?")?"?":"&")+"X-Algolia-API-Key="+this.apiKey,e+="&X-Algolia-Application-Id="+this.applicationID,this.userToken&&(e+="&X-Algolia-UserToken="+encodeURIComponent(this.userToken)),this.tagFilters&&(e+="&X-Algolia-TagFilters="+encodeURIComponent(this.tagFilters)),e+="&X-Algolia-Agent="+encodeURIComponent(this._ua);for(var n=0;n<this.extraHeaders.length;++n)e+="&"+this.extraHeaders[n].key+"="+this.extraHeaders[n].value;this.options.jQuery.$.ajax(e,{type:t.method,timeout:this.requestTimeoutInMs*(t.successiveRetryCount+1),dataType:"json",data:s,error:function(s,n,i){"timeout"===n?t.callback(!0,!1,{message:"Timeout - Could not connect to endpoint "+e}):400===s.status||403===s.status||404===s.status?t.callback(!1,!1,s.responseJSON):t.callback(!0,!1,{message:i})},success:function(e){t.callback(!1,!0,e)}})},_makeJsonpRequestByHost:function(e,t){if("GET"!==t.method)return void t.callback(!0,!1,{message:"Method "+t.method+" "+e+" is not supported by JSONP."});var s=!1,n=!1;AlgoliaSearch.JSONPCounter+=1;var i,o,a,r=document.getElementsByTagName("head")[0],c=document.createElement("script"),u="algoliaJSONP_"+AlgoliaSearch.JSONPCounter,h=!1;window[u]=function(e){try{delete window[u]}catch(i){window[u]=void 0}if(!n){var o=e&&e.message&&e.status||e&&200,a=200===o,r=!a&&400!==o&&403!==o&&404!==o;s=!0,t.callback(r,a,e)}},c.type="text/javascript",e+="?callback="+u+"&X-Algolia-Application-Id="+this.applicationID+"&X-Algolia-API-Key="+this.apiKey,this.tagFilters&&(e+="&X-Algolia-TagFilters="+encodeURIComponent(this.tagFilters)),this.userToken&&(e+="&X-Algolia-UserToken="+encodeURIComponent(this.userToken)),e+="&X-Algolia-Agent="+encodeURIComponent(this._ua);for(var l=0;l<this.extraHeaders.length;++l)e+="&"+this.extraHeaders[l].key+"="+this.extraHeaders[l].value;t.body&&t.body.params&&(e+="&"+t.body.params),i=setTimeout(function(){n=!0,a(),t.callback(!0,!1,{message:"Timeout - Failed to load JSONP script."})},this.requestTimeoutInMs*(t.successiveRetryCount+1)),o=function(){h||n||(h=!0,a(),s||t.callback(!0,!1,{message:"Failed to load JSONP script."}))},a=function(){clearTimeout(i),c.onload=null,c.onreadystatechange=null,c.onerror=null,r.removeChild(c);try{delete window[u],delete window[u+"_loaded"]}catch(e){window[u]=null,window[u+"_loaded"]=null}},c.onreadystatechange=function(){("loaded"===this.readyState||"complete"===this.readyState)&&o()},c.onload=function(){o()},c.onerror=function(){h||n||(a(),t.callback(!0,!1,{message:"Failed to load JSONP script."}))},c.async=!0,c.defer=!0,c.src=e,r.appendChild(c)},_makeXmlHttpRequestByHost:function(e,t){if(!this._support.cors&&!this._support.hasXDomainRequest)return void t.callback(!1,!1,{message:"CORS not supported"});var s,n,i,o=null,a=this._support.cors?new XMLHttpRequest:new XDomainRequest,r=this;this._isUndefined(t.body)||(o=JSON.stringify(t.body)),e+=(-1===e.indexOf("?")?"?":"&")+"X-Algolia-API-Key="+this.apiKey,e+="&X-Algolia-Application-Id="+this.applicationID,this.userToken&&(e+="&X-Algolia-UserToken="+encodeURIComponent(this.userToken)),this.tagFilters&&(e+="&X-Algolia-TagFilters="+encodeURIComponent(this.tagFilters)),e+="&X-Algolia-Agent="+encodeURIComponent(this._ua);for(var c=0;c<this.extraHeaders.length;++c)e+="&"+this.extraHeaders[c].key+"="+this.extraHeaders[c].value;i=function(){r._support.timeout||(n=!0,a.abort()),t.callback(!0,!1,{message:"Timeout - Could not connect to endpoint "+e})},a instanceof XMLHttpRequest?a.open(t.method,e,!0):a.open(t.method,e),this._support.cors&&null!==o&&"GET"!==t.method&&a.setRequestHeader("Content-type","application/x-www-form-urlencoded"),a.onload=function(){if(!n){r._support.timeout||clearTimeout(s);var e=null;try{e=JSON.parse(a.responseText)}catch(i){}var o=a.status||e&&e.message&&e.status||e&&200,c=200===o||201===o,u=!c&&400!==o&&403!==o&&404!==o;t.callback(u,c,e)}},a.onprogress=function(){},this._support.timeout?(a.timeout=this.requestTimeoutInMs*(t.successiveRetryCount+1),a.ontimeout=i):s=setTimeout(i,this.requestTimeoutInMs*(t.successiveRetryCount+1)),a.onerror=function(e){n||(r._support.timeout||clearTimeout(s),t.callback(!0,!1,{message:"Could not connect to host",error:e}))},a.send(o)},_getSearchParams:function(e,t){if(this._isUndefined(e)||null===e)return t;for(var s in e)null!==s&&e.hasOwnProperty(s)&&(t+=0===t.length?"?":"&",t+=s+"="+encodeURIComponent("[object Array]"===Object.prototype.toString.call(e[s])?JSON.stringify(e[s]):e[s]));return t},_isUndefined:function(e){return void 0===e},_support:{hasXMLHttpRequest:"XMLHttpRequest"in window,hasXDomainRequest:"XDomainRequest"in window,cors:"withCredentials"in new XMLHttpRequest,timeout:"timeout"in new XMLHttpRequest}},AlgoliaSearch.prototype.Index.prototype={clearCache:function(){this.cache={}},addObject:function(e,t,s){var n=this;return this.as._jsonRequest(this.as._isUndefined(s)?{method:"POST",url:"/1/indexes/"+encodeURIComponent(n.indexName),body:e,callback:t}:{method:"PUT",url:"/1/indexes/"+encodeURIComponent(n.indexName)+"/"+encodeURIComponent(s),body:e,callback:t})},addObjects:function(e,t){for(var s=this,n={requests:[]},i=0;i<e.length;++i){var o={action:"addObject",body:e[i]};n.requests.push(o)}return this.as._jsonRequest({method:"POST",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/batch",body:n,callback:t})},getObject:function(e,t,s){"[object Array]"!==Object.prototype.toString.call(t)||s||(s=t,t=null);var n=this,i="";if(!this.as._isUndefined(s)){i="?attributes=";for(var o=0;o<s.length;++o)0!==o&&(i+=","),i+=s[o]}return this.as._jsonRequest({method:"GET",url:"/1/indexes/"+encodeURIComponent(n.indexName)+"/"+encodeURIComponent(e)+i,callback:t})},partialUpdateObject:function(e,t){var s=this;return this.as._jsonRequest({method:"POST",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/"+encodeURIComponent(e.objectID)+"/partial",body:e,callback:t})},partialUpdateObjects:function(e,t){for(var s=this,n={requests:[]},i=0;i<e.length;++i){var o={action:"partialUpdateObject",objectID:e[i].objectID,body:e[i]};n.requests.push(o)}return this.as._jsonRequest({method:"POST",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/batch",body:n,callback:t})},saveObject:function(e,t){var s=this;return this.as._jsonRequest({method:"PUT",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/"+encodeURIComponent(e.objectID),body:e,callback:t})},saveObjects:function(e,t){for(var s=this,n={requests:[]},i=0;i<e.length;++i){var o={action:"updateObject",objectID:e[i].objectID,body:e[i]};n.requests.push(o)}return this.as._jsonRequest({method:"POST",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/batch",body:n,callback:t})},deleteObject:function(e,t){if(null===e||0===e.length)return void t(!1,{message:"empty objectID"});var s=this;return this.as._jsonRequest({method:"DELETE",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/"+encodeURIComponent(e),callback:t})},search:function(e,t,s,n){(void 0===e||null===e)&&(e=""),"function"==typeof e&&(t=e,e=""),"object"!=typeof t||!this.as._isUndefined(s)&&s||(s=t,t=null);var i=this,o="query="+encodeURIComponent(e);if(this.as._isUndefined(s)||null===s||(o=this.as._getSearchParams(s,o)),window.clearTimeout(i.onDelayTrigger),this.as._isUndefined(n)||null===n||!(n>0))return this._search(o,t);var a=window.setTimeout(function(){i._search(o,t)},n);i.onDelayTrigger=a},browse:function(e,t,s){+t>0&&(this.as._isUndefined(s)||!s)&&(s=t,t=null);var n=this,i="?page="+e;return this.as._isUndefined(s)||(i+="&hitsPerPage="+s),this.as._jsonRequest({method:"GET",url:"/1/indexes/"+encodeURIComponent(n.indexName)+"/browse"+i,callback:t})},ttAdapter:function(e){var t=this;return function(s,n){t.search(s,function(e,t){n(e?t.hits:t&&t.message)},e)}},waitTask:function(e,t){var s=this;return this.as._jsonRequest({method:"GET",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/task/"+e,callback:function(n,i){n?"published"===i.status?t(!0,i):setTimeout(function(){s.waitTask(e,t)},100):t(!1,i)}})},clearIndex:function(e){var t=this;return this.as._jsonRequest({method:"POST",url:"/1/indexes/"+encodeURIComponent(t.indexName)+"/clear",callback:e})},getSettings:function(e){var t=this;return this.as._jsonRequest({method:"GET",url:"/1/indexes/"+encodeURIComponent(t.indexName)+"/settings",callback:e})},setSettings:function(e,t){var s=this;return this.as._jsonRequest({method:"PUT",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/settings",body:e,callback:t})},listUserKeys:function(e){var t=this;return this.as._jsonRequest({method:"GET",url:"/1/indexes/"+encodeURIComponent(t.indexName)+"/keys",callback:e})},getUserKeyACL:function(e,t){var s=this;return this.as._jsonRequest({method:"GET",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/keys/"+e,callback:t})},deleteUserKey:function(e,t){var s=this;return this.as._jsonRequest({method:"DELETE",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/keys/"+e,callback:t})},addUserKey:function(e,t){var s=this,n={};return n.acl=e,this.as._jsonRequest({method:"POST",url:"/1/indexes/"+encodeURIComponent(s.indexName)+"/keys",body:n,callback:t})},addUserKeyWithValidity:function(e,t,s,n,i){var o=this,a={};return a.acl=e,a.validity=t,a.maxQueriesPerIPPerHour=s,a.maxHitsPerQuery=n,this.as._jsonRequest({method:"POST",url:"/1/indexes/"+encodeURIComponent(o.indexName)+"/keys",body:a,callback:i})},_search:function(e,t){var s={params:e};if(null===this.as.jsonp){var n=this;return this.as._jsonRequest({cache:this.cache,method:"POST",url:"/1/indexes/"+encodeURIComponent(this.indexName)+"/query",body:s,callback:function(s,i){var o=i&&i.status;s||o&&4===Math.floor(o/100)||1===Math.floor(o/100)?(n.as.jsonp=!1,t&&t(s,i)):(n.as.jsonp=!0,n._search(e,t))}})}return this.as._jsonRequest(this.as.jsonp?{cache:this.cache,method:"GET",url:"/1/indexes/"+encodeURIComponent(this.indexName),body:s,callback:t}:{cache:this.cache,method:"POST",url:"/1/indexes/"+encodeURIComponent(this.indexName)+"/query",body:s,callback:t})},as:null,indexName:null,typeAheadArgs:null,typeAheadValueOption:null},function(){var e=function(e){e=e||{};for(var t=1;t<arguments.length;t++)if(arguments[t])for(var s in arguments[t])arguments[t].hasOwnProperty(s)&&(e[s]=arguments[t][s]);return e};window.AlgoliaSearchHelper=function(t,s,n){var i={facets:[],disjunctiveFacets:[],hitsPerPage:20,defaultFacetFilters:[]};this.init(t,s,e({},i,n))},AlgoliaSearchHelper.prototype={init:function(e,t,s){this.client=e,this.index=t,this.options=s,this.page=0,this.refinements={},this.excludes={},this.disjunctiveRefinements={},this.extraQueries=[]},search:function(e,t,s){this.q=e,this.searchCallback=t,this.searchParams=s||{},this.page=this.page||0,this.refinements=this.refinements||{},this.disjunctiveRefinements=this.disjunctiveRefinements||{},this._search()},clearRefinements:function(){this.disjunctiveRefinements={},this.refinements={}},addDisjunctiveRefine:function(e,t){this.disjunctiveRefinements=this.disjunctiveRefinements||{},this.disjunctiveRefinements[e]=this.disjunctiveRefinements[e]||{},this.disjunctiveRefinements[e][t]=!0},removeDisjunctiveRefine:function(e,t){this.disjunctiveRefinements=this.disjunctiveRefinements||{},this.disjunctiveRefinements[e]=this.disjunctiveRefinements[e]||{};try{delete this.disjunctiveRefinements[e][t]}catch(s){this.disjunctiveRefinements[e][t]=void 0}},addRefine:function(e,t){var s=e+":"+t;this.refinements=this.refinements||{},this.refinements[s]=!0},removeRefine:function(e,t){var s=e+":"+t;this.refinements=this.refinements||{},this.refinements[s]=!1},addExclude:function(e,t){var s=e+":-"+t;this.excludes=this.excludes||{},this.excludes[s]=!0},removeExclude:function(e,t){var s=e+":-"+t;this.excludes=this.excludes||{},this.excludes[s]=!1},toggleExclude:function(e,t){for(var s=0;s<this.options.facets.length;++s)if(this.options.facets[s]==e){var n=e+":-"+t;return this.excludes[n]=!this.excludes[n],this.page=0,this._search(),!0}return!1},toggleRefine:function(e,t){for(var s=0;s<this.options.facets.length;++s)if(this.options.facets[s]==e){var n=e+":"+t;return this.refinements[n]=!this.refinements[n],this.page=0,this._search(),!0}this.disjunctiveRefinements[e]=this.disjunctiveRefinements[e]||{};for(var i=0;i<this.options.disjunctiveFacets.length;++i)if(this.options.disjunctiveFacets[i]==e)return this.disjunctiveRefinements[e][t]=!this.disjunctiveRefinements[e][t],this.page=0,this._search(),!0;return!1},isRefined:function(e,t){var s=e+":"+t;return this.refinements[s]?!0:this.disjunctiveRefinements[e]&&this.disjunctiveRefinements[e][t]?!0:!1},isExcluded:function(e,t){var s=e+":-"+t;return this.excludes[s]?!0:!1},nextPage:function(){this._gotoPage(this.page+1)},previousPage:function(){this.page>0&&this._gotoPage(this.page-1)},gotoPage:function(e){this._gotoPage(e)},setPage:function(e){this.page=e},setIndex:function(e){this.index=e},getIndex:function(){return this.index},clearExtraQueries:function(){this.extraQueries=[]},addExtraQuery:function(e,t,s){this.extraQueries.push({index:e,query:t,params:s||{}})},_gotoPage:function(e){this.page=e,this._search()},_search:function(){this.client.startQueriesBatch(),this.client.addQueryInBatch(this.index,this.q,this._getHitsSearchParams());var e=[],t={},s=0;for(s=0;s<this.options.disjunctiveFacets.length;++s){var n=this.options.disjunctiveFacets[s];this._hasDisjunctiveRefinements(n)?e.push(n):t[n]=!0}for(s=0;s<e.length;++s)this.client.addQueryInBatch(this.index,this.q,this._getDisjunctiveFacetSearchParams(e[s]));for(s=0;s<this.extraQueries.length;++s)this.client.addQueryInBatch(this.extraQueries[s].index,this.extraQueries[s].query,this.extraQueries[s].params);var i=this;this.client.sendQueriesBatch(function(n,o){if(!n)return void i.searchCallback(!1,o);var a=o.results[0];a.disjunctiveFacets=a.disjunctiveFacets||{},a.facets_stats=a.facets_stats||{};for(var r in t)if(a.facets[r]&&!a.disjunctiveFacets[r]){a.disjunctiveFacets[r]=a.facets[r];try{delete a.facets[r]}catch(c){a.facets[r]=void 0}}for(s=0;s<e.length;++s){for(var u in o.results[s+1].facets)if(a.disjunctiveFacets[u]=o.results[s+1].facets[u],i.disjunctiveRefinements[u])for(var h in i.disjunctiveRefinements[u])!a.disjunctiveFacets[u][h]&&i.disjunctiveRefinements[u][h]&&(a.disjunctiveFacets[u][h]=0);for(var l in o.results[s+1].facets_stats)a.facets_stats[l]=o.results[s+1].facets_stats[l]}a.facetStats=a.facets_stats;for(var d in i.excludes)if(i.excludes[d]){var c=d.indexOf(":-"),r=d.slice(0,c),h=d.slice(c+2);a.facets[r]=a.facets[r]||{},a.facets[r][h]||(a.facets[r][h]=0)}if(0===i.extraQueries.length)i.searchCallback(!0,a);else{var f={results:[a]};for(s=0;s<i.extraQueries.length;++s)f.results.push(o.results[1+e.length+s]);i.searchCallback(!0,f)}})},_getHitsSearchParams:function(){var t=[],s=0;for(s=0;s<this.options.facets.length;++s)t.push(this.options.facets[s]);for(s=0;s<this.options.disjunctiveFacets.length;++s){var n=this.options.disjunctiveFacets[s];this._hasDisjunctiveRefinements(n)||t.push(n)}return e({},{hitsPerPage:this.options.hitsPerPage,page:this.page,facets:t,facetFilters:this._getFacetFilters()},this.searchParams)},_getDisjunctiveFacetSearchParams:function(t){return e({},this.searchParams,{hitsPerPage:1,page:0,attributesToRetrieve:[],attributesToHighlight:[],attributesToSnippet:[],facets:t,facetFilters:this._getFacetFilters(t),analytics:!1})},_hasDisjunctiveRefinements:function(e){for(var t in this.disjunctiveRefinements[e])if(this.disjunctiveRefinements[e][t])return!0;return!1},_getFacetFilters:function(e){var t=[];if(this.options.defaultFacetFilters)for(var s=0;s<this.options.defaultFacetFilters.length;++s)t.push(this.options.defaultFacetFilters[s]);for(var n in this.refinements)this.refinements[n]&&t.push(n);for(var n in this.excludes)this.excludes[n]&&t.push(n);for(var i in this.disjunctiveRefinements)if(i!=e){var o=[];for(var a in this.disjunctiveRefinements[i])this.disjunctiveRefinements[i][a]&&o.push(i+":"+a);o.length>0&&t.push(o)}return t}}}(),function(){window.AlgoliaPlaces=function(e,t){this.init(e,t)},AlgoliaPlaces.prototype={init:function(e,t){this.client=new AlgoliaSearch(e,t,"http",!0,["places-1.algolia.io","places-2.algolia.io","places-3.algolia.io"]),this.cache={}},search:function(e,t,s){var n="query="+encodeURIComponent(e);this.client._isUndefined(s)||null==s||(n=this.client._getSearchParams(s,n));var i={params:n,apiKey:this.client.apiKey,appID:this.client.applicationID};this.client._jsonRequest({cache:this.cache,method:"POST",url:"/1/places/query",body:i,callback:t,removeCustomHTTPHeaders:!0})}}}(),"object"!=typeof JSON&&(JSON={}),function(){"use strict";function f(e){return 10>e?"0"+e:e}function quote(e){return escapable.lastIndex=0,escapable.test(e)?'"'+e.replace(escapable,function(e){var t=meta[e];return"string"==typeof t?t:"\\u"+("0000"+e.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+e+'"'}function str(e,t){var s,n,i,o,a,r=gap,c=t[e];switch(c&&"object"==typeof c&&"function"==typeof c.toJSON&&(c=c.toJSON(e)),"function"==typeof rep&&(c=rep.call(t,e,c)),typeof c){case"string":return quote(c);case"number":return isFinite(c)?String(c):"null";case"boolean":case"null":return String(c);case"object":if(!c)return"null";if(gap+=indent,a=[],"[object Array]"===Object.prototype.toString.apply(c)){for(o=c.length,s=0;o>s;s+=1)a[s]=str(s,c)||"null";return i=0===a.length?"[]":gap?"[\n"+gap+a.join(",\n"+gap)+"\n"+r+"]":"["+a.join(",")+"]",gap=r,i}if(rep&&"object"==typeof rep)for(o=rep.length,s=0;o>s;s+=1)"string"==typeof rep[s]&&(n=rep[s],i=str(n,c),i&&a.push(quote(n)+(gap?": ":":")+i));else for(n in c)Object.prototype.hasOwnProperty.call(c,n)&&(i=str(n,c),i&&a.push(quote(n)+(gap?": ":":")+i));return i=0===a.length?"{}":gap?"{\n"+gap+a.join(",\n"+gap)+"\n"+r+"}":"{"+a.join(",")+"}",gap=r,i}}"function"!=typeof Date.prototype.toJSON&&(Date.prototype.toJSON=function(){return isFinite(this.valueOf())?this.getUTCFullYear()+"-"+f(this.getUTCMonth()+1)+"-"+f(this.getUTCDate())+"T"+f(this.getUTCHours())+":"+f(this.getUTCMinutes())+":"+f(this.getUTCSeconds())+"Z":null},String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(){return this.valueOf()});var cx,escapable,gap,indent,meta,rep;"function"!=typeof JSON.stringify&&(escapable=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,meta={"\b":"\\b","	":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},JSON.stringify=function(e,t,s){var n;if(gap="",indent="","number"==typeof s)for(n=0;s>n;n+=1)indent+=" ";else"string"==typeof s&&(indent=s);if(rep=t,t&&"function"!=typeof t&&("object"!=typeof t||"number"!=typeof t.length))throw new Error("JSON.stringify");return str("",{"":e})}),"function"!=typeof JSON.parse&&(cx=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,JSON.parse=function(text,reviver){function walk(e,t){var s,n,i=e[t];if(i&&"object"==typeof i)for(s in i)Object.prototype.hasOwnProperty.call(i,s)&&(n=walk(i,s),void 0!==n?i[s]=n:delete i[s]);return reviver.call(e,t,i)}var j;if(text=String(text),cx.lastIndex=0,cx.test(text)&&(text=text.replace(cx,function(e){return"\\u"+("0000"+e.charCodeAt(0).toString(16)).slice(-4)})),/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,"")))return j=eval("("+text+")"),"function"==typeof reviver?walk({"":j},""):j;throw new SyntaxError("JSON.parse")})}();