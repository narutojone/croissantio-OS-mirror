!function(e,t){"function"==typeof define&&define.amd?define([],t):"object"==typeof exports?module.exports=t():t()}(this,function(){function e(e){if(null===g){for(var t=e.length,i=0,n=document.getElementById(s),a="<ul>";t>i;)a+="<li>"+e[i]+"</li>",i++;n.innerHTML=a+"</ul>"}else g(e)}function t(e){return e.replace(/<b[^>]*>(.*?)<\/b>/gi,function(e,t){return t}).replace(/class="(?!(tco-hidden|tco-display|tco-ellipsis))+.*?"|data-query-source=".*?"|dir=".*?"|rel=".*?"/gi,"")}function i(e){e=e.getElementsByTagName("a");for(var t=e.length-1;t>=0;t--)e[t].setAttribute("target","_blank")}function n(e,t){for(var i=[],n=new RegExp("(^| )"+t+"( |$)"),a=e.getElementsByTagName("*"),s=0,l=a.length;l>s;s++)n.test(a[s].className)&&i.push(a[s]);return i}function a(e){return void 0!==e&&0<=e.innerHTML.indexOf("data-srcset")?(e=e.innerHTML.match(/data-srcset="([A-z0-9%_\.-]+)/i)[0],decodeURIComponent(e).split('"')[1]):void 0}var s="",l=20,r=!0,o=[],c=!1,d=!0,m=!0,p=null,u=!0,h=!0,g=null,w=!0,f=!1,v=!0,b=!0,y=!1,T=null,k={fetch:function(e){if(void 0===e.maxTweets&&(e.maxTweets=20),void 0===e.enableLinks&&(e.enableLinks=!0),void 0===e.showUser&&(e.showUser=!0),void 0===e.showTime&&(e.showTime=!0),void 0===e.dateFunction&&(e.dateFunction="default"),void 0===e.showRetweet&&(e.showRetweet=!0),void 0===e.customCallback&&(e.customCallback=null),void 0===e.showInteraction&&(e.showInteraction=!0),void 0===e.showImages&&(e.showImages=!1),void 0===e.linksInNewWindow&&(e.linksInNewWindow=!0),void 0===e.showPermalinks&&(e.showPermalinks=!0),void 0===e.dataOnly&&(e.dataOnly=!1),c)o.push(e);else{c=!0,s=e.domId,l=e.maxTweets,r=e.enableLinks,m=e.showUser,d=e.showTime,h=e.showRetweet,p=e.dateFunction,g=e.customCallback,w=e.showInteraction,f=e.showImages,v=e.linksInNewWindow,b=e.showPermalinks,y=e.dataOnly;var t=document.getElementsByTagName("head")[0];null!==T&&t.removeChild(T),T=document.createElement("script"),T.type="text/javascript",T.src=void 0!==e.list?"https://syndication.twitter.com/timeline/list?callback=twitterFetcher.callback&dnt=false&list_slug="+e.list.listSlug+"&screen_name="+e.list.screenName+"&suppress_response_codes=true&lang="+(e.lang||"en")+"&rnd="+Math.random():void 0!==e.profile?"https://syndication.twitter.com/timeline/profile?callback=twitterFetcher.callback&dnt=false&screen_name="+e.profile.screenName+"&suppress_response_codes=true&lang="+(e.lang||"en")+"&rnd="+Math.random():void 0!==e.likes?"https://syndication.twitter.com/timeline/likes?callback=twitterFetcher.callback&dnt=false&screen_name="+e.likes.screenName+"&suppress_response_codes=true&lang="+(e.lang||"en")+"&rnd="+Math.random():"https://cdn.syndication.twimg.com/widgets/timelines/"+e.id+"?&lang="+(e.lang||"en")+"&callback=twitterFetcher.callback&suppress_response_codes=true&rnd="+Math.random(),t.appendChild(T)}},callback:function(s){function g(e){var t=e.getElementsByTagName("img")[0];return t.src=t.getAttribute("data-src-2x"),e}s.body=s.body.replace(/(<img[^c]*class="Emoji[^>]*>)|(<img[^c]*class="u-block[^>]*>)/g,""),f||(s.body=s.body.replace(/(<img[^c]*class="NaturalImage-image[^>]*>|(<img[^c]*class="CroppedImage-image[^>]*>))/g,"")),m||(s.body=s.body.replace(/(<img[^c]*class="Avatar"[^>]*>)/g,""));var T=document.createElement("div");T.innerHTML=s.body,"undefined"==typeof T.getElementsByClassName&&(u=!1),s=[];var C=[],_=[],N=[],x=[],E=[],I=[],A=0;if(u)for(T=T.getElementsByClassName("timeline-Tweet");A<T.length;)x.push(0<T[A].getElementsByClassName("timeline-Tweet-retweetCredit").length?!0:!1),(!x[A]||x[A]&&h)&&(s.push(T[A].getElementsByClassName("timeline-Tweet-text")[0]),E.push(T[A].getAttribute("data-tweet-id")),m&&C.push(g(T[A].getElementsByClassName("timeline-Tweet-author")[0])),_.push(T[A].getElementsByClassName("dt-updated")[0]),I.push(T[A].getElementsByClassName("timeline-Tweet-timestamp")[0]),N.push(void 0!==T[A].getElementsByClassName("timeline-Tweet-media")[0]?T[A].getElementsByClassName("timeline-Tweet-media")[0]:void 0)),A++;else for(T=n(T,"timeline-Tweet");A<T.length;)x.push(0<n(T[A],"timeline-Tweet-retweetCredit").length?!0:!1),(!x[A]||x[A]&&h)&&(s.push(n(T[A],"timeline-Tweet-text")[0]),E.push(T[A].getAttribute("data-tweet-id")),m&&C.push(g(n(T[A],"timeline-Tweet-author")[0])),_.push(n(T[A],"dt-updated")[0]),I.push(n(T[A],"timeline-Tweet-timestamp")[0]),N.push(void 0!==n(T[A],"timeline-Tweet-media")[0]?n(T[A],"timeline-Tweet-media")[0]:void 0)),A++;s.length>l&&(s.splice(l,s.length-l),C.splice(l,C.length-l),_.splice(l,_.length-l),x.splice(l,x.length-l),N.splice(l,N.length-l),I.splice(l,I.length-l));var T=[],A=s.length,B=0;if(y)for(;A>B;)T.push({tweet:s[B].innerHTML,author:C[B]?C[B].innerHTML:"Unknown Author",time:_[B].textContent,timestamp:_[B].getAttribute("datetime").replace("+0000","Z").replace(/([\+\-])(\d\d)(\d\d)/,"$1$2:$3"),image:a(N[B]),rt:x[B],tid:E[B],permalinkURL:void 0===I[B]?"":I[B].href}),B++;else for(;A>B;){if("string"!=typeof p){var x=_[B].getAttribute("datetime"),L=new Date(_[B].getAttribute("datetime").replace(/-/g,"/").replace("T"," ").split("+")[0]),x=p(L,x);if(_[B].setAttribute("aria-label",x),s[B].textContent)if(u)_[B].textContent=x;else{var L=document.createElement("p"),M=document.createTextNode(x);L.appendChild(M),L.setAttribute("aria-label",x),_[B]=L}else _[B].textContent=x}x="",r?(v&&(i(s[B]),m&&i(C[B])),m&&(x+='<div class="user">'+t(C[B].innerHTML)+"</div>"),x+='<p class="tweet">'+t(s[B].innerHTML)+"</p>",d&&(x=b?x+('<p class="timePosted"><a href="'+I[B]+'">'+_[B].getAttribute("aria-label")+"</a></p>"):x+('<p class="timePosted">'+_[B].getAttribute("aria-label")+"</p>"))):(m&&(x+='<p class="user">'+C[B].textContent+"</p>"),x+='<p class="tweet">'+s[B].textContent+"</p>",d&&(x+='<p class="timePosted">'+_[B].textContent+"</p>")),w&&(x+='<p class="interact"><a href="https://twitter.com/intent/tweet?in_reply_to='+E[B]+'" class="twitter_reply_icon"'+(v?' target="_blank">':">")+'Reply</a><a href="https://twitter.com/intent/retweet?tweet_id='+E[B]+'" class="twitter_retweet_icon"'+(v?' target="_blank">':">")+'Retweet</a><a href="https://twitter.com/intent/favorite?tweet_id='+E[B]+'" class="twitter_fav_icon"'+(v?' target="_blank">':">")+"Favorite</a></p>"),f&&void 0!==N[B]&&void 0!==a(N[B])&&(x+='<div class="media"><img src="'+a(N[B])+'" alt="Image from tweet" /></div>'),f?T.push(x):!f&&s[B].textContent.length&&T.push(x),B++}e(T),c=!1,0<o.length&&(k.fetch(o[0]),o.splice(0,1))}};return window.twitterFetcher=k});