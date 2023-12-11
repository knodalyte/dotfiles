From: <Saved by Blink>
Snapshot-Content-Location: https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/master/youtube_sponsorblock.js
Subject: 
Date: Wed, 29 Mar 2023 18:34:08 -0000
MIME-Version: 1.0
Content-Type: multipart/related;
	type="text/html";
	boundary="----MultipartBoundary--n93JMqs9DLBnTGLfuXlxWoyEdd28cBf77bdEhjddPR----"


------MultipartBoundary--n93JMqs9DLBnTGLfuXlxWoyEdd28cBf77bdEhjddPR----
Content-Type: text/html
Content-ID: <frame-534A8567588F085EAB0FABBCFEFA6B51@mhtml.blink>
Content-Transfer-Encoding: quoted-printable
Content-Location: https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/master/youtube_sponsorblock.js

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8"><link rel=3D"stylesheet" type=3D"text/css" href=3D"cid:css-781d19=
40-76b4-44a6-ac78-61e29fb774ea@mhtml.blink" /></head><body><pre style=3D"wo=
rd-wrap: break-word; white-space: pre-wrap;">// =3D=3DUserScript=3D=3D
// @name         Sponsorblock
// @version      1.0.0
// @description  Skip sponsor segments automatically
// @author       afreakk
// @match        *://*.youtube.com/*
// @exclude      *://*.youtube.com/subscribe_embed?*
// =3D=3D/UserScript=3D=3D
const tryFetchSkipSegments =3D (videoID) =3D&gt;
    fetch(`https://sponsor.ajay.app/api/skipSegments?videoID=3D${videoID}`)
        .then((r) =3D&gt; r.json())
        .then((rJson) =3D&gt;
            rJson.filter((a) =3D&gt; a.actionType =3D=3D=3D 'skip').map((a)=
 =3D&gt; a.segment)
        )
        .catch(
            (e) =3D&gt;
                console.log(
                    `Sponsorblock: failed fetching skipSegments for ${video=
ID}, reason: ${e}`
                ) || []
        );

const skipSegments =3D async () =3D&gt; {
    const videoID =3D new URL(document.location).searchParams.get('v');
    if (!videoID) {
        return;
    }
    const key =3D `segmentsToSkip-${videoID}`;
    window[key] =3D window[key] || (await tryFetchSkipSegments(videoID));
    for (const v of document.querySelectorAll('video')) {
        if (Number.isNaN(v.duration)) continue;
        for (const [start, end] of window[key]) {
            if (v.currentTime &lt; end &amp;&amp; v.currentTime &gt; start)=
 {
                v.currentTime =3D end;
                return console.log(`Sponsorblock: skipped video to ${end}`)=
;
            }
        }
    }
};
if (!window.skipSegmentsIntervalID) {
    window.skipSegmentsIntervalID =3D setInterval(skipSegments, 1000);
}
</pre></body></html>
------MultipartBoundary--n93JMqs9DLBnTGLfuXlxWoyEdd28cBf77bdEhjddPR----
Content-Type: text/css
Content-Transfer-Encoding: quoted-printable
Content-Location: cid:css-781d1940-76b4-44a6-ac78-61e29fb774ea@mhtml.blink

@charset "utf-8";
=0A
------MultipartBoundary--n93JMqs9DLBnTGLfuXlxWoyEdd28cBf77bdEhjddPR------
