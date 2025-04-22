Return-Path: <linux-fpga+bounces-1171-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A03A97137
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Apr 2025 17:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EA23B05E7
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Apr 2025 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2598228FFDE;
	Tue, 22 Apr 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1+LYod9"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0828F92D;
	Tue, 22 Apr 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336279; cv=none; b=Mh2572ZZtzAk3tKIh0BZwl0/K8DuOlGrJRTAxcd1cU4zDRhXbuXAzVxYZqscYVGzNmvPe+ScJtCWekmaY5mQ7z8xzRcBPgIMlNDs0/UE2CuL8d02i9Jp2G2E90z8UXROit9lI+tBBXFhQ7JMP/mBNpj0HQCpsc+KrpQKNpahLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336279; c=relaxed/simple;
	bh=wkljQJpf2uBwa/vHkF2k+MDlr9Ewo2RpAiy8uTu39Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vC34lXgj3cXWTCdqr1yFzczdTWWnWnCrtqvByelJfVrA6v8W1/fPc77a+EJUAYpjlLDLFfHZrRyANpjvjMlwbpz57M5D7AV9JyxnviH9sP88p8w9hL/zbhKgiGQxMW4VDY84t11rJMgytN4HkDFoudHBDVx5jMRWd0NkQooC8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1+LYod9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-440685d6afcso50331145e9.0;
        Tue, 22 Apr 2025 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745336276; x=1745941076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t97VeSNUpG2hiAo6wIqYqqcOXTDfHHY6JtBldkkckaA=;
        b=Y1+LYod9fGBPv/QsNGBXWuAXbkd42lEMh3Lw8Gs5XOye102XlQiwLTpNyffhF33jGr
         jjGJByjUVerL9uHpvXuSqyXEbjOttGhHNK3uqe95iLPJXMVZHtQj+qh97vc2Hil9zqRG
         thR533IvVj0n9YxX8n/QZHZFLsH0KddbbEIQh3kQYrb53gJKOKb5PBCPxDJJHNTLHRmi
         L3vtMq/OnXswAhO5W8eGJqnEeT4hQIK+bfy4yZ8+IMMrtfkoADsas5/4ULMwNBCSzZOK
         KPmumgAA/KDeN4UOC9+VNb7ln28ihkZXp2J/ip6aE6O1eCW0uozUdaCLchTqc/pE2NU3
         jltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745336276; x=1745941076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t97VeSNUpG2hiAo6wIqYqqcOXTDfHHY6JtBldkkckaA=;
        b=TrUxNpFwaidKWEFzjf3PZa8jaxmeNmBOBGNf2c3yrUKqMZ8REtmDJY9NenM8RfkoAx
         mJcsa5gZjTfDoQe6tG4TasibvBUQVisEmjPfEgbwEiB6u/aqaHriOn0V3eACrvcAm5Nd
         L6KFHxS/Noi0huoK4uEylSrruDzrOEBb5QOpD2acFIv0QE/W/oKPCyLUXHuTVzpnNDYO
         LZ/uPfaVpRl1SGRYYYgjLjSH9BJKxpK/GcYd9Cwbt5gFM+1IsU5rIx16EtGaKbWCFWqB
         hhhSvwtJqLIdol6qgeWTstLOh9f7K8bKP0eYX91Ig2nmFvuGPuWV7jMedjKXzXacpqVp
         sWzw==
X-Forwarded-Encrypted: i=1; AJvYcCWC1aAkeLCsDokduoK0jzdyPsGuA9UiWMr3BT/W8PWpLhoubQk2TmWPoY7AGiix6jOdp7f0USXW5hs3deY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6z4emUtZV4d+QQ87pg9bnKuYA/w/joHhSZI5J5g/uOevn2dZ
	phTuwquT/vx0LHTB6ilY9LlYES0XJA5b+38SBzGfpUkcWDdJnglt
X-Gm-Gg: ASbGncsk8eoAEpLfPRCJNBGLftXgDg3UkwfrZNHGXfvJTfHGyzLd/ehb1cnD8VObKQK
	Q5IFidnIlT72xN1ASHBb0viJa9YErNKEGeyy1SxMV2O2VljXt/8GH+LTMBJ+tKfftsxU4NCrfHz
	CRsOmr9h7uUyNtz0RBYDYqaP23yL6jkr0XwTZ6EU8auWiGgAotRree6Zgg/s0KA3aCL8KqILMP2
	vmrGemDT26kifDnpaLOAVMp37IrNh0+4gLtqVEYmKKqnaDpBLHnUupQGenQBfvAxPbz9UpKuNGw
	Aj1aKcYjOkQJSkGzZDuHt8OEpGX+NblznZVRSzH53w==
X-Google-Smtp-Source: AGHT+IGLPpRDDlkDW7Yin3pzT8Q0kiZj2p4DTstyz2bK/H34CFnMgNZd4wZTj9aaX9SHeRN+skhNaQ==
X-Received: by 2002:a05:600c:4e4a:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-4406aba7c2fmr148303565e9.15.1745336275381;
        Tue, 22 Apr 2025 08:37:55 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:314a:dc00:e03f:5030])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbd7fsm177321085e9.21.2025.04.22.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:37:55 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	akpm@linux-foundation.org,
	marpagan@redhat.com,
	arnd@arndb.de
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Pagani <marco.pagani@linux.dev>
Subject: [PATCH v2 RESEND] fpga: fix potential null pointer deref in fpga_mgr_test_img_load_sgt()
Date: Tue, 22 Apr 2025 16:37:37 +0100
Message-Id: <20250422153737.5264-1-qasdev00@gmail.com>
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


