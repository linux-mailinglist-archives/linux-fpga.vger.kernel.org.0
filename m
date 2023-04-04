Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028C6D63E2
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Apr 2023 15:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjDDNt7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjDDNtp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 09:49:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC504C21;
        Tue,  4 Apr 2023 06:49:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrTcp5kBPz67WVs;
        Tue,  4 Apr 2023 21:48:42 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 14:49:28 +0100
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
Subject: [PATCH 14/32] Documentation: qcom-pmu: Use /sys/bus/event_source/devices paths
Date:   Tue, 4 Apr 2023 14:42:07 +0100
Message-ID: <20230404134225.13408-15-Jonathan.Cameron@huawei.com>
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

To allow setting an appropriate parent for the struct pmu device
remove existing references to /sys/devices/ path.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/admin-guide/perf/qcom_l2_pmu.rst | 2 +-
 Documentation/admin-guide/perf/qcom_l3_pmu.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/perf/qcom_l2_pmu.rst b/Documentation/admin-guide/perf/qcom_l2_pmu.rst
index c130178a4a55..c37c6be9b8d8 100644
--- a/Documentation/admin-guide/perf/qcom_l2_pmu.rst
+++ b/Documentation/admin-guide/perf/qcom_l2_pmu.rst
@@ -10,7 +10,7 @@ There is one logical L2 PMU exposed, which aggregates the results from
 the physical PMUs.
 
 The driver provides a description of its available events and configuration
-options in sysfs, see /sys/devices/l2cache_0.
+options in sysfs, see /sys/bus/event_source/devices/l2cache_0.
 
 The "format" directory describes the format of the events.
 
diff --git a/Documentation/admin-guide/perf/qcom_l3_pmu.rst b/Documentation/admin-guide/perf/qcom_l3_pmu.rst
index a3d014a46bfd..a66556b7e985 100644
--- a/Documentation/admin-guide/perf/qcom_l3_pmu.rst
+++ b/Documentation/admin-guide/perf/qcom_l3_pmu.rst
@@ -9,7 +9,7 @@ PMU with device name l3cache_<socket>_<instance>. User space is responsible
 for aggregating across slices.
 
 The driver provides a description of its available events and configuration
-options in sysfs, see /sys/devices/l3cache*. Given that these are uncore PMUs
+options in sysfs, see /sys/bus/event_source/devices/l3cache*. Given that these are uncore PMUs
 the driver also exposes a "cpumask" sysfs attribute which contains a mask
 consisting of one CPU per socket which will be used to handle all the PMU
 events on that socket.
-- 
2.37.2

