Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159A6D63B6
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Apr 2023 15:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjDDNpb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 09:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjDDNpL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 09:45:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F4530E3;
        Tue,  4 Apr 2023 06:44:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrTV52mkjz6J7Bm;
        Tue,  4 Apr 2023 21:42:53 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 14:44:50 +0100
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
Subject: [PATCH 05/32] Documentation: hns-pmu: Use /sys/bus/event_source/devices paths
Date:   Tue, 4 Apr 2023 14:41:58 +0100
Message-ID: <20230404134225.13408-6-Jonathan.Cameron@huawei.com>
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
 Documentation/admin-guide/perf/hns3-pmu.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/perf/hns3-pmu.rst b/Documentation/admin-guide/perf/hns3-pmu.rst
index 75a40846d47f..1195e570f2d6 100644
--- a/Documentation/admin-guide/perf/hns3-pmu.rst
+++ b/Documentation/admin-guide/perf/hns3-pmu.rst
@@ -16,7 +16,7 @@ HNS3 PMU driver
 
 The HNS3 PMU driver registers a perf PMU with the name of its sicl id.::
 
-  /sys/devices/hns3_pmu_sicl_<sicl_id>
+  /sys/bus/event_source/devices/hns3_pmu_sicl_<sicl_id>
 
 PMU driver provides description of available events, filter modes, format,
 identifier and cpumask in sysfs.
@@ -40,9 +40,9 @@ device.
 
 Example usage of checking event code and subevent code::
 
-  $# cat /sys/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_time
+  $# cat /sys/bus/event_source/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_time
   config=0x00204
-  $# cat /sys/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_packet_num
+  $# cat /sys/bus/event_source/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_packet_num
   config=0x10204
 
 Each performance statistic has a pair of events to get two values to
@@ -60,7 +60,7 @@ computation to calculate real performance data is:::
 
 Example usage of checking supported filter mode::
 
-  $# cat /sys/devices/hns3_pmu_sicl_0/filtermode/bw_ssu_rpu_byte_num
+  $# cat /sys/bus/event_source/devices/hns3_pmu_sicl_0/filtermode/bw_ssu_rpu_byte_num
   filter mode supported: global/port/port-tc/func/func-queue/
 
 Example usage of perf::
-- 
2.37.2

