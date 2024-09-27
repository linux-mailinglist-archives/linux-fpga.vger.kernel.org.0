Return-Path: <linux-fpga+bounces-739-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0B69886C4
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 16:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC89B1C22D71
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B41487C8;
	Fri, 27 Sep 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBKdjqnf"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C013CFBC;
	Fri, 27 Sep 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446500; cv=none; b=Drnj9ZIf5pKW1MLYK6YMkfriTC8KkwN2yua4ow5mPQEspQksPkRLFNlCEdEsE3s8+Ds+jxrC3ZZ3xXSpVAJexhFGpE31h6q2zOdYb+4bHaavPnuJAMXHgcEzg35VwyhmIGzpBILm6uyiVz7QYZXJuRgZcH57HyW8kqGzvk6SlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446500; c=relaxed/simple;
	bh=bQsKNhKpyy3xpYNMPofWZ74q+9a6v7WVDosFvn3fS0k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aB7KB747/ZlnRry5mYWtA51bz7Mfq8lN9J5cMCZzND+x5FwljbS4CEWl71h5zcjmVVvERIWa7lF3bPtKh38OOOfjfHUjf5Fpu5kDFhpEigrP4KUJIXl2XDPUynyDjHBWKlWyO2PVns0iDHU+9rozuunVeyd6qknExzGgKIKiPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBKdjqnf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c881aa669fso1478888a12.0;
        Fri, 27 Sep 2024 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727446497; x=1728051297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFn/mhfbQIWTTJwtmXdMRSt0BoD/XbstVD6yvugNe6U=;
        b=WBKdjqnf++UNI76OvOvQb48DYZ+zapwr87X59a7RWIR4SHS9qGUwMurubSEjyF4bpH
         QeGcYPiDR9KRmTCRRFdFKsejL9YjJhuLbQdnIzvIzhPWotzSgh0xjnyhvIemaoJTDvnu
         RZDVMK2pL4brjgRns0olcclH9ShWCdpj4RQBrvKe8ZcfOFTJAmEOwN/2+nZQbVO2YgN3
         7keLfhgOaGsep7ON7iEIxh9i0qSpU6eVjEJICBPSzUdFD80VB1ooluPCVc71vU3sCUDA
         w+QPiZBz50p20JmKVBI5Hp9A7ezSenzj3MMf19ZNNP7ZYGRZ/BDn+ZAn82cvCUcANtRK
         7/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446497; x=1728051297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFn/mhfbQIWTTJwtmXdMRSt0BoD/XbstVD6yvugNe6U=;
        b=JOqLmPoOv0PIEj/q+MNfbajRlS8F5iuuSTYrKkUZ3w0o0MJ1IjxRxPOjgg5DYlvAC+
         4arAYjmUTZlvKmDyKxjraxTPLh8e6GbGXeo1FKjtWhN04UPAt4wTv64UMVZKHvHuIo4N
         fI+RcHS78U5q8FFlghBcz0Sg/2Fsly0Ot0M0hW62booBzBrkb54iNhb7Bqj8NWP++UHs
         buDpTJ2iQvttcnMWgcdDbTqwMPOud9hzWi7VOYSJP1jA6Q+btR4ta6sEBop5TS4CbXVV
         MwFNO7w14gePFcSauNA0CaO+g5j/eVEQVv7HdJ00ryMn+mFnSPhnSpPar9gwfnrj24Qb
         02VA==
X-Forwarded-Encrypted: i=1; AJvYcCUMrjFAhEUQrfN2LUj05QgUoZrW8+/fgPhL+wvtvN3cEzpcgwVWDnQTyHTuGGyvKo6HUMalAAvpIOpC@vger.kernel.org, AJvYcCWHWOS1dPUYYymnBWhGmFBGi55dIoaR+W+efvnh11oN1ioHWmNdmRJEjtrc3nNusysTlRUv8y5DpUDV2g==@vger.kernel.org, AJvYcCWKIbhXvRK+EICAk3ZAf2qUKSJS5U3OwllzTPmVqmiZvodvx9Otg8dt8/h0ZyCQ/cKGu5nEEFV67FHZewDK@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTY2ArZwmIGviEMKTQ9FtBXXV4xioZyH8aV3WGTS88hv7K2Po
	Cy13X9Uga4cCsIeInobRaxcu6w0L7VpjYxB1Ehy5xjGnqvdnaOgJ
X-Google-Smtp-Source: AGHT+IHtztav/9O7O27fmQV4K2u2kScLMUvJ9FEjY9CIXam0GMXu695pl2EnOqlgCfiKzS/wj9u2Kw==
X-Received: by 2002:a05:6402:42c7:b0:5c5:c454:a27b with SMTP id 4fb4d7f45d1cf-5c8824d4278mr2708229a12.12.1727446496677;
        Fri, 27 Sep 2024 07:14:56 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f4f030052bd6081d2396adf.dip0.t-ipconnect.de. [2003:eb:5f4f:300:52bd:6081:d239:6adf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248af00sm1184519a12.67.2024.09.27.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:14:56 -0700 (PDT)
From: iansdannapel@gmail.com
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de,
	rafal@milecki.pl,
	linus.walleij@linaro.org,
	iansdannapel@gmail.com,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
Date: Fri, 27 Sep 2024 16:14:44 +0200
Message-Id: <20240927141445.157234-3-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927141445.157234-1-iansdannapel@gmail.com>
References: <20240927141445.157234-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add entry for Efinix, Inc. (https://www.efinixinc.com/)

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b320a39de7fe..cb92df951fa7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -430,6 +430,8 @@ patternProperties:
     description: Emtop Embedded Solutions
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
+  "^efinix,.*":
+    description: Efinix, Inc.
   "^einfochips,.*":
     description: Einfochips
   "^eink,.*":
-- 
2.34.1


