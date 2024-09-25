Return-Path: <linux-fpga+bounces-736-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4753B985773
	for <lists+linux-fpga@lfdr.de>; Wed, 25 Sep 2024 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0718F285B4A
	for <lists+linux-fpga@lfdr.de>; Wed, 25 Sep 2024 10:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60C165F1A;
	Wed, 25 Sep 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GZGXRaEK"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3115B559
	for <linux-fpga@vger.kernel.org>; Wed, 25 Sep 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261861; cv=none; b=M9iAJmyo/22ITd4fEzN0pnd01N2abIx4HTuoyQlny5SO+7p0LvDqCJCirNBMAby3CZ/XzSVrDWajmrZ/zf0GxUf1fIUmg69TdbjhNyjum8hVsndT4wgxlWpGs6rQyb/HTMt9rCV5+500U775R7XQ0nLEM3CP7Frev6y7lA7Fgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261861; c=relaxed/simple;
	bh=NFZrRhE2Cg5/vS2f6vcyZD3u5B5L4qbPJxaBPliSDxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=LE/fwK422it9SOSQzsNjT0qc+A04SPUGY1K0VfFxAjostJmPpV5PYMcpjmibCbng3XMedMZS7Ka9WDHDctz2j9qU3GDY7JKDPXcZzSZdV+tgFjuYKh9Jj2I2jm/6YXPclsJdrDuVkdKIUN/vn/UkuiX+Eh9da2DESSQnVnrKUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GZGXRaEK; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240925105731epoutp026af42539e0d05493f8c45ff161504190~4d4CPR4pZ3051130511epoutp02b
	for <linux-fpga@vger.kernel.org>; Wed, 25 Sep 2024 10:57:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240925105731epoutp026af42539e0d05493f8c45ff161504190~4d4CPR4pZ3051130511epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727261851;
	bh=72Teje+J0GMLBe7cCmif7G/jgQaPe8OMwdAf5mDxFi8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GZGXRaEK5laKP47p7isL1hQ2AfmhsaNttfcL7MgfZC/Spyacmz6uo34fhJBZu2Ueq
	 nz6WythAbZDZ0deCMcnr3r/RkNdjG67c+4S4H4ZZCB5ESYbIe7Yt0ASBLKUdKa9+GX
	 ndHQVZF0J2wUPBB0veuTLp7/pm56ErR+1mh4osSU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240925105730epcas1p2964c340504ac36fa00e621a52865fd6f~4d4B_HEo51979819798epcas1p2U;
	Wed, 25 Sep 2024 10:57:30 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.133]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XDDG22Nwrz4x9Pp; Wed, 25 Sep
	2024 10:57:30 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A3.50.08992.A9CE3F66; Wed, 25 Sep 2024 19:57:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240925105729epcas1p3b4f8a285198754e877cdf5c74b7609ea~4d4A7Exjy1639616396epcas1p3m;
	Wed, 25 Sep 2024 10:57:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240925105729epsmtrp20daecc8647c130ce5737b0b8bbd94b6c~4d4A6XoaN3103031030epsmtrp2L;
	Wed, 25 Sep 2024 10:57:29 +0000 (GMT)
