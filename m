Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F96D63E8
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Apr 2023 15:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjDDNuQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjDDNuI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 09:50:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075D94212;
        Tue,  4 Apr 2023 06:50:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrTYj0nTqz67dbJ;
        Tue,  4 Apr 2023 21:46:01 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 14:49:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>
CC:     <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Li <Frank.li@nxp.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
Subject: [PATCH 15/32] perf/qcom: Assign parents for event_source devices
Date:   Tue, 4 Apr 2023 14:42:08 +0100
Message-ID: <20230404134225.13408-16-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Currently all these devices appear directly under /sys/devices/
Only root busses should appear there, so instead assign the pmu->dev
parents to be the platform devices.

Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/qcom_l2_pmu.c | 1 +
 drivers/perf/qcom_l3_pmu.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index aaca6db7d8f6..b047282cdda8 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -904,6 +904,7 @@ static int l2_cache_pmu_probe(struct platform_device *pdev)
 	l2cache_pmu->pmu = (struct pmu) {
 		/* suffix is instance id for future use with multiple sockets */
 		.name		= "l2cache_0",
+		.parent		= &pdev->dev,
 		.task_ctx_nr    = perf_invalid_context,
 		.pmu_enable	= l2_cache_pmu_enable,
 		.pmu_disable	= l2_cache_pmu_disable,
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 346311a05460..f693a6d9e7e1 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -748,6 +748,7 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	l3pmu->pmu = (struct pmu) {
+		.parent		= &pdev->dev,
 		.task_ctx_nr	= perf_invalid_context,
 
 		.pmu_enable	= qcom_l3_cache__pmu_enable,
-- 
2.37.2

