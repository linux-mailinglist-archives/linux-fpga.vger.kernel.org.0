Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E916D6391
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Apr 2023 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjDDNmY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjDDNmW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 09:42:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3550AA;
        Tue,  4 Apr 2023 06:42:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrTNn3bhJz67mZc;
        Tue,  4 Apr 2023 21:38:17 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 14:42:15 +0100
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
Subject: [PATCH 00/32] Add parents to struct pmu -> dev
Date:   Tue, 4 Apr 2023 14:41:53 +0100
Message-ID: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

These are the low hanging fruit following GregKH's feedback that
all the devices registered via perf_pmu_register() should have parents.

Note that this causes potential ABI breakage.

It may fall in the category of it isn't breakage if no one notices
but I can't be certain of that.  Whilst it is arguable that
no one should be been accessing PMUs except via the event_source
bus, there was documentation suggesting /sys/devices/ for particular
PMUs (because it was a shorter path?)

The first patch is pulled out of the series:
https://lore.kernel.org/linux-cxl/20230327170247.6968-1-Jonathan.Cameron@huawei.com/
[PATCH v3 0/5] CXL 3.0 Performance Monitoring Unit support

In that particular case it is very useful to be able to figure out which
CXL device the PMU device is associated with and looking at it's parents
in the device model as shown with ls -lh /sys/bus/event_sources/devices/
is a very easy way to do this (once it is correctly parented).

Addressing all the other instances of struct pmu not covered by this series
is likely to be a more complex discussion but unlikely to have an affect
on what is proposed here.

Documentation updates deliberately 'fixed' in separate patches before
changing the path to highlight that using /sys/bus/event_source/devices
path is unchanged by this series and that is presumed to be the
most common way these files are accessed.

Jonathan Cameron (32):
  perf: Allow a PMU to have a parent
  perf/hisi-pcie: Assign parent for event_source device
  Documentation: hisi-pmu: Drop reference to /sys/devices path
  perf/hisi-uncore: Assign parents for event_source devices
  Documentation: hns-pmu: Use /sys/bus/event_source/devices paths
  perf/hisi-hns3: Assign parents for event_source device
  perf/amlogic: Assign parents for event_source devices
  perf/arm_cspmu: Assign parents for event_source devices
  Documentation: xgene-pmu: Use /sys/bus/event_source/devices paths
  perf/xgene: Assign parents for event_source devices
  Documentation: thunderx2-pmu:  Use /sys/bus/event_source/devices paths
  perf/thunderx2: Assign parents for event_source devices
  perf/riscv: Assign parents for event_source devices
  Documentation: qcom-pmu: Use /sys/bus/event_source/devices paths
  perf/qcom: Assign parents for event_source devices
  perf/imx_ddr: Assign parents for event_source devices
  perf/arm_pmu: Assign parents for event_source devices
  perf/alibaba_uncore: Assign parents for event_source device
  perf/arm-cci: Assign parents for event_source device
  perf/arm-ccn: Assign parents for event_source device
  perf/arm-cmn: Assign parents for event_source device
  perf/arm-dmc620: Assign parents for event_source device
  perf/arm-dsu: Assign parents for event_source device
  perf/arm-smmuv3: Assign parents for event_source device
  perf/arm-spe: Assign parents for event_source device
  arc: Assign parents for event_source devices
  ARM: imx: Assign parents for mmdc event_source devices
  dmaengine: idxd: Assign parent for event_source device
  fpga: dfl: Assign parent for event_source device
  drivers/nvdimm: Assign parent for event_source device
  Documentation: ABI + trace: hisi_ptt: update paths to bus/event_source
  hwtracing: hisi_ptt: Assign parent for event_source device

 ...i_ptt => sysfs-bus-event_source-devices-hisi_ptt} | 12 ++++++------
 Documentation/admin-guide/perf/hisi-pmu.rst          |  1 -
 Documentation/admin-guide/perf/hns3-pmu.rst          |  8 ++++----
 Documentation/admin-guide/perf/qcom_l2_pmu.rst       |  2 +-
 Documentation/admin-guide/perf/qcom_l3_pmu.rst       |  2 +-
 Documentation/admin-guide/perf/thunderx2-pmu.rst     |  2 +-
 Documentation/admin-guide/perf/xgene-pmu.rst         |  2 +-
 Documentation/trace/hisi-ptt.rst                     |  4 ++--
 MAINTAINERS                                          |  2 +-
 arch/arc/kernel/perf_event.c                         |  1 +
 arch/arm/mach-imx/mmdc.c                             |  1 +
 drivers/dma/idxd/perfmon.c                           |  1 +
 drivers/fpga/dfl-fme-perf.c                          |  1 +
 drivers/hwtracing/ptt/hisi_ptt.c                     |  1 +
 drivers/nvdimm/nd_perf.c                             |  1 +
 drivers/perf/alibaba_uncore_drw_pmu.c                |  1 +
 drivers/perf/amlogic/meson_ddr_pmu_core.c            |  1 +
 drivers/perf/arm-cci.c                               |  1 +
 drivers/perf/arm-ccn.c                               |  1 +
 drivers/perf/arm-cmn.c                               |  1 +
 drivers/perf/arm_cspmu/arm_cspmu.c                   |  1 +
 drivers/perf/arm_dmc620_pmu.c                        |  1 +
 drivers/perf/arm_dsu_pmu.c                           |  1 +
 drivers/perf/arm_pmu_platform.c                      |  1 +
 drivers/perf/arm_smmuv3_pmu.c                        |  1 +
 drivers/perf/arm_spe_pmu.c                           |  1 +
 drivers/perf/fsl_imx8_ddr_perf.c                     |  1 +
 drivers/perf/hisilicon/hisi_pcie_pmu.c               |  1 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c             |  1 +
 drivers/perf/hisilicon/hns3_pmu.c                    |  1 +
 drivers/perf/qcom_l2_pmu.c                           |  1 +
 drivers/perf/qcom_l3_pmu.c                           |  1 +
 drivers/perf/riscv_pmu_legacy.c                      |  1 +
 drivers/perf/riscv_pmu_sbi.c                         |  1 +
 drivers/perf/thunderx2_pmu.c                         |  1 +
 drivers/perf/xgene_pmu.c                             |  1 +
 include/linux/perf_event.h                           |  1 +
 kernel/events/core.c                                 |  1 +
 38 files changed, 46 insertions(+), 18 deletions(-)
 rename Documentation/ABI/testing/{sysfs-devices-hisi_ptt => sysfs-bus-event_source-devices-hisi_ptt} (83%)

-- 
2.37.2

