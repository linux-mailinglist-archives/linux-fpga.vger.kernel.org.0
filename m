Return-Path: <linux-fpga+bounces-1253-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C886DAE8257
	for <lists+linux-fpga@lfdr.de>; Wed, 25 Jun 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1918D17B159
	for <lists+linux-fpga@lfdr.de>; Wed, 25 Jun 2025 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6FE225792;
	Wed, 25 Jun 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5wl23uo"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACC442C;
	Wed, 25 Jun 2025 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853184; cv=none; b=lxS5SR9N5WsImpGMx5vUw3xi6xx/C6YWUIjqr54Dc+TdW1EznAocC9kokWE90wuuUVGJglebKwSst6KVH4YJnz9CW5o3AaQq5GH0K24Z5j56XGOlQp7VH6ajFnk7PngXKN72ofZOZERvszctD5g18M9ICKL8ymvsBGWV1fAtZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853184; c=relaxed/simple;
	bh=sk3KwBpIIrphnJBmTDIE4jith+D91+JkwVEhlPpPi5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZaswrrM8xe6nH1CH3t0FkmHnQ+w6oMyy49k1t9b5yCghhWDJbrZLDx1wJruAxP1yE8c/eNGI0+5/0CrhITjGqxnze4CISDIqtcEIsIF0CjchgNLqBRvGdjFRWDlT0l0ByCgv2vJNNKu2Z+w7aye5/Xn4RyQFeNboyaqAulC8hU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5wl23uo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234b9dfb842so59539825ad.1;
        Wed, 25 Jun 2025 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750853182; x=1751457982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJQyZbGrLGzQaqvoMkS8YTL49u/v3LblMDiOt/0pDDQ=;
        b=b5wl23uoEom1EiYI7jO095L8upy+fdWr0pbAIlRhrzqcQsS7LVxU69B7ZBnLU1uFkI
         u3D2dXBDZUB2zq6QhYQhzfLlsXtktLx1s0xX0cKEVBKAoXEtxB7UnaWb4a1/4JjMdE0J
         rRLghNODiAnZG5rnwtb6DEc82sPgAOSJJAahhbr4fWMwEStsQagYqpri6wpj0CygDM62
         5ScJmxKZJiYYD/8mpGtey1Oq3hdlC9KW5L4cqOWl62OBTE+H3GkzPKZL5LifbWFF2bVp
         p/ZQf9pXJm8nTZQvrvs1+TC+uo4xOyZc9PdPIejYkr9+dryP6XgOMo5YcC134XB2JXDu
         3ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750853182; x=1751457982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJQyZbGrLGzQaqvoMkS8YTL49u/v3LblMDiOt/0pDDQ=;
        b=iDnv1Sz1q+zx3IAHAfQyP9LWNYFnkAcZhDLg9JZvQbRE3AWwjdGwRN0dVdx+MOSwM9
         svugehdJKa87z07SgYG9L6fdUMKFSLF04qhuu5lNZlteGLISDA3f0f1pIQWTQ7MdKstz
         a2coi7kKecVlAxhIqblwc3iWeo51OFYKH08lT9vpRLEZDJcC/zHalnsxeAm2VlPsoboy
         rlPyPQjy9aGEzepIYkN+LkUh45i+MLD2NqEDdqsRxY/Fv8eKFN7Q1kS2PKKshQ2gcdIR
         PCJHHorNFdUCBgQN7iVtjVOMQKOT9zkLVjbBMACTE6jeVdhCPHPmKTVZ1TVc22P6EebN
         HDmw==
X-Forwarded-Encrypted: i=1; AJvYcCX1HjvzIGEvshTU8wusp49pimhgUjiWpP26CQkEvwGdzStB7fJYnMkOq6lK1yDILSMAwZ45+eP01qZ0oAlN@vger.kernel.org, AJvYcCXiLd9fOUAbXd69njmqm8FlkdD6+ponMmeJ09XbdHp7Rd2Ljl1nRo4/BGWGvIuQvrVCnYNAjyYIQY/c@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83KPItdaHrbVRbKFi33Xr6JdXabdoy2s4P7FhzErs/zLmpFnx
	yPuFManlVqNw4hClRSSqNxs3DmNGl1qyHCSfXiEoCOMeIDS+VRC+ZBhH/SG9heLREkw=
X-Gm-Gg: ASbGnctTRJF6IvWE8tbI06RuWtjMc2BusyKGfk2L5zD5g5vY6QEXmo9OXaYfmXSyCQ9
	PuD1zEXGB1dQU/NtLcnEajIanHs8TJhX5eLGwDscPj35m2IhMcREu1PWupfLJsq5LPUqspiLfNn
	L0i8YtXtgX3Ske6e4X8hP88KeIRvDLfjZBXyVSj8Q2Wa+QA83C5bM3ccLU2qhkp302w3T2GfRLN
	aLz+hR7uw5paJ+TMEPftAcgi1ddKj5oURQq31hvc7WGSbVhnWSV28gjj5wK/oWep4r/RriS/nmX
	+pq5cyxNebTdY6/rZoIi1S5WuiO89pD/qClQw2s0t8jMb11c6/BbaxRvPrsAKbUzoqB/lvyhYKQ
	=
X-Google-Smtp-Source: AGHT+IFW/227zU1PAtWE9n/7D2wZ5EANMebxEyNLnKo86hYDOg//y7zJ4Kqtt6qG413sAQxmvbc/UA==
X-Received: by 2002:a17:902:e543:b0:234:f182:a735 with SMTP id d9443c01a7336-2382403df32mr56141195ad.34.1750853182097;
        Wed, 25 Jun 2025 05:06:22 -0700 (PDT)
Received: from seokw-960QHA.. ([219.250.16.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393784sm129428705ad.11.2025.06.25.05.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:06:21 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: hao.wu@intel.com,
	trix@redhat.com,
	mdf@kernel.org,
	yilun.xu@intel.com
Cc: Ryan Chung <seokwoo.chung130@gmail.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] dfl-fme-main.c: Replace scnprintf() with sysfs_emit()
Date: Wed, 25 Jun 2025 21:05:49 +0900
Message-ID: <20250625120601.18445-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change uses sysfs_emit() API usage for sysfs 'show'
functions as recommended from Documentation/filesystems/sysfs.rst.

No functional change intended.

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 drivers/fpga/dfl-fme-main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 8aca2fb20e87..4be51ae60226 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -36,7 +36,7 @@ static ssize_t ports_num_show(struct device *dev,
 
 	v = readq(base + FME_HDR_CAP);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			 (unsigned int)FIELD_GET(FME_CAP_NUM_PORTS, v));
 }
 static DEVICE_ATTR_RO(ports_num);
@@ -56,7 +56,7 @@ static ssize_t bitstream_id_show(struct device *dev,
 
 	v = readq(base + FME_HDR_BITSTREAM_ID);
 
-	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+	return sysfs_emit(buf, "0x%llx\n", (unsigned long long)v);
 }
 static DEVICE_ATTR_RO(bitstream_id);
 
@@ -75,7 +75,7 @@ static ssize_t bitstream_metadata_show(struct device *dev,
 
 	v = readq(base + FME_HDR_BITSTREAM_MD);
 
-	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+	return sysfs_emit(buf, "0x%llx\n", (unsigned long long)v);
 }
 static DEVICE_ATTR_RO(bitstream_metadata);
 
-- 
2.43.0


