Return-Path: <linux-fpga+bounces-932-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9BA9C85DA
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Nov 2024 10:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E6C2827DF
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Nov 2024 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C220C1DE2AC;
	Thu, 14 Nov 2024 09:16:37 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B617DFEC
	for <linux-fpga@vger.kernel.org>; Thu, 14 Nov 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575797; cv=none; b=IW0dnvQnf2j2z6GvbaVfBUtp5fbYgHbhLYegwGYrr4BOfjmLj2dI5z75ynuo3Ho4hfpE5kdk+VdDk0tl5YG8OYncGTR0rPhbay4dMbiA23bUzW0n0M1pC0iXi1R3K8hnwNKtsqC+u5lOhf4fbaEUeK/SaAzBCZl1iBrb1xKuRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575797; c=relaxed/simple;
	bh=xeniTugjhVgVjWZoY4ing24naU9GM4qgaprE/ADr2+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kf/+I8K9//pcVAyCiD0hKXLaYEfAKvG3Ep75IUPPh6828cKZZkyZz8afaHaifJcGn47iEosnGP0JZQbH/VuZJpIOCo4lGpVnZsCDL4R6M9irX/l6YVqwqtAb52B/UQGjBDC36/Pc66gYcHgRbv5R01fVLRFSSbhxDA3GPz99Les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id LMF00028;
        Thu, 14 Nov 2024 17:16:28 +0800
Received: from localhost.localdomain (10.94.17.107) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 14 Nov 2024 17:16:27 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <hao.wu@intel.com>, <trix@redhat.com>, <mdf@kernel.org>,
	<yilun.xu@intel.com>, <luwei.kang@intel.com>
CC: <linux-fpga@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] fpga: dfl: fme: Add NULL check in fme_perf_pmu_register
Date: Thu, 14 Nov 2024 17:16:26 +0800
Message-ID: <20241114091626.76822-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024111417162886a22b1ee761c8c76b4aa56fc5d1e2f5
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure,but this
returned value in fme_perf_pmu_register is not checked.
Add NULL check in fme_perf_pmu_register, to handle kernel NULL
pointer dereference error.

Fixes: 724142f8c42a ("fpga: dfl: fme: add performance reporting support")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
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
2.31.1


