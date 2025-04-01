Return-Path: <linux-fpga+bounces-1134-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1544A77E00
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Apr 2025 16:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36DD3A630E
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Apr 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539B204F61;
	Tue,  1 Apr 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG48SrVZ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7B204C30;
	Tue,  1 Apr 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518403; cv=none; b=qCNuPLcsIPLSxAwTkViwIPGAGs+qJcq/4GF+65/xFe+mCBOE3nEHw4scLJiLcMDzaiDcePh+QE1mblfMP+Kjb8CEKdVLCJPdLsPWbbGf7DbV6vztCGqKwmhOgWLb6SRSIs4fLWVxNoxP7XPP1NQTVDyhmIayRfUnSHsx5pfYOVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518403; c=relaxed/simple;
	bh=OgPnDWSDDOIhMQjsGQRqzduqk2CWVZPDUqJlIh2G4cY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rBwupcI9LsqrRheKcyRf3YRidRHNB5krpaMpMy7zTGp4yJBGznksXadHWMUCldq8n0N+5RjxfoQhBpBg6LZP7sjEqc29rHnxfZLVNzxM8YgNNmE/EZaChhui13NwgdyXt9jvyFSpu/K6zt8VUtjAi1fwaTQbAUFQHEOhZGgMmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG48SrVZ; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso9685993a91.3;
        Tue, 01 Apr 2025 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743518401; x=1744123201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GrrqHsj5keKk2MOZw8l4umAVHzsGA9qHUuqFkoRtCFM=;
        b=DG48SrVZhSA87crYehKNn+7DJoyiLwQFaSmVIWrtk6632TLR6qdGm7HA1aKkbDn7Zt
         j/sRGTuh0bsasaCRt3uGsYngPoCYZxHMnvRImnEAncFogEAZgGjEQlznGtNeIoSdTXBt
         UoIsEMSSYsNiW9K4kW4xPU7BVPx+cBKOrBcJNrtxtGBRNPbB0dAQ5MVGCY+lzN4CzAxw
         gfeCMikTOqLXDikBgL1ggIiRQbF0kcYBD5+wyKpaUqbOkohKzDpUTIUrz/xkgknUPhge
         wwbbAW5dnijX9ei4C4FJj18wC4wf/sxOcMGD15H+LJLKglnm9atSjeursq7F71Qi5EoA
         2Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743518401; x=1744123201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrrqHsj5keKk2MOZw8l4umAVHzsGA9qHUuqFkoRtCFM=;
        b=WCG+5u8rR8WXgqqr+u8yYKH3KjWgSf5LF6xANcQgToj0pLzNDi5pZVp6LymDsvrJO+
         3xJXxyHffiz+9n3ndtzxq19HdeL0mB2zrcUe45d2UJAqdlsQqtTPJHIXxj/Sl/FHqaG+
         4vIpFyXQ8US7JEuyhIE0hy4pPmbbjIsj4QLFoPC0Us/mCXXEKUpgdX60QuEUilpUzdfv
         fvL9Ix17d6mepijFLYvsU+2hEpVlhARI6y0lCvKJqs8FlS5w98bDTG5IKkoRaqQm8KMq
         YrDn2B5S6Ly2ANq4mLF2lbUaSdT6VZCeryCwo0PPnpnAawgqCAje2jI+J3HpYOGQ2diH
         qHKw==
X-Forwarded-Encrypted: i=1; AJvYcCUmDXf0wh2bHHxHdQeeQBsUUXLVMAQ+6fPocr/vs+NKEYQXPbhmoUGUrXGsrb3FsR+etu3WzPr16/5+@vger.kernel.org, AJvYcCWBgSynlXo74RNB2II6g6R4XLXgcKjdCXJ8gJgmK4HDmWqDUpIJ0uqrPlfQ9aL/DasFPeTqCp17/hMWnkwV@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwBuhttFrJ2oX/83/p4llyy8CoJrIh9tNZTkVl9HNUM5p8QNZ
	VBkgKCeDnyu4fzU+ltnyFTkpIBGWlTeoNE5nfzDqimMYL5WK74RJ
X-Gm-Gg: ASbGncuJYIGb5FHzy/bV8AvzPyTDpCIu2VoJhcrC1pyZ9a7ZYRNE+kQEm4vuekfXTY7
	s1491yd3Ut4++BWzCaPTXapkdoAwtZQ1rpKwcScpcpuP3aBQFaC9iS/wrFBg+Rrh8SnLq7HqyKk
	XpNHxEDyzgaP+iwquwQiGKKab5YCu/XAq8grmM/WO0sQ2prq/uk25uLZ1lcBY0DRl5YeKIG5Dmu
	H/+rhopVw37zsKM4i9Kkorz8talgxvW6wAy6svqbuPSbtYFg1FooQUX4cjYp5rk9Nb4EPbVv7gR
	0ZtZqkbdZdxwcvrNXExh1oumEV1zpY/nK+Lri7WKwENbDW+srf/ABEhoxyk0jtpHfIYBRl8=
X-Google-Smtp-Source: AGHT+IFWfyBQQSxaep+SVH1JyvnM/fP1pW4NbPNNH2bIPbxplcKq9RiIXGFHhQnrPqr16c+Wubrxgg==
X-Received: by 2002:a17:90b:264e:b0:2fa:137f:5c61 with SMTP id 98e67ed59e1d1-30531fa4e78mr24481206a91.12.1743518401471;
        Tue, 01 Apr 2025 07:40:01 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f1d4ba4sm11714257a91.31.2025.04.01.07.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:40:01 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: hao.wu@intel.com,
	mdf@kernel.org,
	yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] fpga: dfl: fme: Add NULL check in fme_perf_pmu_register()
Date: Tue,  1 Apr 2025 22:39:53 +0800
Message-Id: <20250401143953.30825-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
fme_perf_pmu_register() does not check for this case, which results in a
NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 724142f8c42a ("fpga: dfl: fme: add performance reporting support")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/fpga/dfl-fme-perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6f37..dbacdacf38cd 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -925,7 +925,8 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
 				PERF_PMU_CAP_NO_EXCLUDE;
 
 	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
-
+	if (!name)
+		return -ENOMEM;
 	ret = perf_pmu_register(pmu, name, -1);
 	if (ret)
 		return ret;
-- 
2.34.1


