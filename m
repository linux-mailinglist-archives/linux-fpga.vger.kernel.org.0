Return-Path: <linux-fpga+bounces-1289-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BD9B19D8E
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Aug 2025 10:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080B57AB3DC
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Aug 2025 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE721F8AC8;
	Mon,  4 Aug 2025 08:26:07 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52A241691;
	Mon,  4 Aug 2025 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295967; cv=none; b=rGyiqVRHnLVJ5F+dr43uFN7Q8QVCTqO4epX80QKWO4LERcWePhX1hF2qXHhaxg9+6G2zhpQEJ4FmIt9pFyr+L/wsDeGt5yNpSfeI9d/LQ/D4PPQg2pUPqP19guHUL6FrOHbzGsVKMTs5anOOGTnP3gwZCE34aI5I6DibPhQ7iU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295967; c=relaxed/simple;
	bh=Cddy+DcniI43JyvpraSQpuTZQPqon8yTQuXKkcGKrnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kLlEHAtpMi868HqNgSscxMwrKugDHxHVOLXAvenB0+iCmM5fW3GUUVFHBGGOy0jT5o4tW9x1ddIWHQ+e9N+wB0BC2odgrEvCFoB41e/Hcp6XNw3eCmO6nxPoNq6oyL26XHAm9x0U+mbeEf7IVbAj4S3swLMnwHPF08nLWfA8P98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b421b70f986so3186398a12.1;
        Mon, 04 Aug 2025 01:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295961; x=1754900761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqRpM1yXasR5AyGBrxM8/MoUt+5M85Gie/5rLIodPao=;
        b=lk9QNF2TnZiUFxz+3fU34DTs/TzyEH5bkGAXtvXq2adxQbY/q49nEtHBehn2igl3mU
         S7huOX3vTRUruKJ4MAFRrHVrDYlAgLNngb+XmpTWDEgE4qroRoG+GqZdH+/DBmfPMcN6
         bTD4PnsycrqkQ7mdbTbvmW5f1DgdbZ6Bjck/8lQ6LwuA64wZEGuj0whv+KJlcSEBTDry
         0d4oYdJ96P0GGsKVJ05v+txYs9rbMj0GGt6mH7ZFhRHm3bXRMer2XJYvO/O5Tv3QSKJS
         RG9dWBLp6axnQdrBf+FkHgjOxhCguVq+FKBYYGZJLN1dvBIC+3DQdlWe4Ck49A8jdk+Q
         hX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBL/GFCmt94tn7TyLe1iEluA0QcbJD1TxduS+yqXYncdTqSmAESVekInQfLnLfr8f+QHjH7bsmzU2+@vger.kernel.org, AJvYcCUTkAzHaKplN8XYiHM4VmWTSBQpLMn4W613cHQe21m6UXRsZnIKP5rRaTksVU+f2017S5zX0B6jP/N/V1L+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AQG2WMtXPfP65b6iwwCdgunLUGTX+AGElEg6bj2ZgEgSi3rx
	0O/2aYZxho13/xH7jIf6sJUV8tW+w+ohbt13gQx6t0KR4XYDF3bUuPhP
X-Gm-Gg: ASbGncuAkIgaChij7Npuncfq4TBtLAQgbZtba1uPxOM7JqbfwEB+I8KN92pvpz+8Ume
	ZcPee/p3X1FrlhsswGIybIumW781jaZE4X3qm4ujQ0bKodQPsbnnHknoA8qdeaQ3HlqpygSkmFN
	g7fZ1m8U0thq0acvq5QfBEjWkC25jDRYm6syIUtUJAyJA4+8rNRPvT1ImNhoORdrOUTnYpR8pxF
	ZqeQg1PauUV17JR+os3SlvdIjfTdjq060TcJzQqY7KU5jH7LKxcfyFiTgytppShTSip1j7d4VGc
	zv4HUvIHRrlIkHQUd5dWk4a6IO7I5jqpswMru+ntu6Vh6DQKQb964btWVA4y1msBn53WE3k/D+v
	ripe5M4QEynkdp8ZhgXgIugsqCT1nAj6AbLMxY7VztBrs88k4lIgtdzw=
X-Google-Smtp-Source: AGHT+IHKSfXg4uq3HKmm3TV1pgiHglunlc1GY7Nn+5YFfqJShlJlJ9lVByjliOQ0DOrLfGGoWUajhA==
X-Received: by 2002:a17:90b:1c92:b0:321:265a:e0b6 with SMTP id 98e67ed59e1d1-321265ae50emr7029975a91.20.1754295961195;
        Mon, 04 Aug 2025 01:26:01 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207edb5884sm10968539a91.28.2025.08.04.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 01:26:00 -0700 (PDT)
From: xiehongyu1@kylinos.cn
To: yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	mdf@kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v1] fpga: afu: fix potential intege overflow
Date: Mon,  4 Aug 2025 16:25:23 +0800
Message-Id: <20250804082523.419159-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Xie <xiehongyu1@kylinos.cn>

Overflow Scenarios:
1, region->offset + region->size Overflow:
  When region->offset is close to U64_MAX and region->size is
sufficiently large, the addition result may wrap around to a
very small value (e.g., 0 or near 0).
  In this case, even if the target range [offset, offset+size)
falls within the region, the condition region->offset +
region->size >= offset + size will fail due to the wrapped
value being small. This causes the function to erroneously
return -EINVAL.

2, offset + size Overflow:
  When offset is close to U64_MAX and size is large, offset +
size wraps around to a small value.

  Here, region->offset + region->size (which would be a large
value if not overflowing) might incorrectly satisfy
region->offset + region->size >= offset + size due to the
wrapped small value. This leads to a false match, even though
the actual range [offset, offset+size) spans the wrap-around
boundary and does not belong to this region.

So fix these two scenarios.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/fpga/dfl-afu-region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
index b11a5b21e666..449c2ae809bd 100644
--- a/drivers/fpga/dfl-afu-region.c
+++ b/drivers/fpga/dfl-afu-region.c
@@ -157,7 +157,8 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
 	afu = dfl_fpga_fdata_get_private(fdata);
 	for_each_region(region, afu)
 		if (region->offset <= offset &&
-		    region->offset + region->size >= offset + size) {
+		    region->size >= size &&
+		    (offset - region->offset) <= (region->size - size)) {
 			*pregion = *region;
 			goto exit;
 		}
-- 
2.25.1


