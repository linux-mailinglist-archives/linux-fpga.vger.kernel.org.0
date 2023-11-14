Return-Path: <linux-fpga+bounces-7-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C59267EAEBB
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Nov 2023 12:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A86B20A33
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Nov 2023 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B553C224F1;
	Tue, 14 Nov 2023 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2aNx1vR"
X-Original-To: linux-fpga@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335FF224CD
	for <linux-fpga@vger.kernel.org>; Tue, 14 Nov 2023 11:19:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A812D9
	for <linux-fpga@vger.kernel.org>; Tue, 14 Nov 2023 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699960788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5YJYH1v0uugBJ+ptP05BEEV2yywxHJ1l8QRV0Sx86TE=;
	b=D2aNx1vRqIYdZI94bYeGyXrO4qs9uTbfXLvSe2xXs0US1CqjMSQC4mI6cJynZ1R6qnISBI
	+uWykoOPLh4QIv+LbI1IfNX1CsKyNOg/4koDfzZJYc3+38iMNoWynLqVTicwxisOWmoQfh
	OAyHFa+GuErUuvVPtyc0pKCeXJLY1iY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-466gnnOsPRWs9doS4fMm-g-1; Tue, 14 Nov 2023 06:19:46 -0500
X-MC-Unique: 466gnnOsPRWs9doS4fMm-g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5094bb86ebfso767453e87.1
        for <linux-fpga@vger.kernel.org>; Tue, 14 Nov 2023 03:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699960785; x=1700565585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YJYH1v0uugBJ+ptP05BEEV2yywxHJ1l8QRV0Sx86TE=;
        b=BAXPGDVbS8ZAY+mR6hlrYpofa1WwV9WzB3LC2Ru4lPCdygYPzoKL/d3+9hpMIJIjm0
         ht8Lspx4alpc99NpsjuYRjU2R21QQgaTcC8zs+wak8RkwLVbTbk+vEKpzCneBp783QdH
         5EBv0Ij3UmC6zI2rnBUP73gdgksb7pOWFXYJGo/jrgf5cbiDDctjLj/SQCJWTYQ7M5F1
         thulw3PePcRL4XAhoe9oB1wO+jnsORHOwi7v8rNKwDyV5ESS65ejXZCYiOVP5h29JYHD
         v47YxwkcAVczVmSufoJ+hXL7wLcWQcKpaYKw/freBWp4eCKLkm2RVpPKq439jYhR/qat
         AJoA==
X-Gm-Message-State: AOJu0YxVHTrSVvSD0xb22DJjK+DaXgVr8aRPt72Ml2xS8VLuHmjewsFr
	p/wyNfMXFEYvR3pD5N2SRMyyb1i1GreRXS3EDEzcW82ejj6/HUCIBZqXZmlXfvRzc8Re4aiSt19
	Jtq9GTgkoubCdBysYn/No+w==
X-Received: by 2002:a05:6512:48cd:b0:507:9d5c:62e3 with SMTP id er13-20020a05651248cd00b005079d5c62e3mr1195099lfb.5.1699960785287;
        Tue, 14 Nov 2023 03:19:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdb04nRiqIQnJcrT16Dda91bu/bXi3ErlEL/19p/NPUTa0J9CdAk9QVyXhqvTifytDdFyFmA==
X-Received: by 2002:a05:6512:48cd:b0:507:9d5c:62e3 with SMTP id er13-20020a05651248cd00b005079d5c62e3mr1195082lfb.5.1699960784990;
        Tue, 14 Nov 2023 03:19:44 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:90a:30ce:554c:3b85:52df:8c32])
        by smtp.gmail.com with ESMTPSA id 27-20020a508e1b000000b0053e89721d4esm5039345edw.68.2023.11.14.03.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 03:19:44 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH v2] drivers/fpga: use standard array-copy function
Date: Tue, 14 Nov 2023 12:19:02 +0100
Message-ID: <20231114111901.19380-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dfl.c utilizes memdup_user() and array_size() to copy a userspace array.
array_size() will likely never trigger thanks to the preceeding check.
Nevertheless, in the theoretical event that it would, it would return
SIZE_MAX to memdup_user(), resulting in an attempt to allocate huge
amounts of memory.

string.h from the core-api now provides memdup_array_user() which also
performs an overflow check and returns an error-pointer with -EOVERFLOW
to the caller.
As an additional advantage it standardizes how userspace-arrays are
being copied and, thus, makes it more obvious to readers that an array
is being copied.

Replace memdup_user() with memdup_array_user().

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
- Rewrite commit's name and message to clarify the patch's advantages
---
 drivers/fpga/dfl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index dd7a783d53b5..e69b9f1f2a50 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -2008,8 +2008,8 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 	    (hdr.start + hdr.count < hdr.start))
 		return -EINVAL;
 
-	fds = memdup_user((void __user *)(arg + sizeof(hdr)),
-			  array_size(hdr.count, sizeof(s32)));
+	fds = memdup_array_user((void __user *)(arg + sizeof(hdr)),
+				hdr.count, sizeof(s32));
 	if (IS_ERR(fds))
 		return PTR_ERR(fds);
 
-- 
2.41.0


