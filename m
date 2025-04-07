Return-Path: <linux-fpga+bounces-1135-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D69A7D46D
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 08:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930A516B990
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 06:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB66225401;
	Mon,  7 Apr 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGNeiXT5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5C2253E9;
	Mon,  7 Apr 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008266; cv=none; b=L95DOMpD7QcMzRdFkP+IvdYyU+B+TtjmqGt51zvB2Twzyrowdlbe+rRBbToUEEUG2OtQjmfFp8PjpYczeJBiSKPr2S/v8iNMqVwD3XqKO910LRJl71mA6gyszyhu+6TwkwuSwgSNflmt3pIQ8KRWu2wSfi1PVARpAEGnZ4szrcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008266; c=relaxed/simple;
	bh=IJApF5GvlUKaQ4dbhAj9lAxSkNFHTX2V50aLbgGJ4nA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K/NChSAmL9WboXZe6hFo/PrHtPa3g6Wc4imOomId1kmD1Ds9pp2vQCFHPaQAYu14X0SEP4BveKyh3MX31rE1z60Nu2OQtrezyLiTjm2qfxmaBm2e9zc570dlb+w04+T6FH2NdclfmYctjWxfCrPXRbdr0AsCwwOCd7jf2XOiM78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGNeiXT5; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-af519c159a8so3526480a12.3;
        Sun, 06 Apr 2025 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744008264; x=1744613064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R23Rmd1lHP4+HXEGAjgEs6C/ntfgiWBbV61WRF6DA/4=;
        b=gGNeiXT5BsB5v9xaXNUIZE/OJ87kgJOy4NS/p1P3KRu6cZJEqXFyARNtGg2lqlf23n
         5DdKLDiyJlLNfhDo0wwfWSFLRbdiSPOuyMVLckOGiS0OqcVCcl8cJbXU+BjanLfmiI4F
         NEEsWTutzOnIQcCqTwBX3PH0VSmGk1VoGue99gAx94mCT4mwHp890sKg7uIeC0KjWVB+
         jqms+N2T6aNBfRPnf7ax++rvLSiY2BaopKRTMmWcQugXR9mCEuRbXR8t7t205A+WOAFB
         rnFkDvx8tEZBvNoeUSEMp87yputiVySXJkpYfGJO2oOcxWpsk3iFtq/wvuhkXUaaHr2c
         JpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744008264; x=1744613064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R23Rmd1lHP4+HXEGAjgEs6C/ntfgiWBbV61WRF6DA/4=;
        b=n98foV+v+NuaLYk8eEkipTjmWCIUa3+UHMD4HlH9FxYhqkfLkKxJ6h8ivPSwczZH9l
         kWUrzdBQroIJWV8+YFS6xpzndN0CDD9VjfCSBMTYFnrpK9BV3Q2fa5aAy31r/9hNrKXG
         wji4RK+aq8KcWnywTw+NYmhZ7qXwZO0hPSpTVtDNK9M/JYN2o3Gm6XH+Waupu8+4Bw3X
         W9Nf3RTR9f4m9kX0iPa/33PA6hrnmE8+BDB7NSEWrqSZja+JEX176YXS31KrtGPEXeq4
         C4lkLyRlODi4FfY3EgrQYXIHE3YFr3UrnHmxkuOdllwHO2V7iT+YFNl32JCgftmvgEr0
         dlPg==
X-Forwarded-Encrypted: i=1; AJvYcCUoji7vDzTgnCteMhnjB2Yv6UEm/8N0BSyxFp+48Cv84vHEkSxx7EQpZRu7w13FosqvBfNEvKkKjiWJ@vger.kernel.org, AJvYcCV4AjKkEhYQ/ckFBwDLOpKSjMZbh9bN12FEzVdTOm3j+00BaaJtTA3poZDbI7zEuRhENekdSpPD1Kon48ED@vger.kernel.org
X-Gm-Message-State: AOJu0YxhzVXwqnjBcdJyhYk0fa/QJ4246ogpThtNx7FanjwvW4bKwMKg
	X2mp1rNO3lkcHypP4QjmygIbYc1/8VJw8jIrOvqU4f7nZo7NTXD+VcJjMw16BF2j5Q==
X-Gm-Gg: ASbGncu8m0s3CD2OCfANaFUd2MwHY2871dMUYIY4cC9ZeTpH7DRkwmiF5Y2C20zEtoW
	lyk8/sqrjv8mhWw5C3m6Sam7cJF3dSC16Lsc+GXjrXehAUMpmBjGo0Weecf7HMApU1jFlrqHsBw
	DiclZ86OkbV5nQY3HAbSWSasLi7HJ9wPeMRHyJ3BUkSZaV3fOPmfQmR5GOei0OL/hi6ax6Eqrun
	SJt0/Xq8GLTMn/iQ3NHn1KsNffv3YmYvBUv2+8Fv2ZMIflguz7iPx63i8hDo4ZO4kIcMx/vojHN
	hRB31stDUYw4ZVMUTdy2f2J/hGV4VZrlLjRaaxiwsmtJXjBkDk8mSiqHHA//wP2jwpTtUSjvaZJ
	UKyvYhw==
X-Google-Smtp-Source: AGHT+IHNadhMygFzVobr7OxY7oNZ6KW59eLbA8+UAQX34B0lIsW0kcJj8gK5tdNV+4GIMrlyQsAFtQ==
X-Received: by 2002:a17:90b:6c3:b0:2f4:432d:250d with SMTP id 98e67ed59e1d1-306a617d201mr14598370a91.21.1744008264238;
        Sun, 06 Apr 2025 23:44:24 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983b9d08sm8074055a91.35.2025.04.06.23.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 23:44:23 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: hao.wu@intel.com,
	mdf@kernel.org,
	yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2] fpga: dfl: fme: Add NULL check in fme_perf_pmu_register()
Date: Mon,  7 Apr 2025 14:44:11 +0800
Message-Id: <20250407064411.87531-1-bsdhenrymartin@gmail.com>
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
V1 -> V2: Add a blank line after the NULL check.

 drivers/fpga/dfl-fme-perf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6f37..db56d52411ef 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -925,6 +925,8 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
 				PERF_PMU_CAP_NO_EXCLUDE;
 
 	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
+	if (!name)
+		return -ENOMEM;
 
 	ret = perf_pmu_register(pmu, name, -1);
 	if (ret)
-- 
2.34.1


