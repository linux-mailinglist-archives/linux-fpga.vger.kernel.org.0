Return-Path: <linux-fpga+bounces-1143-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BEA813CB
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Apr 2025 19:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011861BA8312
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Apr 2025 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED05C23315D;
	Tue,  8 Apr 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5o7FGH8"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337462356CC;
	Tue,  8 Apr 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133758; cv=none; b=lYJtKns1N4/Lc3i2hNMtm7mY2tdVZOsfCC1vgYWoJWzjHCSgvZiRQkUCaU1WgQc5gA5jiajj96YaYxppLuye8/48W3clb3G6N5Djs7mReKK08fuyYpx74L6BYaDsBhOkJ4ulgVRpX58WHkdyUz/0Fg7N4hZ4jmeE3yADgdlxfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133758; c=relaxed/simple;
	bh=wkljQJpf2uBwa/vHkF2k+MDlr9Ewo2RpAiy8uTu39Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOu5bzGkOhbGjxwMbfyfPBwYboTacTYStiRug0RQsSg+t4owX/tXIzipjBJvZoT71TR0EmFjJTea2/crgaZw74mxJDj8dk+mpKHBI7e6xqzRjk0b3YZZXImwJmEikdWr6iLCda+6J1noatmmgcCbO9oPvcFiGrhO4UFsyZITSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5o7FGH8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39d83782ef6so669279f8f.0;
        Tue, 08 Apr 2025 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744133754; x=1744738554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t97VeSNUpG2hiAo6wIqYqqcOXTDfHHY6JtBldkkckaA=;
        b=B5o7FGH8TpvKDVwzqcX3Ijqo22vA/I3PEekid8yx56n1ALblBHdUXNrqzFHrg7ifhM
         UC0ev3dXhytJ6aOZfb5VdAlXCx74AqzcNhDJ0SV/n7NaNZ7pqXfSZRDq9hswxC1DH8MT
         vFL16WfMHilFRr6rIgkBAEh09tYUKPwtmaJy3hSNKjzyNsMet33IRXTkJZLSAW/NksAy
         EpJjEfGhspJZMkgYRgKLk5bOHugprjkCGHKBvU/2/4Xz+9j59Aeg5cAfLML9h/ypo4DQ
         37O2Q77kFRCI5J+hTxjRiC1DKKfTaRwd/PJNnJI4bIajXDnl56Z1IibdJTdvAR5eTMlP
         Czqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744133754; x=1744738554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t97VeSNUpG2hiAo6wIqYqqcOXTDfHHY6JtBldkkckaA=;
        b=WhNs1bRJ+wlBxQtH5Xmqx/dnZvOJx40MMHdGftXlMM7GWf/+ioH1Tf9q2xDSuSbZq1
         6bj0/ebpCcHGQnS8VIJfq24pYMyAUzpKN9FW3gUMsOfEy1gYr5MpH8D2V08dE56EiRFb
         +tx3jLOt8hEEuNypvcpner5k4aBY8uICr1icAfTPrkyWl2yMHwm4Jwm43OykbJlI8+jC
         RfjrDbNc5a4pCL5nv+DoFh7VgetTyVlIJK/ZwMaMUBHWI+x9/MKMx84P0iYjEhhoLDBN
         t11SLA+hl1w6WGDs3ov6upV4U4JILpCmpiT3LkRrtbwxl3N4Bs27Jzt3h9qUxLncP3Ho
         /7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ht3R4g6BquHGZTx3uELbj3SQf+5WSa5H7A7hD97Nh9+Jeus7swW4U2Bfyy4hLNsNmexStNTtmrLLUXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMOCgy1qsn6qdgHdDqGdoW2AK91W2m6K6AJ0HGeqsVjKxsz4Q
	i9V9Rd4gz5eSzTkptIcJ7Qc4PUjkSfyrumPTtBjXbHqdEHREe4r7
X-Gm-Gg: ASbGncvYmN+alFDfGTyXGwswhXzDnqPCYFq2QZvsPcUon/5JhntFHlwyUES4/xPygvk
	U1WRyX1bqt0aeK91GVMmok+nCLWLKxPcNR1ZQvsOlYkBoJh0F/OSVKGMtR8FmosBU2YiwFpa3v0
	i1+imIiy+6tqyabEzaUMNbIgCMf312Il/G5jcwiBh8MSQ9mb6PTT/tYKaateplsZzpFXsYrOonc
	2AgW43cYfdKdFboByXjPB/zzwroNn/HUgYVIoaRuSKNbJCszncv4aXpUy/BSJTuzVCPNfeUForF
	5eGmNg+SMIKGI8RaBzxXah2r/OTL+58waVGkUv1O+tkzug==
X-Google-Smtp-Source: AGHT+IGDTv/Zp+2G3k9M+AZhIjTvEirNOA85vMCH2RMX8uGtQ1PYGGzcprxaCWQ2QuDtXl92C/Gu1Q==
X-Received: by 2002:a05:6000:2401:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-39d820f7f43mr4249159f8f.19.1744133754407;
        Tue, 08 Apr 2025 10:35:54 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:5b45:5642:beb0:688f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3174cf0sm174352995e9.0.2025.04.08.10.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:35:53 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	marpagan@redhat.com,
	russ.weight@linux.dev
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Pagani <marco.pagani@linux.dev>
Subject: [PATCH v2 RESEND] fpga: fix potential null pointer deref in fpga_mgr_test_img_load_sgt()
Date: Tue,  8 Apr 2025 18:35:41 +0100
Message-Id: <20250408173541.12714-1-qasdev00@gmail.com>
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
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
v2:
- Remove stable CC tag since its just a kunit test

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


