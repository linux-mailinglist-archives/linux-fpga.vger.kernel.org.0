Return-Path: <linux-fpga+bounces-1124-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73DDA6D860
	for <lists+linux-fpga@lfdr.de>; Mon, 24 Mar 2025 11:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B991698C6
	for <lists+linux-fpga@lfdr.de>; Mon, 24 Mar 2025 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9907725DB14;
	Mon, 24 Mar 2025 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9oo3QVi"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF151953A9;
	Mon, 24 Mar 2025 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812579; cv=none; b=F42GPR7RuUSEd5kTeCmnTGp0mhrPqRPLXqocRc2sGm4JkxPKM1xsJxHzAKEuoCMvV1+JsYNAD1kVt8iKOfmbMq5UvK5wpSe/VLZCDWM3SFX9qe5z5Bg32ZOYtrrQo+zAp/5gDCLyK6dhbacB1J816xSIfp+pAYfC1+d2OvJrbec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812579; c=relaxed/simple;
	bh=g36vJ2OyxStHe8QDcLMn5mm8sOgJSZtKgCusIVzPoZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T4ObK90MFTN+1qBJv1To7n6yrdVQils0/2ZqzRxRw2PTxhybyFgIBBMtpdSL+loc/4jw9SnW1A5GIx9/BOiy1CdqrRFQT3fHkgvZCVRl7bd3WjRiMz696C8oGn+npYVNB/ucMKXM53PwXd7JEUe9hfclRjSIhK9nt/4lqX8QF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9oo3QVi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso41939765e9.0;
        Mon, 24 Mar 2025 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742812576; x=1743417376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5B/CeWfDacun7Zfi2gtOkvWcKPOtTpzUBlClnAfjEs=;
        b=F9oo3QVihvndQWOrirZ2Qttb6g7oHm7NvMZ+4F4A7inJ3xxMKrG+jayLBFqPr0DncE
         fUAxFJFx6lmaPs3ogpPdUbetaMBjI2P8+ztUj+Qx+E9ZreRtW2vpgrZJgiAHOJo6QSbo
         j/bkvtiPEiFE7Ya+PhzBmTVIDORWK1iwkwe8LwoaitW7c5Rm2/gI9Oq6rkCo/Z4emMTm
         uDFska4hzo3BX78pL9GVv+RNw9jjU1fV6j1KerrRkPj2D9tv0KhR+XuPh10vGLZm3XD9
         O3Mm5cSQtvtDbO1brZCtEy2PYY47AthzmPAFOhES3B10vuRrjolNff/kIKkdSlThAjau
         b4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742812576; x=1743417376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5B/CeWfDacun7Zfi2gtOkvWcKPOtTpzUBlClnAfjEs=;
        b=sVY0FyRhs9WqfJ7KxgeoFglerciXp1PtR8Dxs9UmYm7PcXB5G0fYHQf+tpmF+xt4KE
         c3jcE/bE5chBWzk5yiqIZ2ryrs3+gsXsCdPI9vUznraINWlSDLEKDUrrTM+oQZm4Bgq4
         P+And1HxittIT+JWza9IZcuiEkRrKFfkZWH1nzrKjRo/nyTx3umttnBmc7GrVvfQ2oaP
         36EKJ1lxpafDEQzqqmBTgW8+NbRZH+ZCv/rUG1gUL2Bzf16egvJOaUFYolZ7/6BtdJob
         SVxnM0BNzZ9edxit2sj8rKb2CojoX8L7zn9ZK77Wx76v0JQ+8IJ77CARQTdwTPHfntLY
         n1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHDmPMGjFtSWDaia8rypaNBUBEeUn7rRjBGrMla5Gz911F8SdZqoOP7Bx40PMtRIXi9cyTwExU@vger.kernel.org, AJvYcCUTvKqmy4buf0TaDCzdLFNrxaM2xby3OJPN/CXfjIL7VoTT3iv0jEOikPTN5CWmjRMcf8Ss1X+8wMaqtaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpeRb4ZucPiIbl1/0Iu2tCu9Ax9AfbbRSkSKhpQGrV8f+grjZ
	aKM1upnwucP/wegKKcisN3BRZirJyubq9CHQ1U1v2Y/oAJMKub65
X-Gm-Gg: ASbGncuPp5bKYzPkYUalimQVYCSUjL6DofzLB0ZCDi6Xop66+k1fR8KdrPmWw50UitU
	NyuS1Dlfe/a8VpMx0F1xr2rtTJuV6XJ8IYCFK/AbCKmYIyjwLypUp/moKH3rXq2VJsjwSCISHgQ
	fdDUas8F+/IC8GXMs3qE5+MFlnSTUSu2ypU6kMQD2FWRyN4SUMHK4KE8VrTkTDNhAnPCx3v48Ea
	lnEv6Ew2RBZjGpZA4vaf9sZVTk+2ja5zMr7H/GMj3AgNnw6MD/oVnl6H+OztPQjh8XtdDvaYWSd
	6WvML9oZHhedcNtONDbCiH/lFX8BRmD1AdRFONsDIcCrbw==
X-Google-Smtp-Source: AGHT+IFShNovJTwwGEmC89w1rjnLGPeYGnDCT0HO5gsvqMah4azhcYyuI3lba+zIt/Six4HniXcLoQ==
X-Received: by 2002:a5d:6d0d:0:b0:391:41c9:7a87 with SMTP id ffacd0b85a97d-3997f940870mr11497856f8f.51.1742812575912;
        Mon, 24 Mar 2025 03:36:15 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:6c2b:a0d1:ba6d:a00f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9eff9asm10760895f8f.92.2025.03.24.03.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:36:15 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	marpagan@redhat.com,
	russ.weight@linux.dev
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Pagani <marco.pagani@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] fpga: fix potential null pointer deref in fpga_mgr_test_img_load_sgt()
Date: Mon, 24 Mar 2025 10:35:51 +0000
Message-Id: <20250324103551.6350-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fpga_mgr_test_img_load_sgt() allocates memory for sgt using
kunit_kzalloc() however it does not check if the allocation failed. 
It then passes sgt to sg_alloc_table(), which passes it to
__sg_alloc_table(). This function calls memset() on sgt in an attempt to
zero it out. If the allocation fails then sgt will be NULL and the
memset will trigger a NULL pointer dereference.

Fix this by checking the allocation with KUNIT_ASSERT_NOT_ERR_OR_NULL().

Reviewed-by: Marco Pagani <marco.pagani@linux.dev>
Fixes: ccbc1c302115 ("fpga: add an initial KUnit suite for the FPGA Manager")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/fpga/tests/fpga-mgr-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
index 9cb37aefbac4..1902ebf5a298 100644
--- a/drivers/fpga/tests/fpga-mgr-test.c
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -263,6 +263,7 @@ static void fpga_mgr_test_img_load_sgt(struct kunit *test)
 	img_buf = init_test_buffer(test, IMAGE_SIZE);
 
 	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);
-- 
2.39.5


