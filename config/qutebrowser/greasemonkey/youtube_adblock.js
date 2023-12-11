From: <Saved by Blink>
Snapshot-Content-Location: https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/master/youtube_adblock.js
Subject: 
Date: Wed, 29 Mar 2023 18:33:42 -0000
MIME-Version: 1.0
Content-Type: multipart/related;
	type="text/html";
	boundary="----MultipartBoundary--94SwPrJU6DoTQT05gskQuTNkfb1lW3dckO8jsWYNL8----"


------MultipartBoundary--94SwPrJU6DoTQT05gskQuTNkfb1lW3dckO8jsWYNL8----
Content-Type: text/html
Content-ID: <frame-534A8567588F085EAB0FABBCFEFA6B51@mhtml.blink>
Content-Transfer-Encoding: quoted-printable
Content-Location: https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/master/youtube_adblock.js

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8"><link rel=3D"stylesheet" type=3D"text/css" href=3D"cid:css-882dde=
1e-ca70-4289-aa3e-ebda662e75ff@mhtml.blink" /></head><body><pre style=3D"wo=
rd-wrap: break-word; white-space: pre-wrap;">// =3D=3DUserScript=3D=3D
// @name         Skip youtube ads
// @version      1.0.0
// @description  Skips YouTube ads automatically
// @author       afreakk
// @match        *://*.youtube.com/*
// @exclude      *://*.youtube.com/subscribe_embed?*
// =3D=3D/UserScript=3D=3D
const skipAd =3D () =3D&gt; {
    document
        .querySelectorAll('.videoAdUiSkipButton,.ytp-ad-skip-button')
        .forEach((b) =3D&gt; b.click());
    if (document.querySelector('.ad-showing')) {
        document.querySelectorAll('video').forEach((v) =3D&gt; {
            Number.isNaN(v.duration) || (v.currentTime =3D v.duration);
        });
    }
    document
        .querySelectorAll('.ytd-display-ad-renderer#dismissible')
        .forEach((el) =3D&gt;
            // remove the ad video in top left of recommended
            el?.parentElement?.parentElement?.parentElement?.remove?.()
        );
    document
        .querySelectorAll(
            'ytd-promoted-sparkles-web-renderer, #player-ads, #masthead-ad,=
 ytd-compact-promoted-video-renderer'
        )
        .forEach((el) =3D&gt; el.remove());
    document
        .querySelectorAll('.ytd-mealbar-promo-renderer#dismiss-button')
        .forEach((el) =3D&gt; el.click());
};
if (!window.skipAdIntervalID) {
    window.skipAdIntervalID =3D setInterval(skipAd, 333);
}
</pre></body></html>
------MultipartBoundary--94SwPrJU6DoTQT05gskQuTNkfb1lW3dckO8jsWYNL8----
Content-Type: text/css
Content-Transfer-Encoding: quoted-printable
Content-Location: cid:css-882dde1e-ca70-4289-aa3e-ebda662e75ff@mhtml.blink

@charset "utf-8";
=0A
------MultipartBoundary--94SwPrJU6DoTQT05gskQuTNkfb1lW3dckO8jsWYNL8------
