Return-Path: <linux-fpga+bounces-1100-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D4DA5B5AB
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Mar 2025 02:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCEC189136A
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Mar 2025 01:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C904A8F6C;
	Tue, 11 Mar 2025 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAzz+9v0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4516A846C;
	Tue, 11 Mar 2025 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741655839; cv=none; b=VkVakzWUrfcHVm4YrNYocc3zXbKx+jl/qGyL/uJQ6Ce5giBADmgJvLZthpVmdMgJtbTvH8ie2TISRPZvGlpWQZ5oSxWYrXTW3uSIBlFzfuN1NVdPm0teEpS26FYNx/npEVNdAN21UTKE72M5bJi2s6PU2NRZ1X4Z10bmrzBNqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741655839; c=relaxed/simple;
	bh=xMSiTnUY5WCIOXnfdK7peBdjLOd38DTSY+w++3s95tE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pnd1wjLmRD7Nr3VrivSL98FrKWBPws03AcrAeaPX5AiwtrBKJ04FE6flkEwLLZyRFHosFGIIsDwS79flSBT2vp2jH8LWelstnb2o53ytvS9BRpzL76cx5kCov+WAnj1skbEG4XLNnQztepqEBweRNx28g3/tgKSY1AjOEQzPCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAzz+9v0; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8a212a699so9167456d6.0;
        Mon, 10 Mar 2025 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741655837; x=1742260637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHQLfy7ZCLKhfFcUxyubv3kHT4mMsT+m4Xn1Zvd0Dn8=;
        b=aAzz+9v0FpqgG/TrbXWs0/HZxreJoDvFi0aLvgG/8D0aLB2iT5875mXIoujXMuEocM
         B7ovH1Ap98JDKwCK2H1i4REZbmkqeGa4hp7X+iG0Tx4VGnpLQZ36NKWL6bC+uQ1/2VcO
         N5RfMFnPteCuOWwLI4KWH9z92MUPP3OmbOx8PDjBtTNh/DEJrwoLF3+UX4cy6DEbAmwi
         Q4z6KR4+jVXI+pO04YQ0LX6Sq5pftBdr5vlhXWXZhRGBCf8k91TVfLTW1SmI8cXA5YAm
         WxBzOWBPJ1Ewyz9WiDRzfOpy31b9N4wcJyv3jzHN/n8KqaUovoSOwqlosHFCLb1VMASB
         7u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741655837; x=1742260637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHQLfy7ZCLKhfFcUxyubv3kHT4mMsT+m4Xn1Zvd0Dn8=;
        b=mOZ8dojq6h01cw+X5l+8DGKTh8dLTnm9e5/yN8Tjx3ERnTmGjhNR2tqxvWXZXZBihG
         Y8MrzzHg8EGm6CUQVVYm47GgxcSfEFZYv+cFw/by/UzfhcGbGKbahfrc8GPGVClLbB8z
         mHOiz9pj7wWmnTr1OQTit6M+7xACfAJ4ntD8zs8r4wH0vyNx8OchRcflq+CZXlx+omao
         0BgmeET0IcADsAfypSRdmJG2JkfayVDWuBR8G/7ooNM8dkOQsxOjn/aJnm/oPH9WUS9t
         O1Y6QWxNqd3WRF/gqqktL5EvgpWrpAOngWp0pqihlVciQKiFCR+e9kT8eESzdhgncfjZ
         NitQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEEn1URKqwqbqS0iLDAkUI7OKG4TejBnikELuInE8gA1WB3csCGSAUIVfUOah90mnBNqFQ1CVGdk1hbDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbBFfOk2fNHzgEhHorLHGdfC9R9k0HLydXvGJirpx+E30dqmVU
	BNq7u89UpShT8yCHqm2bRu0mf4tBtOBRLgVWfyaV84Oo0sLow44=
X-Gm-Gg: ASbGncsNAcAYEB9i4OHgagfpTJm60Hr3SHkF0lv090J1QSfvFTSH/kbOOzaVC5dSUqx
	Fd1VdQYZVEaycdau3/MaGwA35OoVFZj9SmIJx1mmUDHvg6YtN3VNYuGcJz84gDK5XEzMQ19Qr2c
	svUiD6SmMX7NU1rXBcfl8U8n/xy3qbKmdnC7GJxmDm+YC2o9phnO6vrp1BpbSUw0ATve4MexgzB
	Fr0Z+4nTdr7dp36r0euL+z5RSHNfgA1BDqyZ/OYDlKwTuz2R54SOrqrXC0U+YE0cLWth/qNbY9y
	xBuraBgGUSIkpLvn4HyQmddweAhHjJGFcENi6np2Wg==
X-Google-Smtp-Source: AGHT+IFsNnvwuiKl7mq1VgQyS5iJwKXYAFib2e4g+qKyCpH41maIhobaZQ7I8O55WnIaSOBXcDc2vg==
X-Received: by 2002:ad4:5b86:0:b0:6e8:fbaf:fad8 with SMTP id 6a1803df08f44-6ea2dd2381emr10517396d6.5.1741655837038;
        Mon, 10 Mar 2025 18:17:17 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a44adsm64903516d6.64.2025.03.10.18.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 18:17:16 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: hao.wu@intel.com,
	trix@redhat.com,
	mdf@kernel.org,
	yilun.xu@intel.com,
	richardcochran@gmail.com
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] fpga: dfl: fme: Add NULL pointer check in fme_perf_pmu_register()
Date: Mon, 10 Mar 2025 20:16:53 -0500
Message-Id: <20250311011653.1175840-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

name, returned by devm_kasprintf(), could be NULL.
A pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
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


