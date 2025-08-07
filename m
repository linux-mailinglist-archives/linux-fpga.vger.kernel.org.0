Return-Path: <linux-fpga+bounces-1300-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C53B1D371
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Aug 2025 09:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDED563AED
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Aug 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F394224892;
	Thu,  7 Aug 2025 07:36:46 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A02AD32;
	Thu,  7 Aug 2025 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552206; cv=none; b=LZk7sbdMWglkcQohSJp/d7lHPp3ODnGQBQ2lWtIjseRhmBi7tFIPZjFn/FL91dyQu0GtG1zoxEjATVjBenJ5N4ldx65tXqWeGNv9PwYJb3Lvmy7KuJ29+es9QE2xqvHg8joSl6SJp/22N8IY5QLCeG88h4IC47TYk4MsepaW/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552206; c=relaxed/simple;
	bh=xQJsxPI2cAE+XdvtefXltIELpJOI0cOw2uYRjm17pwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o5VKOA/+NuI3eyPZbvf6qhtW4xi7Q0Sa4RI1zjyqWzWCvn2/hV7nEbIZIDhgqwCmmRV2N7hvKSPZG9ZvFM6NqJ3xGD/GFHD+cnFWZHN/PVLXtQv+6asn8PZch+QYlJCqY7XPpMuRUkPVt6fi1K8Lzb310VqHlS8qrBttRAmqxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24049d16515so5196705ad.1;
        Thu, 07 Aug 2025 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552202; x=1755157002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HKfSAyrZ2BvktZne3hUZFZiKCfhfC4bYOLFKAq1gCM=;
        b=pJUz7xg+lQY6427AXAJS+6ptxwhSmub4JrDUJ017RjqJ35Z7PctDd7f2lyHxM8zcNV
         SgJ52/lryc/wmHei8AN3faC5wMe8o8gHTzoYpVC0w8Y1/vsoWXdGDDz1HGurW2wKHia5
         dIoGDYCd1eca1HfokMLrKhrvmu/xTel8N6WBLFZpfXgExPxwQuLARfMPBgTBS4GdLllF
         3ioIRnXxXXzXVm4HCkFAXEmktngpKrrIDY/0u6EgwHnnePYBoYmxYGy4jDjTsOiruM/6
         30gL36Q7sk1u2roQzycpPZ4HId0DgINb0vyk4mo709l45sV0H/g8R5LD5UL/ME/sUajF
         Biow==
X-Forwarded-Encrypted: i=1; AJvYcCVLQ73X9c3NUptL/pTFIsKX4kK3lb/kVMRcvOxVlwANGzR/9L81GTOarzwpl5Kvlz/xMDmxRZNre6uu@vger.kernel.org, AJvYcCWUbneQxD9VHGi3sW1++T7Z0UGfJD0icK9cFDwWAYutxZKUEvLWV7p3uYO6zkGZ6fYP7uVjy3BqccBzozx3@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdSLh0BJU1vI7ov8+v8uSrh6FkReUdUDK9+ctu+UZzTxS6tLd
	RuKsHOOxdIX3FYJt4Dy/ijzbSUK3F934Gy6pJ+E5tU/p+/Ygvad7yBDp
X-Gm-Gg: ASbGncvN8qWm+vx1kNiBtA5RPq0hcibGIBmdCWYFrXpvl4IeRd+lIpf1YmxpwwwiVdm
	I1palbI9OQVWICfp9bNG6mGYs/UEDt45skgeE7lYWKgm4N+DefUv81K6PadTSc7Wzu3OieL6E3G
	rAQ7fJOt1grreY3ikkEpoyScbrxvj3sVgZg6eu4xShw5LNWmtEoXFHrr346fc+51uTHUBqKdluB
	pvMwGzfk1Wg90gmlnlUxgUHk0wv/t5GiEu9h6u1ABKa8KaCCW55yPj3lqVk0M6QSwnOOH/boQom
	XQsiyUylsnwalp6iY3Eyvzssoml5Tuz8cy5vj7kCvWdHnMneyqUV8wowcyqS0DBt53fRfUdnz8G
	buZDp/WMKgN8be2GM0Zh1zmOo7CWzw5kosmtsjinf6fUS
X-Google-Smtp-Source: AGHT+IHjtnIDwqnwHu2tVfvxK2+xIjGDDYPSo2jUj3dg5GI+sd464cduEnfix8ylS9kOHwBHz5F1+Q==
X-Received: by 2002:a17:903:3bcc:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-242a0bffb31mr70548125ad.53.1754552202196;
        Thu, 07 Aug 2025 00:36:42 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f15092sm177955265ad.66.2025.08.07.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:36:41 -0700 (PDT)
From: xiehongyu1@kylinos.cn
To: yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	mdf@kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v2] fpga: afu: fix potential integer overflow
Date: Thu,  7 Aug 2025 15:36:33 +0800
Message-Id: <20250807073633.140532-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Xie <xiehongyu1@kylinos.cn>

Without context, There are two overflow scenarios:
1, region->offset + region->size Overflow:
  When region->offset is close to U64_MAX and region->size is
sufficiently large, the addition result may wrap around to a
very small value (e.g., 0 or near 0).
  In this case, even if the target range [offset, offset+size)
falls within the region, the condition region->offset +
region->size >= offset + size will fail due to the wrapped
value being small. This causes the function to erroneously
return -EINVAL.

2, offset + size overflow:
  When offset is close to U64_MAX and size is large, offset +
size wraps around to a small value.

  Here, region->offset + region->size (which would be a large
value if not overflowing) might incorrectly satisfy
region->offset + region->size >= offset + size due to the
wrapped small value. This leads to a false match, even though
the actual range [offset, offset+size) spans the wrap-around
boundary and does not belong to this region.

Assume region->offset and region->size had been properly
initialized at the very beginning. And fix the second scenario.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---

v1->v2: check sum before for loop

 drivers/fpga/dfl-afu-region.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
index b11a5b21e666..517a59a9410a 100644
--- a/drivers/fpga/dfl-afu-region.c
+++ b/drivers/fpga/dfl-afu-region.c
@@ -151,13 +151,20 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
 {
 	struct dfl_afu_mmio_region *region;
 	struct dfl_afu *afu;
+	u64 sum = 0;
 	int ret = 0;
 
 	mutex_lock(&fdata->lock);
+
+	if (check_add_overflow(offset, size, &sum)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	afu = dfl_fpga_fdata_get_private(fdata);
 	for_each_region(region, afu)
 		if (region->offset <= offset &&
-		    region->offset + region->size >= offset + size) {
+		    region->offset + region->size >= sum) {
 			*pregion = *region;
 			goto exit;
 		}
-- 
2.25.1


