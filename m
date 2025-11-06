Return-Path: <linux-fpga+bounces-1427-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A25C3D205
	for <lists+linux-fpga@lfdr.de>; Thu, 06 Nov 2025 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3991018940C2
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Nov 2025 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94767351FAB;
	Thu,  6 Nov 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRLIjusp"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119E322A13
	for <linux-fpga@vger.kernel.org>; Thu,  6 Nov 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455599; cv=none; b=QGws5jwAcnGXAvzkF5YkPyGbJKVvbFd+lFjqf718abzCgEVl68SCIexFjvHHEER9Lk04y4Eiq76tu5XHqDWIZem6C1mmcxiiYHchPMiPk3DFYwPWQZ5FfuUsdiSQDWpYs8NU5kmp/P4JY+FkpIwwpUVTbY6jjB/alMkF06Z3B2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455599; c=relaxed/simple;
	bh=FdSCwiSshFZ7afgtql3FokO1RkhuU/9Wdt6izw4XTEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCldLHo5/US0hSseLzU/VziYQDkAQ2ye5yMidJVkx5xD9pRc39P+LOoTa7+a12wxdSywxTrtWaszNlch4zmPdfCcUc8YJd/H62KXQIsKtkTLdvTY1SkbOVCftykN9cAP9REGkEmaKeczzed+NwQ2wX3afgDVNZHoyG1Ata0a+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRLIjusp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294fc62d7f4so12735565ad.2
        for <linux-fpga@vger.kernel.org>; Thu, 06 Nov 2025 10:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762455597; x=1763060397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOr+m5rYLx6qSZrmqhOAOC6HJg4sqwHlND90ecNT9Wk=;
        b=KRLIjusp8gUOZnwc5Zp5DgYizim6A+iJJ+yNGoLN5E3ThHIdSBZyZCYyXfTvSMQrnH
         tDOp3Y2i7G2yn43KYC9kO0ew7IRDUBORF50jfNLgQtjEcJS8x2CVr0z+m3pP/Ddvt3de
         xI2HjuR1caTZ279BDpmNgtdeHhhFZrPyF7d7JPlbVBrBqpKUIGX7IqGJGXyJdqDspcYG
         s/wkLY4sPNAcKZuW6yhRw8un7CRewJ0dlsI7WCUowI4Q29bXIbWF+e0PT5nAV9TLzPhB
         iGoRADAF8soJ5TnhKomhGf9oumZK/ejpe2OeYSTcWT8aaPK2osjydzHJs2Gg62bqCkd9
         MXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455597; x=1763060397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOr+m5rYLx6qSZrmqhOAOC6HJg4sqwHlND90ecNT9Wk=;
        b=hNHm9rYczFDcqLmdtRqlGaqgNfasv4I1cP5acnQD6qt4TKJnJ4O3FhkjZELEnBD0G5
         mla29C+clujMbFSlQCQJb/5iccUoN63yiJFeXPu8kbn8xZHa8/vRctBlqmLd6hQJTFH/
         uoYcd9DPDsbwr/wQD5M5yhcZt3r1sDZmtIzkdrVJd9+JmT9DZWAu/HuFLKBG9Grnq+Nf
         PqNpZDIGWQgV1FVdLn2luxATuGNJEIEqSEoS4vkP4MguQAEZJ25AbXZU9sA82dCS/QLc
         Jw14ULUwJak0Ll6qMBGlAlXUR4ZS9vH8p4kGK8FA/Oxxln8IT9S3qIWvHOHVwPv/t1cs
         trAg==
X-Gm-Message-State: AOJu0YxqKHlOSHrDV7jJkP4RLhk/OtRAWoWMZ7QxcK5RrCnFPqSh8Vlt
	PuYY88R37jHbVGgwyjAZnkqOLXXSZMCq827l+s/FRcNSBDbcUO+xrvWuCMKezw==
X-Gm-Gg: ASbGncst2YA6dJavae4BknqiSvp8uYlEn4ilClxEr3Le2ISFtgNpaJbmCto3dIiOcR9
	JJaUiN5Ha3IjGMejoHSzRD9LvVhFIWXkp3DsoRQ3uz96rKkisItyCx6usYNlg+zM6NF9u7zEDZk
	LMuy32GykhNl8kAfWZ/DH25y0dYGizCNe6nxqOsGvrD2KT2xVjqK8yhsRMdprzgKIzv+rmvOdZO
	23WhIpenEIYeqCWYrQZxh2Q36zTEygPefsHULSKIufSd3lBrb850z1ceZJs6LLXZVnOOz857sDh
	SRxvvm/KbWX+uxrXbst3ec/Xr15rLlADCyZqxOOmypSkneN6PQiqQeWhB5tH+RUQEFkRnUgcR+7
	kiLeG3iWlj5KZ6w5ynXNRLcuSeWbqs5KIeTDKgEIs9L3Vyhs=
X-Google-Smtp-Source: AGHT+IHIpP2zIofD2/RztNRHMQrjDb5nwc9wRMtQ5NBGW3KQYOaEMrkjR08tK69o00TMmzGNYrv1eQ==
X-Received: by 2002:a17:902:cecb:b0:295:7453:b58b with SMTP id d9443c01a7336-297c0386ba9mr6371575ad.4.1762455597161;
        Thu, 06 Nov 2025 10:59:57 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c92cddsm36647815ad.83.2025.11.06.10.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:59:56 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] fpga: stratix10-soc: add missing header
Date: Thu,  6 Nov 2025 10:59:37 -0800
Message-ID: <20251106185938.6419-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106185938.6419-1-rosenp@gmail.com>
References: <20251106185938.6419-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/sizes.h is needed for SZ_512K.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/fpga/stratix10-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..ab309cbf21c6 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 
 /*
  * FPGA programming requires a higher level of privilege (EL3), per the SoC
-- 
2.51.2


