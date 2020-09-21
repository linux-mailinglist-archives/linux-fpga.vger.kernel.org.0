Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A46E271D0E
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Sep 2020 10:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIUICS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Sep 2020 04:02:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbgIUICQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BCFD0C7075D59CFE6278;
        Mon, 21 Sep 2020 16:02:14 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:08 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] fpga: dfl: simplify the return expression of fme_perf_pmu_register
Date:   Mon, 21 Sep 2020 16:24:33 +0800
Message-ID: <20200921082433.2591305-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/fpga/dfl-fme-perf.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 531266287eee..e881fbe6d838 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -906,7 +906,6 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
 {
 	struct pmu *pmu = &priv->pmu;
 	char *name;
-	int ret;
 
 	spin_lock_init(&priv->fab_lock);
 
@@ -926,11 +925,7 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
 
 	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
 
-	ret = perf_pmu_register(pmu, name, -1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return perf_pmu_register(pmu, name, -1);
 }
 
 static void fme_perf_pmu_unregister(struct fme_perf_priv *priv)
-- 
2.25.1