X-AuditID: b6c32a33-70bff70000002320-fe-66f3ec9abb01
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.84.08456.99CE3F66; Wed, 25 Sep 2024 19:57:29 +0900 (KST)
Received: from jy7805-heo05.tn.corp.samsungelectronics.net (unknown
	[10.250.132.180]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240925105729epsmtip1a1f59d59656b635f7f61afcb436cb6b7~4d4Atlnrj0942609426epsmtip1D;
	Wed, 25 Sep 2024 10:57:29 +0000 (GMT)
From: Joonyoung Heo <jy7805.heo@samsung.com>
To: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com
Cc: trix@redhat.com, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, Heo Joonyoung <jy7805.heo@samsung.com>
Subject: [PATCH] fpga: print return value in machxo2_cleanup()
Date: Wed, 25 Sep 2024 19:57:25 +0900
Message-Id: <20240925105725.1562327-1-jy7805.heo@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmnu6sN5/TDFqf8Fg833aF2WLHk5NM
	Fo9mfme3uLxrDpvF/EZ3i2tfTrNYXL20i8WB3WPxnpdMHptWdbJ5vN93lc2jb8sqRo/Pm+QC
	WKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlBS
	KEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX5qXr5aWWWBkaGBiZAhUm
	ZGcs+f6NtaCftaL9zHSWBsbFLF2MnBwSAiYSv+ceYu5i5OIQEtjBKNE2bT8bhPOJUeL99n3s
	EM43RonFf/qYYFq6bt9mhEjsZZT4MuEqVEsXk8S9zm6wKjYBHYm+NZPZQWwRAQuJL+8+MIPY
	zALlEr3LmsHiwgJ2Ep1HQSZxcrAIqEqsmvQarJdXwFZiy78NzBDb5CVmXvrODhEXlDg58wkL
	xBx5ieats8EOlxA4xS4x6dJHqI9cJPofHmOFsIUlXh3fwg5hS0l8freXDcLOlvjbtwkqXiHR
	NOMqI4RtL7F8zj6gXg6gBZoS63fpQ+zik3j3tQcsLCHAK9HRJgRRrSLxeeE9Jpjpv188gZri
	IXF3xlGwa4QEYiV+ru1insAoNwvJB7OQfDALYdkCRuZVjGKpBcW56anJhgWG8JhMzs/dxAhO
	fVrGOxgvz/+nd4iRiYPxEKMEB7OSCO+kmx/ThHhTEiurUovy44tKc1KLDzGaAsN0IrOUaHI+
	MPnmlcQbmlgamJgZGZtYGJoZKonznrlSliokkJ5YkpqdmlqQWgTTx8TBKdXAxJNlftfk6atM
	Pmv//gxGbeOTJ6PeLQydWzIj5l/22TpFn3krbvvZFFsHLXoz/9vm0qNZmzsP2u5j2Jp+VNjl
	6KGTma8e1hqJJMrv3RG9aKKO+txs0fmHP1R/+vfdq0nO2ufn9k7N6sMaU745Lps+S6Jc+5xs
	SU+kwvyHb1Z/sBRfOHElj+Tz9TFH3s9zm6N5qWHzfQ1J15Tk3TesbrziN6hQu8if8y9xj9Rq
	t18/9qTXNvIHzeUUrIg5KMCuLbdl8/otK5Mb9GdMTG+/apMSp3Mp2clzlV+5+D4lZ6Vrb/ad
	P3qS6fKKTq/TNaoHC5f4LzGaNPtbUdZTrcksE973Hv3UMfOV/YNJcz5ELNpWaqPEUpyRaKjF
	XFScCABMFFiTBgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnO7MN5/TDDofqFk833aF2WLHk5NM
	Fo9mfme3uLxrDpvF/EZ3i2tfTrNYXL20i8WB3WPxnpdMHptWdbJ5vN93lc2jb8sqRo/Pm+QC
	WKO4bFJSczLLUov07RK4MpZ8/8Za0M9a0X5mOksD42KWLkZODgkBE4mu27cZuxi5OIQEdjNK
	rN59hw0iISWx+vELIJsDyBaWOHy4GKKmg0niQFMjM0gNm4CORN+ayewgNSICNhLTu2JAwswC
	1RL3dvUzgdjCAnYSnUdB5nNysAioSqya9BoszitgK7Hl3wZmiFXyEjMvfWeHiAtKnJz5hAVi
	jrxE89bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4QLW0
	djDuWfVB7xAjEwfjIUYJDmYlEd5JNz+mCfGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUgg
	PbEkNTs1tSC1CCbLxMEp1cDUOO/SpewPbZUbnlwUv7jnMNvB2e+mC5kvdTjaui0m1aotYerF
	IM1C9VPbz0qGbGP0rNR7MZtpm0n44vfXmbzv/U/ytLKv2RVwqbW5Przvb+gKDzfVxkNyWset
	BCZMY7a9wVXDd3ZV871W6aCJXLWpGVFfWhsMZUQMxMr9OLarM8XmpApH5wdU6TPdeyPpHSSy
	rbZdwSf+zqIDJe+OMnv4CovtmLjgpN17l6u+aTN3B9z8tpTfsCrKuj2tdH9bvU640LWLxmxW
	a3aovH1fLa25cmdYnEquRqPHLOOvjak573sYr34+vF1z4t182WOtvWnzNh/PeLZnlt3/Rpfi
	GPGu6W2/Fkqpvp71+oF+tBJLcUaioRZzUXEiAEfeBm2/AgAA
X-CMS-MailID: 20240925105729epcas1p3b4f8a285198754e877cdf5c74b7609ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240925105729epcas1p3b4f8a285198754e877cdf5c74b7609ea
References: <CGME20240925105729epcas1p3b4f8a285198754e877cdf5c74b7609ea@epcas1p3.samsung.com>

From: Heo Joonyoung <jy7805.heo@samsung.com>

print return value to check where it failed.

Signed-off-by: Heo Joonyoung <jy7805.heo@samsung.com>
---
 drivers/fpga/machxo2-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 905607992a12..c9eaf313e9b8 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -166,7 +166,7 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
 
 	return 0;
 fail:
-	dev_err(&mgr->dev, "Cleanup failed\n");
+	dev_err(&mgr->dev, "Cleanup failed, ret=%d\n", ret);
 
 	return ret;
 }
-- 
2.25.1


