Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BFD2DCD41
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 08:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgLQHz6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 02:55:58 -0500
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:51553
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbgLQHz5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 02:55:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+/5wKwwEsZPs/+ytRoeqNd/MjbKMQ2EbDjBuIUNFZQMOe3cpBhylYt1I4zBk3QFY4OKKDMvfpDdAMsILZqzW4Ea2thKSobYRtK/+TZrZ7Hc+lMdzEQ1ap5JEUlX1qKlYvRQfHv9dFd9XbsZZ+p8ucZBf0Zr7T/MFJaNzfzA5F/UusneVBJRb7byJtruVIuIuV2E3/CPb280TP6hhshAS4hVZIQE1iPHfEN0Xrz3Sg1dRRpZPYxDlZltipOXF0eoZDTk/uqpQpFDVIaIUdxO5GLJ531za25MOiEUuDTvvOHfKM+PybkVS+esqOnqnpeOfFyJ0r1I2WuJLq70o2MmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nETeOAAFKKicfbcJN6b91nKcTCdkHDCEtEvt2tO60SM=;
 b=Tq21+fTj+ir7GpvBARimJ03i458fcl2u6LzZ1iZlWTUVpnGNpfPhNusL4igmc7AQZ2oKBu3fiUCVxAPFQ4Ob5FKVdWd1BFwJeEyc+Q6ljzvlLKZGlxAcMo9Bkq03Pj6aZhRXGUt+pHq+m81sbfZxRcNUi4p80HxbJ11BH1xlLKjf0nkKeS85QDj7G/FQ8xc7vtBTwEleRr76HpLMtTCx7pQ0u2VYsnziQi+YMxxwZk/atLQylP9diHF9lXRQoE/98cuEzx3NqRz1zLyfTk6ndM/g9F6BCS9kvj21c7cMAbh30icOVzGwwxHZpIjWscWa3lZD07LJm4SNAPmIm14jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nETeOAAFKKicfbcJN6b91nKcTCdkHDCEtEvt2tO60SM=;
 b=FMaRIk99r0I88zqyDMsG+RvleAWhMOkZS8devvZ64GPSsH7zxE7zIdvoCrM75GY0S41SuHOfsgkAE3bwY0ckqJECqyvztc4ZL8utHFngJGCDbIxpuYB39t9CS594q2eGoZj08zM/pRMCW2jVI8+7yL3g/lnemvKJaUWst3Lrnbw=
Received: from DM5PR17CA0072.namprd17.prod.outlook.com (2603:10b6:3:13f::34)
 by BN8PR02MB6001.namprd02.prod.outlook.com (2603:10b6:408:b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Thu, 17 Dec
 2020 07:53:11 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::d7) by DM5PR17CA0072.outlook.office365.com
 (2603:10b6:3:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 17 Dec 2020 07:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 07:53:11 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 16 Dec 2020 23:53:03 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 16 Dec 2020 23:53:03 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=42042 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kpo5v-0004cT-0k; Wed, 16 Dec 2020 23:53:03 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 78226600116; Wed, 16 Dec 2020 23:51:18 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <trix@redhat.com>, <mdf@kernel.org>
Subject: [PATCH V2 XRT Alveo 3/6] fpga: xrt: core infrastructure for xrt-lib module
Date:   Wed, 16 Dec 2020 23:50:43 -0800
Message-ID: <20201217075046.28553-4-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217075046.28553-1-sonals@xilinx.com>
References: <20201217075046.28553-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79963dec-37ec-45c5-3039-08d8a260cd04
X-MS-TrafficTypeDiagnostic: BN8PR02MB6001:
X-Microsoft-Antispam-PRVS: <BN8PR02MB600122227E030312FF35F8DCBBC40@BN8PR02MB6001.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mzJyaEnD32fyV01lDjKVlAm9pBsJ2Qi3sGnOBRROkfdQazaeUFC1we4m1Arj0ACXS/goopv/vOUPxyRC/GuPsNNLdYnHB3OY7eJTuH17PoyksAp5dcFAy4HCPhhii5kNdHCu8MqXN713PfDXtlgO8MjJKhKdVIdLEkw0ezb+dJw8Iz3yo/p5Wzaafv0GEncvFbIlb0G2D8Z1wH8jF05b6do8oWr9frlHCUc3CRQOFYqeysRG4H9msx/Lr4Qgu+YZOY7/6lgJoq5mzqf3oSAUsdBv0vY5zgmrat6CTBHtBUtsWFxjrQaK5VA7w1AznXRCITEq8uvdw67eWxRON/D+8sHiXRwA2/xkeauP6AevqqHX9rl14JVZ6Cip9NFCfHuRZlr7IsdYc2X3H8Pwy4LsQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(82740400003)(6916009)(4326008)(30864003)(42186006)(356005)(70206006)(336012)(6666004)(186003)(44832011)(316002)(70586007)(7636003)(54906003)(426003)(8936002)(1076003)(26005)(5660300002)(36756003)(2906002)(2616005)(83380400001)(47076004)(478600001)(82310400003)(6266002)(8676002)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 07:53:11.2329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79963dec-37ec-45c5-3039-08d8a260cd04
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB6001
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Add xrt-lib kernel module infrastructrure code which defines APIs
for working with device nodes, iteration and lookup of platform
devices, common interfaces for platform devices, plumbing of
function call and ioctls between platform devices and parent
partitions.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/fpga/xrt/include/metadata.h          |  184 ++++
 drivers/fpga/xrt/include/parent.h            |  103 ++
 drivers/fpga/xrt/include/partition.h         |   33 +
 drivers/fpga/xrt/include/subdev.h            |  333 ++++++
 drivers/fpga/xrt/lib/subdevs/xrt-partition.c |  261 +++++
 drivers/fpga/xrt/lib/xrt-cdev.c              |  234 ++++
 drivers/fpga/xrt/lib/xrt-main.c              |  270 +++++
 drivers/fpga/xrt/lib/xrt-main.h              |   46 +
 drivers/fpga/xrt/lib/xrt-subdev.c            | 1007 ++++++++++++++++++
 9 files changed, 2471 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/metadata.h
 create mode 100644 drivers/fpga/xrt/include/parent.h
 create mode 100644 drivers/fpga/xrt/include/partition.h
 create mode 100644 drivers/fpga/xrt/include/subdev.h
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-partition.c
 create mode 100644 drivers/fpga/xrt/lib/xrt-cdev.c
 create mode 100644 drivers/fpga/xrt/lib/xrt-main.c
 create mode 100644 drivers/fpga/xrt/lib/xrt-main.h
 create mode 100644 drivers/fpga/xrt/lib/xrt-subdev.c

diff --git a/drivers/fpga/xrt/include/metadata.h b/drivers/fpga/xrt/include/metadata.h
new file mode 100644
index 000000000000..f445bfc279d2
--- /dev/null
+++ b/drivers/fpga/xrt/include/metadata.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Alveo FPGA Test Leaf Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef _XRT_METADATA_H
+#define _XRT_METADATA_H
+
+#include <linux/device.h>
+#include <linux/vmalloc.h>
+#include <linux/uuid.h>
+
+#define PROP_COMPATIBLE "compatible"
+#define PROP_PF_NUM "pcie_physical_function"
+#define PROP_BAR_IDX "pcie_bar_mapping"
+#define PROP_IO_OFFSET "reg"
+#define PROP_INTERRUPTS "interrupts"
+#define PROP_INTERFACE_UUID "interface_uuid"
+#define PROP_LOGIC_UUID "logic_uuid"
+#define PROP_VERSION_MAJOR "firmware_version_major"
+
+#define PROP_HWICAP "axi_hwicap"
+#define PROP_PDI_CONFIG "pdi_config_mem"
+
+#define NODE_ENDPOINTS "addressable_endpoints"
+#define INTERFACES_PATH "/interfaces"
+
+#define NODE_FIRMWARE "firmware"
+#define NODE_INTERFACES "interfaces"
+#define NODE_PARTITION_INFO "partition_info"
+
+#define NODE_FLASH "ep_card_flash_program_00"
+#define NODE_XVC_PUB "ep_debug_bscan_user_00"
+#define NODE_XVC_PRI "ep_debug_bscan_mgmt_00"
+#define NODE_SYSMON "ep_cmp_sysmon_00"
+#define NODE_AF_BLP_CTRL_MGMT "ep_firewall_blp_ctrl_mgmt_00"
+#define NODE_AF_BLP_CTRL_USER "ep_firewall_blp_ctrl_user_00"
+#define NODE_AF_CTRL_MGMT "ep_firewall_ctrl_mgmt_00"
+#define NODE_AF_CTRL_USER "ep_firewall_ctrl_user_00"
+#define NODE_AF_CTRL_DEBUG "ep_firewall_ctrl_debug_00"
+#define NODE_AF_DATA_H2C "ep_firewall_data_h2c_00"
+#define NODE_AF_DATA_C2H "ep_firewall_data_c2h_00"
+#define NODE_AF_DATA_P2P "ep_firewall_data_p2p_00"
+#define NODE_AF_DATA_M2M "ep_firewall_data_m2m_00"
+#define NODE_CMC_REG "ep_cmc_regmap_00"
+#define NODE_CMC_RESET "ep_cmc_reset_00"
+#define NODE_CMC_MUTEX "ep_cmc_mutex_00"
+#define NODE_CMC_FW_MEM "ep_cmc_firmware_mem_00"
+#define NODE_ERT_FW_MEM "ep_ert_firmware_mem_00"
+#define NODE_ERT_CQ_MGMT "ep_ert_command_queue_mgmt_00"
+#define NODE_ERT_CQ_USER "ep_ert_command_queue_user_00"
+#define NODE_MAILBOX_MGMT "ep_mailbox_mgmt_00"
+#define NODE_MAILBOX_USER "ep_mailbox_user_00"
+#define NODE_GATE_PLP "ep_pr_isolate_plp_00"
+#define NODE_GATE_ULP "ep_pr_isolate_ulp_00"
+#define NODE_PCIE_MON "ep_pcie_link_mon_00"
+#define NODE_DDR_CALIB "ep_ddr_mem_calib_00"
+#define NODE_CLK_KERNEL1 "ep_aclk_kernel_00"
+#define NODE_CLK_KERNEL2 "ep_aclk_kernel_01"
+#define NODE_CLK_KERNEL3 "ep_aclk_hbm_00"
+#define NODE_KDMA_CTRL "ep_kdma_ctrl_00"
+#define NODE_FPGA_CONFIG "ep_fpga_configuration_00"
+#define NODE_ERT_SCHED "ep_ert_sched_00"
+#define NODE_XDMA "ep_xdma_00"
+#define NODE_MSIX "ep_msix_00"
+#define NODE_QDMA "ep_qdma_00"
+#define NODE_QDMA4 "ep_qdma4_00"
+#define NODE_STM "ep_stream_traffic_manager_00"
+#define NODE_STM4 "ep_stream_traffic_manager4_00"
+#define NODE_CLK_SHUTDOWN "ep_aclk_shutdown_00"
+#define NODE_ERT_BASE "ep_ert_base_address_00"
+#define NODE_ERT_RESET "ep_ert_reset_00"
+#define NODE_CLKFREQ_K1 "ep_freq_cnt_aclk_kernel_00"
+#define NODE_CLKFREQ_K2 "ep_freq_cnt_aclk_kernel_01"
+#define NODE_CLKFREQ_HBM "ep_freq_cnt_aclk_hbm_00"
+#define NODE_GAPPING "ep_gapping_demand_00"
+#define NODE_UCS_CONTROL_STATUS "ep_ucs_control_status_00"
+#define NODE_P2P "ep_p2p_00"
+#define NODE_REMAP_P2P "ep_remap_p2p_00"
+#define NODE_DDR4_RESET_GATE "ep_ddr_mem_srsr_gate_00"
+#define NODE_ADDR_TRANSLATOR "ep_remap_data_c2h_00"
+#define NODE_MAILBOX_XRT "ep_mailbox_user_to_ert_00"
+#define NODE_PMC_INTR   "ep_pmc_intr_00"
+#define NODE_PMC_MUX    "ep_pmc_mux_00"
+
+/* driver defined endpoints */
+#define NODE_VSEC "drv_ep_vsec_00"
+#define NODE_VSEC_GOLDEN "drv_ep_vsec_golden_00"
+#define NODE_BLP_ROM "drv_ep_blp_rom_00"
+#define NODE_MAILBOX_VSEC "ep_mailbox_vsec_00"
+#define NODE_PLAT_INFO "drv_ep_platform_info_mgmt_00"
+#define NODE_TEST "drv_ep_test_00"
+#define NODE_MGMT_MAIN "drv_ep_mgmt_main_00"
+#define NODE_FLASH_VSEC "drv_ep_card_flash_program_00"
+#define NODE_GOLDEN_VER "drv_ep_golden_ver_00"
+#define NODE_PARTITION_INFO_BLP "partition_info_0"
+#define NODE_PARTITION_INFO_PLP "partition_info_1"
+
+#define NODE_DDR_SRSR "drv_ep_ddr_srsr"
+#define REGMAP_DDR_SRSR "drv_ddr_srsr"
+
+#define PROP_OFFSET "drv_offset"
+#define PROP_CLK_FREQ "drv_clock_frequency"
+#define PROP_CLK_CNT "drv_clock_frequency_counter"
+#define	PROP_VBNV "vbnv"
+#define	PROP_VROM "vrom"
+#define PROP_PARTITION_LEVEL "partition_level"
+
+struct xrt_md_endpoint {
+	const char	*ep_name;
+	u32		bar;
+	long		bar_off;
+	ulong		size;
+	char		*regmap;
+	char		*regmap_ver;
+};
+
+/* Note: res_id is defined by leaf driver and must start with 0. */
+struct xrt_iores_map {
+	char		*res_name;
+	int		res_id;
+};
+
+static inline int xrt_md_res_name2id(const struct xrt_iores_map *res_map,
+	int entry_num, const char *res_name)
+{
+	int i;
+
+	BUG_ON(res_name == NULL);
+	for (i = 0; i < entry_num; i++) {
+		if (!strcmp(res_name, res_map->res_name))
+			return res_map->res_id;
+		res_map++;
+	}
+	return -1;
+}
+
+static inline const char *
+xrt_md_res_id2name(const struct xrt_iores_map *res_map, int entry_num, int id)
+{
+	int i;
+
+	BUG_ON(id > entry_num);
+	for (i = 0; i < entry_num; i++) {
+		if (res_map->res_id == id)
+			return res_map->res_name;
+		res_map++;
+	}
+	return NULL;
+}
+
+long xrt_md_size(struct device *dev, const char *blob);
+int xrt_md_create(struct device *dev, char **blob);
+int xrt_md_add_endpoint(struct device *dev, char *blob,
+	struct xrt_md_endpoint *ep);
+int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
+	char *regmap_name);
+int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
+	const char *regmap_name, const char *prop, const void **val, int *size);
+int xrt_md_set_prop(struct device *dev, char *blob, const char *ep_name,
+	const char *regmap_name, const char *prop, const void *val, int size);
+int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
+	const char *ep_name, const char *regmap_name, const char *new_ep_name);
+int xrt_md_copy_all_eps(struct device *dev, char  *blob, const char *src_blob);
+int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
+	const char *ep_name,  const char *regmap_name,
+	char **next_ep, char **next_regmap);
+int xrt_md_get_compatible_epname(struct device *dev, const char *blob,
+	const char *regmap_name, const char **ep_name);
+int xrt_md_get_epname_pointer(struct device *dev, const char *blob,
+	const char *ep_name, const char *regmap_name, const char **epname);
+void xrt_md_pack(struct device *dev, char *blob);
+char *xrt_md_dup(struct device *dev, const char *blob);
+int xrt_md_get_intf_uuids(struct device *dev, const char *blob,
+	u32 *num_uuids, uuid_t *intf_uuids);
+int xrt_md_check_uuids(struct device *dev, const char *blob, char *subset_blob);
+int xrt_md_uuid_strtoid(struct device *dev, const char *uuidstr, uuid_t *uuid);
+
+#endif
diff --git a/drivers/fpga/xrt/include/parent.h b/drivers/fpga/xrt/include/parent.h
new file mode 100644
index 000000000000..8e921a78ea2d
--- /dev/null
+++ b/drivers/fpga/xrt/include/parent.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_PARENT_H_
+#define	_XRT_PARENT_H_
+
+#include "subdev.h"
+#include "partition.h"
+
+/*
+ * Parent IOCTL calls.
+ */
+enum xrt_parent_ioctl_cmd {
+	/* Leaf actions. */
+	XRT_PARENT_GET_LEAF = 0,
+	XRT_PARENT_PUT_LEAF,
+	XRT_PARENT_GET_LEAF_HOLDERS,
+
+	/* Partition actions. */
+	XRT_PARENT_CREATE_PARTITION,
+	XRT_PARENT_REMOVE_PARTITION,
+	XRT_PARENT_LOOKUP_PARTITION,
+	XRT_PARENT_WAIT_PARTITION_BRINGUP,
+
+	/* Event actions. */
+	XRT_PARENT_ADD_EVENT_CB,
+	XRT_PARENT_REMOVE_EVENT_CB,
+	XRT_PARENT_ASYNC_BOARDCAST_EVENT,
+
+	/* Device info. */
+	XRT_PARENT_GET_RESOURCE,
+	XRT_PARENT_GET_ID,
+
+	/* Misc. */
+	XRT_PARENT_HOT_RESET,
+	XRT_PARENT_HWMON,
+};
+
+struct xrt_parent_ioctl_get_leaf {
+	struct platform_device *xpigl_pdev; /* caller's pdev */
+	xrt_subdev_match_t xpigl_match_cb;
+	void *xpigl_match_arg;
+	struct platform_device *xpigl_leaf; /* target leaf pdev */
+};
+
+struct xrt_parent_ioctl_put_leaf {
+	struct platform_device *xpipl_pdev; /* caller's pdev */
+	struct platform_device *xpipl_leaf; /* target's pdev */
+};
+
+struct xrt_parent_ioctl_lookup_partition {
+	struct platform_device *xpilp_pdev; /* caller's pdev */
+	xrt_subdev_match_t xpilp_match_cb;
+	void *xpilp_match_arg;
+	int xpilp_part_inst;
+};
+
+struct xrt_parent_ioctl_evt_cb {
+	struct platform_device *xevt_pdev; /* caller's pdev */
+	xrt_subdev_match_t xevt_match_cb;
+	void *xevt_match_arg;
+	xrt_event_cb_t xevt_cb;
+	void *xevt_hdl;
+};
+
+struct xrt_parent_ioctl_async_broadcast_evt {
+	struct platform_device *xaevt_pdev; /* caller's pdev */
+	enum xrt_events xaevt_event;
+	xrt_async_broadcast_event_cb_t xaevt_cb;
+	void *xaevt_arg;
+};
+
+struct xrt_parent_ioctl_get_holders {
+	struct platform_device *xpigh_pdev; /* caller's pdev */
+	char *xpigh_holder_buf;
+	size_t xpigh_holder_buf_len;
+};
+
+struct xrt_parent_ioctl_get_res {
+	struct resource *xpigr_res;
+};
+
+struct xrt_parent_ioctl_get_id {
+	unsigned short  xpigi_vendor_id;
+	unsigned short  xpigi_device_id;
+	unsigned short  xpigi_sub_vendor_id;
+	unsigned short  xpigi_sub_device_id;
+};
+
+struct xrt_parent_ioctl_hwmon {
+	bool xpih_register;
+	const char *xpih_name;
+	void *xpih_drvdata;
+	const struct attribute_group **xpih_groups;
+	struct device *xpih_hwmon_dev;
+};
+
+#endif	/* _XRT_PARENT_H_ */
diff --git a/drivers/fpga/xrt/include/partition.h b/drivers/fpga/xrt/include/partition.h
new file mode 100644
index 000000000000..b4f4ea639234
--- /dev/null
+++ b/drivers/fpga/xrt/include/partition.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_PARTITION_H_
+#define	_XRT_PARTITION_H_
+
+#include "subdev.h"
+
+/*
+ * Partition driver IOCTL calls.
+ */
+enum xrt_partition_ioctl_cmd {
+	XRT_PARTITION_GET_LEAF = 0,
+	XRT_PARTITION_PUT_LEAF,
+	XRT_PARTITION_INIT_CHILDREN,
+	XRT_PARTITION_FINI_CHILDREN,
+	XRT_PARTITION_EVENT,
+};
+
+struct xrt_partition_ioctl_event {
+	enum xrt_events xpie_evt;
+	struct xrt_parent_ioctl_evt_cb *xpie_cb;
+};
+
+extern int xrt_subdev_parent_ioctl(struct platform_device *pdev,
+	u32 cmd, void *arg);
+
+#endif	/* _XRT_PARTITION_H_ */
diff --git a/drivers/fpga/xrt/include/subdev.h b/drivers/fpga/xrt/include/subdev.h
new file mode 100644
index 000000000000..65ecbd9c596b
--- /dev/null
+++ b/drivers/fpga/xrt/include/subdev.h
@@ -0,0 +1,333 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_SUBDEV_H_
+#define	_XRT_SUBDEV_H_
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/libfdt_env.h>
+#include "libfdt.h"
+
+/*
+ * Every subdev driver should have an ID for others to refer to it.
+ * There can be unlimited number of instances of a subdev driver. A
+ * <subdev_id, subdev_instance> tuple should be a unique identification of
+ * a specific instance of a subdev driver.
+ * NOTE: PLEASE do not change the order of IDs. Sub devices in the same
+ * partition are initialized by this order.
+ */
+enum xrt_subdev_id {
+	XRT_SUBDEV_PART = 0,
+	XRT_SUBDEV_VSEC,
+	XRT_SUBDEV_VSEC_GOLDEN,
+	XRT_SUBDEV_GPIO,
+	XRT_SUBDEV_AXIGATE,
+	XRT_SUBDEV_ICAP,
+	XRT_SUBDEV_TEST,
+	XRT_SUBDEV_MGMT_MAIN,
+	XRT_SUBDEV_QSPI,
+	XRT_SUBDEV_MAILBOX,
+	XRT_SUBDEV_CMC,
+	XRT_SUBDEV_CALIB,
+	XRT_SUBDEV_CLKFREQ,
+	XRT_SUBDEV_CLOCK,
+	XRT_SUBDEV_SRSR,
+	XRT_SUBDEV_UCS,
+	XRT_SUBDEV_NUM,
+};
+
+/*
+ * If populated by subdev driver, parent will handle the mechanics of
+ * char device (un)registration.
+ */
+enum xrt_subdev_file_mode {
+	// Infra create cdev, default file name
+	XRT_SUBDEV_FILE_DEFAULT = 0,
+	// Infra create cdev, need to encode inst num in file name
+	XRT_SUBDEV_FILE_MULTI_INST,
+	// No auto creation of cdev by infra, leaf handles it by itself
+	XRT_SUBDEV_FILE_NO_AUTO,
+};
+struct xrt_subdev_file_ops {
+	const struct file_operations xsf_ops;
+	dev_t xsf_dev_t;
+	const char *xsf_dev_name;
+	enum xrt_subdev_file_mode xsf_mode;
+};
+
+/*
+ * Subdev driver callbacks populated by subdev driver.
+ */
+struct xrt_subdev_drv_ops {
+	/*
+	 * Per driver module callback. Don't take any arguments.
+	 * If defined these are called as part of driver (un)registration.
+	 */
+	int (*xsd_post_init)(void);
+	void (*xsd_pre_exit)(void);
+
+	/*
+	 * Per driver instance callback. The pdev points to the instance.
+	 * If defined these are called by other leaf drivers.
+	 * Note that root driver may call into xsd_ioctl of a partition driver.
+	 */
+	int (*xsd_ioctl)(struct platform_device *pdev, u32 cmd, void *arg);
+};
+
+/*
+ * Defined and populated by subdev driver, exported as driver_data in
+ * struct platform_device_id.
+ */
+struct xrt_subdev_drvdata {
+	struct xrt_subdev_file_ops xsd_file_ops;
+	struct xrt_subdev_drv_ops xsd_dev_ops;
+};
+
+/*
+ * Partially initialized by parent driver, then, passed in as subdev driver's
+ * platform data when creating subdev driver instance by calling platform
+ * device register API (platform_device_register_data() or the likes).
+ *
+ * Once device register API returns, platform driver framework makes a copy of
+ * this buffer and maintains its life cycle. The content of the buffer is
+ * completely owned by subdev driver.
+ *
+ * Thus, parent driver should be very careful when it touches this buffer
+ * again once it's handed over to subdev driver. And the data structure
+ * should not contain pointers pointing to buffers that is managed by
+ * other or parent drivers since it could have been freed before platform
+ * data buffer is freed by platform driver framework.
+ */
+typedef int (*xrt_subdev_parent_cb_t)(struct device *, void *, u32, void *);
+struct xrt_subdev_platdata {
+	/*
+	 * Per driver instance callback. The pdev points to the instance.
+	 * Should always be defined for subdev driver to call into its parent.
+	 */
+	xrt_subdev_parent_cb_t xsp_parent_cb;
+	void *xsp_parent_cb_arg;
+
+	/* Something to associate w/ root for msg printing. */
+	const char *xsp_root_name;
+
+	/*
+	 * Char dev support for this subdev instance.
+	 * Initialized by subdev driver.
+	 */
+	struct cdev xsp_cdev;
+	struct device *xsp_sysdev;
+	struct mutex xsp_devnode_lock;
+	struct completion xsp_devnode_comp;
+	int xsp_devnode_ref;
+	bool xsp_devnode_online;
+	bool xsp_devnode_excl;
+
+	/*
+	 * Subdev driver specific init data. The buffer should be embedded
+	 * in this data structure buffer after dtb, so that it can be freed
+	 * together with platform data.
+	 */
+	loff_t xsp_priv_off; /* Offset into this platform data buffer. */
+	size_t xsp_priv_len;
+
+	/*
+	 * Populated by parent driver to describe the device tree for
+	 * the subdev driver to handle. Should always be last one since it's
+	 * of variable length.
+	 */
+	char xsp_dtb[sizeof(struct fdt_header)];
+};
+
+/*
+ * this struct define the endpoints belong to the same subdevice
+ */
+struct xrt_subdev_ep_names {
+	const char *ep_name;
+	const char *regmap_name;
+};
+
+struct xrt_subdev_endpoints {
+	struct xrt_subdev_ep_names *xse_names;
+	/* minimum number of endpoints to support the subdevice */
+	u32 xse_min_ep;
+};
+
+/*
+ * It manages a list of xrt_subdevs for root and partition drivers.
+ */
+struct xrt_subdev_pool {
+	struct list_head xpool_dev_list;
+	struct device *xpool_owner;
+	struct mutex xpool_lock;
+	bool xpool_closing;
+};
+
+typedef bool (*xrt_subdev_match_t)(enum xrt_subdev_id,
+	struct platform_device *, void *);
+#define	XRT_SUBDEV_MATCH_PREV	((xrt_subdev_match_t)-1)
+#define	XRT_SUBDEV_MATCH_NEXT	((xrt_subdev_match_t)-2)
+
+/* All subdev drivers should use below common routines to print out msg. */
+#define	DEV(pdev)	(&(pdev)->dev)
+#define	DEV_PDATA(pdev)					\
+	((struct xrt_subdev_platdata *)dev_get_platdata(DEV(pdev)))
+#define	DEV_DRVDATA(pdev)				\
+	((struct xrt_subdev_drvdata *)			\
+	platform_get_device_id(pdev)->driver_data)
+#define	FMT_PRT(prt_fn, pdev, fmt, args...)		\
+	prt_fn(DEV(pdev), "%s %s: "fmt,			\
+	DEV_PDATA(pdev)->xsp_root_name, __func__, ##args)
+#define xrt_err(pdev, fmt, args...) FMT_PRT(dev_err, pdev, fmt, ##args)
+#define xrt_warn(pdev, fmt, args...) FMT_PRT(dev_warn, pdev, fmt, ##args)
+#define xrt_info(pdev, fmt, args...) FMT_PRT(dev_info, pdev, fmt, ##args)
+#define xrt_dbg(pdev, fmt, args...) FMT_PRT(dev_dbg, pdev, fmt, ##args)
+
+/*
+ * Event notification.
+ */
+enum xrt_events {
+	XRT_EVENT_TEST = 0, // for testing
+	/*
+	 * Events related to specific subdev
+	 * Callback arg: struct xrt_event_arg_subdev
+	 */
+	XRT_EVENT_POST_CREATION,
+	XRT_EVENT_PRE_REMOVAL,
+	/*
+	 * Events related to change of the whole board
+	 * Callback arg: <none>
+	 */
+	XRT_EVENT_PRE_HOT_RESET,
+	XRT_EVENT_POST_HOT_RESET,
+	XRT_EVENT_PRE_GATE_CLOSE,
+	XRT_EVENT_POST_GATE_OPEN,
+	XRT_EVENT_POST_ATTACH,
+	XRT_EVENT_PRE_DETACH,
+};
+
+typedef int (*xrt_event_cb_t)(struct platform_device *pdev,
+	enum xrt_events evt, void *arg);
+typedef void (*xrt_async_broadcast_event_cb_t)(struct platform_device *pdev,
+	enum xrt_events evt, void *arg, bool success);
+
+struct xrt_event_arg_subdev {
+	enum xrt_subdev_id xevt_subdev_id;
+	int xevt_subdev_instance;
+};
+
+/*
+ * Flags in return value from event callback.
+ */
+/* Done with event handling, continue waiting for the next one */
+#define	XRT_EVENT_CB_CONTINUE	0x0
+/* Done with event handling, stop waiting for the next one */
+#define	XRT_EVENT_CB_STOP	0x1
+/* Error processing event */
+#define	XRT_EVENT_CB_ERR	0x2
+
+/*
+ * Subdev pool API for root and partition drivers only.
+ */
+extern void xrt_subdev_pool_init(struct device *dev,
+	struct xrt_subdev_pool *spool);
+extern int xrt_subdev_pool_fini(struct xrt_subdev_pool *spool);
+extern int xrt_subdev_pool_get(struct xrt_subdev_pool *spool,
+	xrt_subdev_match_t match, void *arg, struct device *holder_dev,
+	struct platform_device **pdevp);
+extern int xrt_subdev_pool_put(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, struct device *holder_dev);
+extern int xrt_subdev_pool_add(struct xrt_subdev_pool *spool,
+	enum xrt_subdev_id id, xrt_subdev_parent_cb_t pcb,
+	void *pcb_arg, char *dtb);
+extern int xrt_subdev_pool_del(struct xrt_subdev_pool *spool,
+	enum xrt_subdev_id id, int instance);
+extern int xrt_subdev_pool_event(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, xrt_subdev_match_t match, void *arg,
+	xrt_event_cb_t xevt_cb, enum xrt_events evt);
+extern ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, char *buf, size_t len);
+/*
+ * For leaf drivers.
+ */
+extern bool xrt_subdev_has_epname(struct platform_device *pdev, const char *nm);
+extern struct platform_device *xrt_subdev_get_leaf(
+	struct platform_device *pdev, xrt_subdev_match_t cb, void *arg);
+extern struct platform_device *xrt_subdev_get_leaf_by_id(
+	struct platform_device *pdev, enum xrt_subdev_id id, int instance);
+extern struct platform_device *xrt_subdev_get_leaf_by_epname(
+	struct platform_device *pdev, const char *name);
+extern int xrt_subdev_put_leaf(struct platform_device *pdev,
+	struct platform_device *leaf);
+extern int xrt_subdev_create_partition(struct platform_device *pdev,
+	char *dtb);
+extern int xrt_subdev_destroy_partition(struct platform_device *pdev,
+	int instance);
+extern int xrt_subdev_lookup_partition(
+	struct platform_device *pdev, xrt_subdev_match_t cb, void *arg);
+extern int xrt_subdev_wait_for_partition_bringup(struct platform_device *pdev);
+extern void *xrt_subdev_add_event_cb(struct platform_device *pdev,
+	xrt_subdev_match_t match, void *match_arg, xrt_event_cb_t cb);
+extern void xrt_subdev_remove_event_cb(
+	struct platform_device *pdev, void *hdl);
+extern int xrt_subdev_ioctl(struct platform_device *tgt, u32 cmd, void *arg);
+extern int xrt_subdev_broadcast_event(struct platform_device *pdev,
+	enum xrt_events evt);
+extern int xrt_subdev_broadcast_event_async(struct platform_device *pdev,
+	enum xrt_events evt, xrt_async_broadcast_event_cb_t cb, void *arg);
+extern void xrt_subdev_hot_reset(struct platform_device *pdev);
+extern void xrt_subdev_get_barres(struct platform_device *pdev,
+	struct resource **res, uint bar_idx);
+extern void xrt_subdev_get_parent_id(struct platform_device *pdev,
+	unsigned short *vendor, unsigned short *device,
+	unsigned short *subvendor, unsigned short *subdevice);
+extern struct device *xrt_subdev_register_hwmon(struct platform_device *pdev,
+	const char *name, void *drvdata, const struct attribute_group **grps);
+extern void xrt_subdev_unregister_hwmon(struct platform_device *pdev,
+	struct device *hwmon);
+
+extern int xrt_subdev_register_external_driver(enum xrt_subdev_id id,
+	struct platform_driver *drv, struct xrt_subdev_endpoints *eps);
+extern void xrt_subdev_unregister_external_driver(enum xrt_subdev_id id);
+
+/*
+ * Char dev APIs.
+ */
+static inline bool xrt_devnode_enabled(struct xrt_subdev_drvdata *drvdata)
+{
+	return drvdata && drvdata->xsd_file_ops.xsf_ops.open != NULL;
+}
+extern int xrt_devnode_create(struct platform_device *pdev,
+	const char *file_name, const char *inst_name);
+extern int xrt_devnode_destroy(struct platform_device *pdev);
+extern struct platform_device *xrt_devnode_open_excl(struct inode *inode);
+extern struct platform_device *xrt_devnode_open(struct inode *inode);
+extern void xrt_devnode_close(struct inode *inode);
+
+/* Helpers. */
+static inline void xrt_memcpy_fromio(void *buf, void __iomem *iomem, u32 size)
+{
+	int i;
+
+	BUG_ON(size & 0x3);
+	for (i = 0; i < size / 4; i++)
+		((u32 *)buf)[i] = ioread32((char *)(iomem) + sizeof(u32) * i);
+}
+static inline void xrt_memcpy_toio(void __iomem *iomem, void *buf, u32 size)
+{
+	int i;
+
+	BUG_ON(size & 0x3);
+	for (i = 0; i < size / 4; i++)
+		iowrite32(((u32 *)buf)[i], ((char *)(iomem) + sizeof(u32) * i));
+}
+
+#endif	/* _XRT_SUBDEV_H_ */
diff --git a/drivers/fpga/xrt/lib/subdevs/xrt-partition.c b/drivers/fpga/xrt/lib/subdevs/xrt-partition.c
new file mode 100644
index 000000000000..17acec11993b
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdevs/xrt-partition.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Partition Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include "subdev.h"
+#include "parent.h"
+#include "partition.h"
+#include "metadata.h"
+#include "../xrt-main.h"
+
+#define	XRT_PART "xrt_partition"
+
+struct xrt_partition {
+	struct platform_device *pdev;
+	struct xrt_subdev_pool leaves;
+	bool leaves_created;
+	struct mutex lock;
+};
+
+static int xrt_part_parent_cb(struct device *dev, void *parg,
+	u32 cmd, void *arg)
+{
+	int rc;
+	struct platform_device *pdev =
+		container_of(dev, struct platform_device, dev);
+	struct xrt_partition *xp = (struct xrt_partition *)parg;
+
+	switch (cmd) {
+	case XRT_PARENT_GET_LEAF_HOLDERS: {
+		struct xrt_parent_ioctl_get_holders *holders =
+			(struct xrt_parent_ioctl_get_holders *)arg;
+		rc = xrt_subdev_pool_get_holders(&xp->leaves,
+			holders->xpigh_pdev, holders->xpigh_holder_buf,
+			holders->xpigh_holder_buf_len);
+		break;
+	}
+	default:
+		/* Forward parent call to root. */
+		rc = xrt_subdev_parent_ioctl(pdev, cmd, arg);
+		break;
+	}
+
+	return rc;
+}
+
+static int xrt_part_create_leaves(struct xrt_partition *xp)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xp->pdev);
+	enum xrt_subdev_id did;
+	struct xrt_subdev_endpoints *eps = NULL;
+	int ep_count = 0, i, ret = 0, failed = 0;
+	long mlen;
+	char *dtb, *part_dtb = NULL;
+	const char *ep_name;
+
+
+	mutex_lock(&xp->lock);
+
+	if (xp->leaves_created) {
+		mutex_unlock(&xp->lock);
+		return -EEXIST;
+	}
+
+	xrt_info(xp->pdev, "bringing up leaves...");
+
+	/* Create all leaves based on dtb. */
+	if (!pdata)
+		goto bail;
+
+	mlen = xrt_md_size(DEV(xp->pdev), pdata->xsp_dtb);
+	if (mlen <= 0) {
+		xrt_err(xp->pdev, "invalid dtb, len %ld", mlen);
+		goto bail;
+	}
+
+	part_dtb = vmalloc(mlen);
+	if (!part_dtb)
+		goto bail;
+
+	memcpy(part_dtb, pdata->xsp_dtb, mlen);
+	for (did = 0; did < XRT_SUBDEV_NUM;) {
+		eps = eps ? eps + 1 : xrt_drv_get_endpoints(did);
+		if (!eps || !eps->xse_names) {
+			did++;
+			eps = NULL;
+			continue;
+		}
+		ret = xrt_md_create(DEV(xp->pdev), &dtb);
+		if (ret) {
+			xrt_err(xp->pdev, "create md failed, drv %s",
+				xrt_drv_name(did));
+			failed++;
+			continue;
+		}
+		for (i = 0; eps->xse_names[i].ep_name ||
+		    eps->xse_names[i].regmap_name; i++) {
+			if (!eps->xse_names[i].ep_name) {
+				ret = xrt_md_get_compatible_epname(
+					DEV(xp->pdev), part_dtb,
+					eps->xse_names[i].regmap_name,
+					&ep_name);
+				if (ret)
+					continue;
+			} else
+				ep_name = (char *)eps->xse_names[i].ep_name;
+			ret = xrt_md_copy_endpoint(DEV(xp->pdev),
+				dtb, part_dtb, ep_name,
+				(char *)eps->xse_names[i].regmap_name, NULL);
+			if (ret)
+				continue;
+			xrt_md_del_endpoint(DEV(xp->pdev), part_dtb, ep_name,
+				(char *)eps->xse_names[i].regmap_name);
+			ep_count++;
+		}
+		if (ep_count >= eps->xse_min_ep) {
+			ret = xrt_subdev_pool_add(&xp->leaves, did,
+				xrt_part_parent_cb, xp, dtb);
+			eps = NULL;
+			if (ret < 0) {
+				failed++;
+				xrt_err(xp->pdev, "failed to create %s: %d",
+					xrt_drv_name(did), ret);
+			}
+		} else if (ep_count > 0) {
+			xrt_md_copy_all_eps(DEV(xp->pdev), part_dtb, dtb);
+		}
+		vfree(dtb);
+		ep_count = 0;
+	}
+
+	xp->leaves_created = true;
+
+bail:
+	mutex_unlock(&xp->lock);
+
+	if (part_dtb)
+		vfree(part_dtb);
+
+	return failed == 0 ? 0 : -ECHILD;
+}
+
+static int xrt_part_remove_leaves(struct xrt_partition *xp)
+{
+	int rc;
+
+	mutex_lock(&xp->lock);
+
+	if (!xp->leaves_created) {
+		mutex_unlock(&xp->lock);
+		return 0;
+	}
+
+	xrt_info(xp->pdev, "tearing down leaves...");
+	rc = xrt_subdev_pool_fini(&xp->leaves);
+	xp->leaves_created = false;
+
+	mutex_unlock(&xp->lock);
+
+	return rc;
+}
+
+static int xrt_part_probe(struct platform_device *pdev)
+{
+	struct xrt_partition *xp;
+
+	xrt_info(pdev, "probing...");
+
+	xp = devm_kzalloc(&pdev->dev, sizeof(*xp), GFP_KERNEL);
+	if (!xp)
+		return -ENOMEM;
+
+	xp->pdev = pdev;
+	mutex_init(&xp->lock);
+	xrt_subdev_pool_init(DEV(pdev), &xp->leaves);
+	platform_set_drvdata(pdev, xp);
+
+	return 0;
+}
+
+static int xrt_part_remove(struct platform_device *pdev)
+{
+	struct xrt_partition *xp = platform_get_drvdata(pdev);
+
+	xrt_info(pdev, "leaving...");
+	return xrt_part_remove_leaves(xp);
+}
+
+static int xrt_part_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	int rc = 0;
+	struct xrt_partition *xp = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_PARTITION_GET_LEAF: {
+		struct xrt_parent_ioctl_get_leaf *get_leaf =
+			(struct xrt_parent_ioctl_get_leaf *)arg;
+
+		rc = xrt_subdev_pool_get(&xp->leaves, get_leaf->xpigl_match_cb,
+			get_leaf->xpigl_match_arg, DEV(get_leaf->xpigl_pdev),
+			&get_leaf->xpigl_leaf);
+		break;
+	}
+	case XRT_PARTITION_PUT_LEAF: {
+		struct xrt_parent_ioctl_put_leaf *put_leaf =
+			(struct xrt_parent_ioctl_put_leaf *)arg;
+
+		rc = xrt_subdev_pool_put(&xp->leaves, put_leaf->xpipl_leaf,
+			DEV(put_leaf->xpipl_pdev));
+		break;
+	}
+	case XRT_PARTITION_INIT_CHILDREN:
+		rc = xrt_part_create_leaves(xp);
+		break;
+	case XRT_PARTITION_FINI_CHILDREN:
+		rc = xrt_part_remove_leaves(xp);
+		break;
+	case XRT_PARTITION_EVENT: {
+		struct xrt_partition_ioctl_event *evt =
+			(struct xrt_partition_ioctl_event *)arg;
+		struct xrt_parent_ioctl_evt_cb *cb = evt->xpie_cb;
+
+		rc = xrt_subdev_pool_event(&xp->leaves, cb->xevt_pdev,
+			cb->xevt_match_cb, cb->xevt_match_arg, cb->xevt_cb,
+			evt->xpie_evt);
+		break;
+	}
+	default:
+		xrt_err(pdev, "unknown IOCTL cmd %d", cmd);
+		rc = -EINVAL;
+		break;
+	}
+	return rc;
+}
+
+struct xrt_subdev_drvdata xrt_part_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_part_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_part_id_table[] = {
+	{ XRT_PART, (kernel_ulong_t)&xrt_part_data },
+	{ },
+};
+
+struct platform_driver xrt_partition_driver = {
+	.driver	= {
+		.name    = XRT_PART,
+	},
+	.probe   = xrt_part_probe,
+	.remove  = xrt_part_remove,
+	.id_table = xrt_part_id_table,
+};
diff --git a/drivers/fpga/xrt/lib/xrt-cdev.c b/drivers/fpga/xrt/lib/xrt-cdev.c
new file mode 100644
index 000000000000..6dd3907699eb
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xrt-cdev.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA device node helper functions.
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include "subdev.h"
+
+extern struct class *xrt_class;
+
+#define	XRT_CDEV_DIR		"xfpga"
+#define	INODE2PDATA(inode)	\
+	container_of((inode)->i_cdev, struct xrt_subdev_platdata, xsp_cdev)
+#define	INODE2PDEV(inode)	\
+	to_platform_device(kobj_to_dev((inode)->i_cdev->kobj.parent))
+#define	CDEV_NAME(sysdev)	(strchr((sysdev)->kobj.name, '!') + 1)
+
+/* Allow it to be accessed from cdev. */
+static void xrt_devnode_allowed(struct platform_device *pdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+
+	/* Allow new opens. */
+	mutex_lock(&pdata->xsp_devnode_lock);
+	pdata->xsp_devnode_online = true;
+	mutex_unlock(&pdata->xsp_devnode_lock);
+}
+
+/* Turn off access from cdev and wait for all existing user to go away. */
+static int xrt_devnode_disallowed(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	/* Prevent new opens. */
+	pdata->xsp_devnode_online = false;
+	/* Wait for existing user to close. */
+	while (!ret && pdata->xsp_devnode_ref) {
+		int rc;
+
+		mutex_unlock(&pdata->xsp_devnode_lock);
+		rc = wait_for_completion_killable(&pdata->xsp_devnode_comp);
+		mutex_lock(&pdata->xsp_devnode_lock);
+
+		if (rc == -ERESTARTSYS) {
+			/* Restore online state. */
+			pdata->xsp_devnode_online = true;
+			xrt_err(pdev, "%s is in use, ref=%d",
+				CDEV_NAME(pdata->xsp_sysdev),
+				pdata->xsp_devnode_ref);
+			ret = -EBUSY;
+		}
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	return ret;
+}
+
+static struct platform_device *
+__xrt_devnode_open(struct inode *inode, bool excl)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct platform_device *pdev = INODE2PDEV(inode);
+	bool opened = false;
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	if (pdata->xsp_devnode_online) {
+		if (excl && pdata->xsp_devnode_ref) {
+			xrt_err(pdev, "%s has already been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else if (!excl && pdata->xsp_devnode_excl) {
+			xrt_err(pdev, "%s has been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else {
+			pdata->xsp_devnode_ref++;
+			pdata->xsp_devnode_excl = excl;
+			opened = true;
+			xrt_info(pdev, "opened %s, ref=%d",
+				CDEV_NAME(pdata->xsp_sysdev),
+				pdata->xsp_devnode_ref);
+		}
+	} else {
+		xrt_err(pdev, "%s is offline", CDEV_NAME(pdata->xsp_sysdev));
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	return opened ? pdev : NULL;
+}
+
+struct platform_device *
+xrt_devnode_open_excl(struct inode *inode)
+{
+	return __xrt_devnode_open(inode, true);
+}
+
+struct platform_device *
+xrt_devnode_open(struct inode *inode)
+{
+	return __xrt_devnode_open(inode, false);
+}
+EXPORT_SYMBOL_GPL(xrt_devnode_open);
+
+void xrt_devnode_close(struct inode *inode)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct platform_device *pdev = INODE2PDEV(inode);
+	bool notify = false;
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	pdata->xsp_devnode_ref--;
+	if (pdata->xsp_devnode_ref == 0) {
+		pdata->xsp_devnode_excl = false;
+		notify = true;
+	}
+	if (notify) {
+		xrt_info(pdev, "closed %s, ref=%d",
+			CDEV_NAME(pdata->xsp_sysdev), pdata->xsp_devnode_ref);
+	} else {
+		xrt_info(pdev, "closed %s, notifying waiter",
+			CDEV_NAME(pdata->xsp_sysdev));
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	if (notify)
+		complete(&pdata->xsp_devnode_comp);
+}
+EXPORT_SYMBOL_GPL(xrt_devnode_close);
+
+static inline enum xrt_subdev_file_mode
+devnode_mode(struct xrt_subdev_drvdata *drvdata)
+{
+	return drvdata->xsd_file_ops.xsf_mode;
+}
+
+int xrt_devnode_create(struct platform_device *pdev, const char *file_name,
+	const char *inst_name)
+{
+	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
+	struct xrt_subdev_file_ops *fops = &drvdata->xsd_file_ops;
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	struct cdev *cdevp;
+	struct device *sysdev;
+	int ret = 0;
+	char fname[256];
+
+	BUG_ON(fops->xsf_dev_t == (dev_t)-1);
+
+	mutex_init(&pdata->xsp_devnode_lock);
+	init_completion(&pdata->xsp_devnode_comp);
+
+	cdevp = &DEV_PDATA(pdev)->xsp_cdev;
+	cdev_init(cdevp, &fops->xsf_ops);
+	cdevp->owner = fops->xsf_ops.owner;
+	cdevp->dev = MKDEV(MAJOR(fops->xsf_dev_t), pdev->id);
+
+	/*
+	 * Set pdev as parent of cdev so that when pdev (and its platform
+	 * data) will not be freed when cdev is not freed.
+	 */
+	cdev_set_parent(cdevp, &DEV(pdev)->kobj);
+
+	ret = cdev_add(cdevp, cdevp->dev, 1);
+	if (ret) {
+		xrt_err(pdev, "failed to add cdev: %d", ret);
+		goto failed;
+	}
+	if (!file_name)
+		file_name = pdev->name;
+	if (!inst_name) {
+		if (devnode_mode(drvdata) == XRT_SUBDEV_FILE_MULTI_INST) {
+			snprintf(fname, sizeof(fname), "%s/%s/%s.%u",
+				XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
+				file_name, pdev->id);
+		} else {
+			snprintf(fname, sizeof(fname), "%s/%s/%s",
+				XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
+				file_name);
+		}
+	} else {
+		snprintf(fname, sizeof(fname), "%s/%s/%s.%s", XRT_CDEV_DIR,
+			DEV_PDATA(pdev)->xsp_root_name, file_name, inst_name);
+	}
+	sysdev = device_create(xrt_class, NULL, cdevp->dev, NULL, "%s", fname);
+	if (IS_ERR(sysdev)) {
+		ret = PTR_ERR(sysdev);
+		xrt_err(pdev, "failed to create device node: %d", ret);
+		goto failed;
+	}
+	pdata->xsp_sysdev = sysdev;
+
+	xrt_devnode_allowed(pdev);
+
+	xrt_info(pdev, "created (%d, %d): /dev/%s",
+		MAJOR(cdevp->dev), pdev->id, fname);
+	return 0;
+
+failed:
+	device_destroy(xrt_class, cdevp->dev);
+	cdev_del(cdevp);
+	cdevp->owner = NULL;
+	return ret;
+}
+
+int xrt_devnode_destroy(struct platform_device *pdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	struct cdev *cdevp = &pdata->xsp_cdev;
+	dev_t dev = cdevp->dev;
+	int rc;
+
+	BUG_ON(!cdevp->owner);
+
+	rc = xrt_devnode_disallowed(pdev);
+	if (rc)
+		return rc;
+
+	xrt_info(pdev, "removed (%d, %d): /dev/%s/%s", MAJOR(dev), MINOR(dev),
+		XRT_CDEV_DIR, CDEV_NAME(pdata->xsp_sysdev));
+	device_destroy(xrt_class, cdevp->dev);
+	pdata->xsp_sysdev = NULL;
+	cdev_del(cdevp);
+	return 0;
+}
diff --git a/drivers/fpga/xrt/lib/xrt-main.c b/drivers/fpga/xrt/lib/xrt-main.c
new file mode 100644
index 000000000000..08a8d13c34dd
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xrt-main.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include "subdev.h"
+#include "xrt-main.h"
+
+#define	XRT_IPLIB_MODULE_NAME		"xrt-lib"
+#define	XRT_IPLIB_MODULE_VERSION	"4.0.0"
+#define	XRT_DRVNAME(drv)		((drv)->driver.name)
+#define	XRT_MAX_DEVICE_NODES		128
+
+struct mutex xrt_class_lock;
+struct class *xrt_class;
+
+/*
+ * Subdev driver is known by ID to others. We map the ID to it's
+ * struct platform_driver, which contains it's binding name and driver/file ops.
+ * We also map it to the endpoint name in DTB as well, if it's different
+ * than the driver's binding name.
+ */
+static struct xrt_drv_map {
+	enum xrt_subdev_id id;
+	struct platform_driver *drv;
+	struct xrt_subdev_endpoints *eps;
+	struct ida ida; /* manage driver instance and char dev minor */
+} xrt_drv_maps[] = {
+	{ XRT_SUBDEV_PART, &xrt_partition_driver, },
+	{ XRT_SUBDEV_VSEC, &xrt_vsec_driver, xrt_vsec_endpoints, },
+	{ XRT_SUBDEV_GPIO, &xrt_gpio_driver, xrt_gpio_endpoints,},
+	{ XRT_SUBDEV_AXIGATE, &xrt_axigate_driver, xrt_axigate_endpoints, },
+	{ XRT_SUBDEV_ICAP, &xrt_icap_driver, xrt_icap_endpoints, },
+	{ XRT_SUBDEV_CALIB, &xrt_calib_driver, xrt_calib_endpoints, },
+	{ XRT_SUBDEV_MGMT_MAIN, NULL, },
+	{ XRT_SUBDEV_CLKFREQ, &xrt_clkfreq_driver, xrt_clkfreq_endpoints, },
+	{ XRT_SUBDEV_CLOCK, &xrt_clock_driver, xrt_clock_endpoints, },
+	{ XRT_SUBDEV_UCS, &xrt_ucs_driver, xrt_ucs_endpoints, },
+};
+
+static inline struct xrt_subdev_drvdata *
+xrt_drv_map2drvdata(struct xrt_drv_map *map)
+{
+	return (struct xrt_subdev_drvdata *)map->drv->id_table[0].driver_data;
+}
+
+static struct xrt_drv_map *
+xrt_drv_find_map_by_id(enum xrt_subdev_id id)
+{
+	int i;
+	struct xrt_drv_map *map = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++) {
+		struct xrt_drv_map *tmap = &xrt_drv_maps[i];
+
+		if (tmap->id != id)
+			continue;
+		map = tmap;
+		break;
+	}
+	return map;
+}
+
+static int xrt_drv_register_driver(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+	struct xrt_subdev_drvdata *drvdata;
+	int rc = 0;
+	const char *drvname;
+
+	BUG_ON(!map);
+
+	if (!map->drv) {
+		pr_info("skip registration of subdev driver for id %d\n", id);
+		return rc;
+	}
+	drvname = XRT_DRVNAME(map->drv);
+
+	rc = platform_driver_register(map->drv);
+	if (rc) {
+		pr_err("register %s subdev driver failed\n", drvname);
+		return rc;
+	}
+
+	drvdata = xrt_drv_map2drvdata(map);
+	if (drvdata && drvdata->xsd_dev_ops.xsd_post_init) {
+		rc = drvdata->xsd_dev_ops.xsd_post_init();
+		if (rc) {
+			platform_driver_unregister(map->drv);
+			pr_err("%s's post-init, ret %d\n", drvname, rc);
+			return rc;
+		}
+	}
+
+	if (drvdata) {
+		/* Initialize dev_t for char dev node. */
+		if (xrt_devnode_enabled(drvdata)) {
+			rc = alloc_chrdev_region(
+				&drvdata->xsd_file_ops.xsf_dev_t, 0,
+				XRT_MAX_DEVICE_NODES, drvname);
+			if (rc) {
+				if (drvdata->xsd_dev_ops.xsd_pre_exit)
+					drvdata->xsd_dev_ops.xsd_pre_exit();
+				platform_driver_unregister(map->drv);
+				pr_err("failed to alloc dev minor for %s: %d\n",
+					drvname, rc);
+				return rc;
+			}
+		} else {
+			drvdata->xsd_file_ops.xsf_dev_t = (dev_t)-1;
+		}
+	}
+
+	ida_init(&map->ida);
+
+	pr_info("registered %s subdev driver\n", drvname);
+	return 0;
+}
+
+static void xrt_drv_unregister_driver(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+	struct xrt_subdev_drvdata *drvdata;
+	const char *drvname;
+
+	BUG_ON(!map);
+	if (!map->drv) {
+		pr_info("skip unregistration of subdev driver for id %d\n", id);
+		return;
+	}
+
+	drvname = XRT_DRVNAME(map->drv);
+
+	ida_destroy(&map->ida);
+
+	drvdata = xrt_drv_map2drvdata(map);
+	if (drvdata && drvdata->xsd_file_ops.xsf_dev_t != (dev_t)-1) {
+		unregister_chrdev_region(drvdata->xsd_file_ops.xsf_dev_t,
+			XRT_MAX_DEVICE_NODES);
+	}
+
+	if (drvdata && drvdata->xsd_dev_ops.xsd_pre_exit)
+		drvdata->xsd_dev_ops.xsd_pre_exit();
+
+	platform_driver_unregister(map->drv);
+
+	pr_info("unregistered %s subdev driver\n", drvname);
+}
+
+int xrt_subdev_register_external_driver(enum xrt_subdev_id id,
+	struct platform_driver *drv, struct xrt_subdev_endpoints *eps)
+{
+	int i;
+	int result = 0;
+
+	mutex_lock(&xrt_class_lock);
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++) {
+		struct xrt_drv_map *map = &xrt_drv_maps[i];
+
+		if (map->id != id)
+			continue;
+		if (map->drv) {
+			result = -EEXIST;
+			pr_err("Id %d already has a registered driver, 0x%p\n",
+				id, map->drv);
+			break;
+		}
+		map->drv = drv;
+		BUG_ON(map->eps);
+		map->eps = eps;
+		xrt_drv_register_driver(id);
+	}
+	mutex_unlock(&xrt_class_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_register_external_driver);
+
+void xrt_subdev_unregister_external_driver(enum xrt_subdev_id id)
+{
+	int i;
+
+	mutex_lock(&xrt_class_lock);
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++) {
+		struct xrt_drv_map *map = &xrt_drv_maps[i];
+
+		if (map->id != id)
+			continue;
+		xrt_drv_unregister_driver(id);
+		map->drv = NULL;
+		map->eps = NULL;
+		break;
+	}
+	mutex_unlock(&xrt_class_lock);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_unregister_external_driver);
+
+static __init int xrt_drv_register_drivers(void)
+{
+	int i;
+	int rc = 0;
+
+	mutex_init(&xrt_class_lock);
+	xrt_class = class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
+	if (IS_ERR(xrt_class))
+		return PTR_ERR(xrt_class);
+
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++) {
+		rc = xrt_drv_register_driver(xrt_drv_maps[i].id);
+		if (rc)
+			break;
+	}
+	if (!rc)
+		return 0;
+
+	while (i-- > 0)
+		xrt_drv_unregister_driver(xrt_drv_maps[i].id);
+	class_destroy(xrt_class);
+	return rc;
+}
+
+static __exit void xrt_drv_unregister_drivers(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++)
+		xrt_drv_unregister_driver(xrt_drv_maps[i].id);
+	class_destroy(xrt_class);
+}
+
+const char *xrt_drv_name(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	if (map)
+		return XRT_DRVNAME(map->drv);
+	return NULL;
+}
+
+int xrt_drv_get_instance(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	return ida_alloc_range(&map->ida, 0, XRT_MAX_DEVICE_NODES, GFP_KERNEL);
+}
+
+void xrt_drv_put_instance(enum xrt_subdev_id id, int instance)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	ida_free(&map->ida, instance);
+}
+
+struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	return map ? map->eps : NULL;
+}
+
+module_init(xrt_drv_register_drivers);
+module_exit(xrt_drv_unregister_drivers);
+
+MODULE_VERSION(XRT_IPLIB_MODULE_VERSION);
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/xrt/lib/xrt-main.h b/drivers/fpga/xrt/lib/xrt-main.h
new file mode 100644
index 000000000000..f46f90d9e882
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xrt-main.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_MAIN_H_
+#define	_XRT_MAIN_H_
+
+extern struct platform_driver xrt_partition_driver;
+extern struct platform_driver xrt_test_driver;
+extern struct platform_driver xrt_vsec_driver;
+extern struct platform_driver xrt_vsec_golden_driver;
+extern struct platform_driver xrt_axigate_driver;
+extern struct platform_driver xrt_qspi_driver;
+extern struct platform_driver xrt_gpio_driver;
+extern struct platform_driver xrt_mailbox_driver;
+extern struct platform_driver xrt_icap_driver;
+extern struct platform_driver xrt_cmc_driver;
+extern struct platform_driver xrt_clkfreq_driver;
+extern struct platform_driver xrt_clock_driver;
+extern struct platform_driver xrt_ucs_driver;
+extern struct platform_driver xrt_calib_driver;
+
+extern struct xrt_subdev_endpoints xrt_vsec_endpoints[];
+extern struct xrt_subdev_endpoints xrt_vsec_golden_endpoints[];
+extern struct xrt_subdev_endpoints xrt_axigate_endpoints[];
+extern struct xrt_subdev_endpoints xrt_test_endpoints[];
+extern struct xrt_subdev_endpoints xrt_qspi_endpoints[];
+extern struct xrt_subdev_endpoints xrt_gpio_endpoints[];
+extern struct xrt_subdev_endpoints xrt_mailbox_endpoints[];
+extern struct xrt_subdev_endpoints xrt_icap_endpoints[];
+extern struct xrt_subdev_endpoints xrt_cmc_endpoints[];
+extern struct xrt_subdev_endpoints xrt_clkfreq_endpoints[];
+extern struct xrt_subdev_endpoints xrt_clock_endpoints[];
+extern struct xrt_subdev_endpoints xrt_ucs_endpoints[];
+extern struct xrt_subdev_endpoints xrt_calib_endpoints[];
+
+extern const char *xrt_drv_name(enum xrt_subdev_id id);
+extern int xrt_drv_get_instance(enum xrt_subdev_id id);
+extern void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
+extern struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
+
+#endif	/* _XRT_MAIN_H_ */
diff --git a/drivers/fpga/xrt/lib/xrt-subdev.c b/drivers/fpga/xrt/lib/xrt-subdev.c
new file mode 100644
index 000000000000..2e3b5612cf8f
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xrt-subdev.c
@@ -0,0 +1,1007 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include "subdev.h"
+#include "parent.h"
+#include "xrt-main.h"
+#include "metadata.h"
+
+#define DEV_IS_PCI(dev) ((dev)->bus == &pci_bus_type)
+static inline struct device *find_root(struct platform_device *pdev)
+{
+	struct device *d = DEV(pdev);
+
+	while (!DEV_IS_PCI(d))
+		d = d->parent;
+	return d;
+}
+
+/*
+ * It represents a holder of a subdev. One holder can repeatedly hold a subdev
+ * as long as there is a unhold corresponding to a hold.
+ */
+struct xrt_subdev_holder {
+	struct list_head xsh_holder_list;
+	struct device *xsh_holder;
+	int xsh_count;
+};
+
+/*
+ * It represents a specific instance of platform driver for a subdev, which
+ * provides services to its clients (another subdev driver or root driver).
+ */
+struct xrt_subdev {
+	struct list_head xs_dev_list;
+	struct list_head xs_holder_list;
+	enum xrt_subdev_id xs_id;		/* type of subdev */
+	struct platform_device *xs_pdev;	/* a particular subdev inst */
+	struct completion xs_holder_comp;
+};
+
+static struct xrt_subdev *xrt_subdev_alloc(void)
+{
+	struct xrt_subdev *sdev = vzalloc(sizeof(struct xrt_subdev));
+
+	if (!sdev)
+		return NULL;
+
+	INIT_LIST_HEAD(&sdev->xs_dev_list);
+	INIT_LIST_HEAD(&sdev->xs_holder_list);
+	init_completion(&sdev->xs_holder_comp);
+	return sdev;
+}
+
+static void xrt_subdev_free(struct xrt_subdev *sdev)
+{
+	vfree(sdev);
+}
+
+/*
+ * Subdev common sysfs nodes.
+ */
+static ssize_t holders_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	ssize_t len;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xrt_parent_ioctl_get_holders holders = { pdev, buf, 1024 };
+
+	len = xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_GET_LEAF_HOLDERS, &holders);
+	if (len >= holders.xpigh_holder_buf_len)
+		return len;
+	buf[len] = '\n';
+	return len + 1;
+}
+static DEVICE_ATTR_RO(holders);
+
+static struct attribute *xrt_subdev_attrs[] = {
+	&dev_attr_holders.attr,
+	NULL,
+};
+
+static ssize_t metadata_output(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buf, loff_t off, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	unsigned char *blob;
+	long  size;
+	ssize_t ret = 0;
+
+	blob = pdata->xsp_dtb;
+	size = xrt_md_size(dev, blob);
+	if (size <= 0) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	if (off >= size)
+		goto failed;
+
+	if (off + count > size)
+		count = size - off;
+	memcpy(buf, blob + off, count);
+
+	ret = count;
+failed:
+	return ret;
+}
+
+static struct bin_attribute meta_data_attr = {
+	.attr = {
+		.name = "metadata",
+		.mode = 0400
+	},
+	.read = metadata_output,
+	.size = 0
+};
+
+static struct bin_attribute  *xrt_subdev_bin_attrs[] = {
+	&meta_data_attr,
+	NULL,
+};
+
+static const struct attribute_group xrt_subdev_attrgroup = {
+	.attrs = xrt_subdev_attrs,
+	.bin_attrs = xrt_subdev_bin_attrs,
+};
+
+static int
+xrt_subdev_getres(struct device *parent, enum xrt_subdev_id id,
+	char *dtb, struct resource **res, int *res_num)
+{
+	struct xrt_subdev_platdata *pdata;
+	struct resource *pci_res = NULL;
+	const u64 *bar_range;
+	const u32 *bar_idx;
+	char *ep_name = NULL, *regmap = NULL;
+	uint bar;
+	int count1 = 0, count2 = 0, ret;
+
+	if (!dtb)
+		return -EINVAL;
+
+	pdata = DEV_PDATA(to_platform_device(parent));
+
+	for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL,
+		&ep_name, &regmap);
+		ep_name != NULL;
+		xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap,
+		&ep_name, &regmap)) {
+		ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
+			PROP_IO_OFFSET, (const void **)&bar_range, NULL);
+		if (!ret)
+			count1++;
+	}
+	if (!count1)
+		return 0;
+
+	*res = vzalloc(sizeof(struct resource) * count1);
+
+	for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL,
+		&ep_name, &regmap);
+		ep_name != NULL;
+		xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap,
+		&ep_name, &regmap)) {
+		ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
+			PROP_IO_OFFSET, (const void **)&bar_range, NULL);
+		if (ret)
+			continue;
+		xrt_md_get_prop(parent, dtb, ep_name, regmap,
+			PROP_BAR_IDX, (const void **)&bar_idx, NULL);
+		bar = bar_idx ? be32_to_cpu(*bar_idx) : 0;
+		xrt_subdev_get_barres(to_platform_device(parent), &pci_res,
+			bar);
+		(*res)[count2].start = pci_res->start +
+			be64_to_cpu(bar_range[0]);
+		(*res)[count2].end = pci_res->start +
+			be64_to_cpu(bar_range[0]) +
+			be64_to_cpu(bar_range[1]) - 1;
+		(*res)[count2].flags = IORESOURCE_MEM;
+		/* check if there is conflicted resource */
+		ret = request_resource(pci_res, *res + count2);
+		if (ret) {
+			dev_err(parent, "Conflict resource %pR\n",
+				*res + count2);
+			vfree(*res);
+			*res_num = 0;
+			*res = NULL;
+			return ret;
+		}
+		release_resource(*res + count2);
+
+		(*res)[count2].parent = pci_res;
+
+		xrt_md_get_epname_pointer(parent, pdata->xsp_dtb, ep_name,
+			regmap, &(*res)[count2].name);
+
+		count2++;
+	}
+
+	BUG_ON(count1 != count2);
+	*res_num = count2;
+
+	return 0;
+}
+
+static inline enum xrt_subdev_file_mode
+xrt_devnode_mode(struct xrt_subdev_drvdata *drvdata)
+{
+	return drvdata->xsd_file_ops.xsf_mode;
+}
+
+static bool xrt_subdev_cdev_auto_creation(struct platform_device *pdev)
+{
+	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
+
+	if (!drvdata)
+		return false;
+
+	return xrt_devnode_enabled(drvdata) &&
+		(xrt_devnode_mode(drvdata) == XRT_SUBDEV_FILE_DEFAULT ||
+		(xrt_devnode_mode(drvdata) == XRT_SUBDEV_FILE_MULTI_INST));
+}
+
+static struct xrt_subdev *
+xrt_subdev_create(struct device *parent, enum xrt_subdev_id id,
+	xrt_subdev_parent_cb_t pcb, void *pcb_arg, char *dtb)
+{
+	struct xrt_subdev *sdev = NULL;
+	struct platform_device *pdev = NULL;
+	struct xrt_subdev_platdata *pdata = NULL;
+	long dtb_len = 0;
+	size_t pdata_sz;
+	int inst = PLATFORM_DEVID_NONE;
+	struct resource *res = NULL;
+	int res_num = 0;
+
+	sdev = xrt_subdev_alloc();
+	if (!sdev) {
+		dev_err(parent, "failed to alloc subdev for ID %d", id);
+		goto fail;
+	}
+	sdev->xs_id = id;
+
+	if (dtb) {
+		xrt_md_pack(parent, dtb);
+		dtb_len = xrt_md_size(parent, dtb);
+		if (dtb_len <= 0) {
+			dev_err(parent, "invalid metadata len %ld", dtb_len);
+			goto fail;
+		}
+	}
+	pdata_sz = sizeof(struct xrt_subdev_platdata) + dtb_len - 1;
+
+	/* Prepare platform data passed to subdev. */
+	pdata = vzalloc(pdata_sz);
+	if (!pdata)
+		goto fail;
+
+	pdata->xsp_parent_cb = pcb;
+	pdata->xsp_parent_cb_arg = pcb_arg;
+	(void) memcpy(pdata->xsp_dtb, dtb, dtb_len);
+	if (id == XRT_SUBDEV_PART) {
+		/* Partition can only be created by root driver. */
+		BUG_ON(parent->bus != &pci_bus_type);
+		pdata->xsp_root_name = dev_name(parent);
+	} else {
+		struct platform_device *part = to_platform_device(parent);
+		/* Leaf can only be created by partition driver. */
+		BUG_ON(parent->bus != &platform_bus_type);
+		BUG_ON(strcmp(xrt_drv_name(XRT_SUBDEV_PART),
+			platform_get_device_id(part)->name));
+		pdata->xsp_root_name = DEV_PDATA(part)->xsp_root_name;
+	}
+
+	/* Obtain dev instance number. */
+	inst = xrt_drv_get_instance(id);
+	if (inst < 0) {
+		dev_err(parent, "failed to obtain instance: %d", inst);
+		goto fail;
+	}
+
+	/* Create subdev. */
+	if (id == XRT_SUBDEV_PART) {
+		pdev = platform_device_register_data(parent,
+			xrt_drv_name(XRT_SUBDEV_PART), inst, pdata, pdata_sz);
+	} else {
+		int rc = xrt_subdev_getres(parent, id, dtb, &res, &res_num);
+
+		if (rc) {
+			dev_err(parent, "failed to get resource for %s.%d: %d",
+				xrt_drv_name(id), inst, rc);
+			goto fail;
+		}
+		pdev = platform_device_register_resndata(parent,
+			xrt_drv_name(id), inst, res, res_num, pdata, pdata_sz);
+		vfree(res);
+	}
+	if (IS_ERR(pdev)) {
+		dev_err(parent, "failed to create subdev for %s inst %d: %ld",
+			xrt_drv_name(id), inst, PTR_ERR(pdev));
+		goto fail;
+	}
+	sdev->xs_pdev = pdev;
+
+	if (device_attach(DEV(pdev)) != 1) {
+		xrt_err(pdev, "failed to attach");
+		goto fail;
+	}
+
+	if (sysfs_create_group(&DEV(pdev)->kobj, &xrt_subdev_attrgroup))
+		xrt_err(pdev, "failed to create sysfs group");
+
+	/*
+	 * Create sysfs sym link under root for leaves
+	 * under random partitions for easy access to them.
+	 */
+	if (id != XRT_SUBDEV_PART) {
+		if (sysfs_create_link(&find_root(pdev)->kobj,
+			&DEV(pdev)->kobj, dev_name(DEV(pdev)))) {
+			xrt_err(pdev, "failed to create sysfs link");
+		}
+	}
+
+	/* All done, ready to handle req thru cdev. */
+	if (xrt_subdev_cdev_auto_creation(pdev)) {
+		(void) xrt_devnode_create(pdev,
+			DEV_DRVDATA(pdev)->xsd_file_ops.xsf_dev_name, NULL);
+	}
+
+	vfree(pdata);
+	return sdev;
+
+fail:
+	vfree(pdata);
+	if (sdev && !IS_ERR_OR_NULL(sdev->xs_pdev))
+		platform_device_unregister(sdev->xs_pdev);
+	if (inst >= 0)
+		xrt_drv_put_instance(id, inst);
+	xrt_subdev_free(sdev);
+	return NULL;
+}
+
+static void xrt_subdev_destroy(struct xrt_subdev *sdev)
+{
+	struct platform_device *pdev = sdev->xs_pdev;
+	int inst = pdev->id;
+	struct device *dev = DEV(pdev);
+
+	/* Take down the device node */
+	if (xrt_subdev_cdev_auto_creation(pdev))
+		(void) xrt_devnode_destroy(pdev);
+	if (sdev->xs_id != XRT_SUBDEV_PART)
+		(void) sysfs_remove_link(&find_root(pdev)->kobj, dev_name(dev));
+	(void) sysfs_remove_group(&dev->kobj, &xrt_subdev_attrgroup);
+	platform_device_unregister(pdev);
+	xrt_drv_put_instance(sdev->xs_id, inst);
+	xrt_subdev_free(sdev);
+}
+
+int xrt_subdev_parent_ioctl(struct platform_device *self, u32 cmd, void *arg)
+{
+	struct device *dev = DEV(self);
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(self);
+
+	return (*pdata->xsp_parent_cb)(dev->parent, pdata->xsp_parent_cb_arg,
+		cmd, arg);
+}
+
+int xrt_subdev_ioctl(struct platform_device *tgt, u32 cmd, void *arg)
+{
+	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(tgt);
+
+	return (*drvdata->xsd_dev_ops.xsd_ioctl)(tgt, cmd, arg);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_ioctl);
+
+struct platform_device *
+xrt_subdev_get_leaf(struct platform_device *pdev,
+	xrt_subdev_match_t match_cb, void *match_arg)
+{
+	int rc;
+	struct xrt_parent_ioctl_get_leaf get_leaf = {
+		pdev, match_cb, match_arg, };
+
+	rc = xrt_subdev_parent_ioctl(pdev, XRT_PARENT_GET_LEAF, &get_leaf);
+	if (rc)
+		return NULL;
+	return get_leaf.xpigl_leaf;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_get_leaf);
+
+struct subdev_match_arg {
+	enum xrt_subdev_id id;
+	int instance;
+};
+
+static bool subdev_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	struct subdev_match_arg *a = (struct subdev_match_arg *)arg;
+	return id == a->id &&
+		(pdev->id == a->instance || PLATFORM_DEVID_NONE == a->instance);
+}
+
+struct platform_device *
+xrt_subdev_get_leaf_by_id(struct platform_device *pdev,
+	enum xrt_subdev_id id, int instance)
+{
+	struct subdev_match_arg arg = { id, instance };
+
+	return xrt_subdev_get_leaf(pdev, subdev_match, &arg);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_get_leaf_by_id);
+
+bool xrt_subdev_has_epname(struct platform_device *pdev, const char *ep_name)
+{
+	struct resource	*res;
+	int		i;
+
+	for (i = 0, res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	    res;
+	    res = platform_get_resource(pdev, IORESOURCE_MEM, ++i)) {
+		if (!strncmp(res->name, ep_name, strlen(res->name) + 1))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_has_epname);
+
+static bool xrt_subdev_match_epname(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	return xrt_subdev_has_epname(pdev, arg);
+}
+
+struct platform_device *
+xrt_subdev_get_leaf_by_epname(struct platform_device *pdev, const char *name)
+{
+	return xrt_subdev_get_leaf(pdev, xrt_subdev_match_epname, (void *)name);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_get_leaf_by_epname);
+
+int xrt_subdev_put_leaf(struct platform_device *pdev,
+	struct platform_device *leaf)
+{
+	struct xrt_parent_ioctl_put_leaf put_leaf = { pdev, leaf };
+
+	return xrt_subdev_parent_ioctl(pdev, XRT_PARENT_PUT_LEAF, &put_leaf);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_put_leaf);
+
+int xrt_subdev_create_partition(struct platform_device *pdev, char *dtb)
+{
+	return xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_CREATE_PARTITION, dtb);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_create_partition);
+
+int xrt_subdev_destroy_partition(struct platform_device *pdev, int instance)
+{
+	return xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_REMOVE_PARTITION, (void *)(uintptr_t)instance);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_destroy_partition);
+
+int xrt_subdev_lookup_partition(struct platform_device *pdev,
+	xrt_subdev_match_t match_cb, void *match_arg)
+{
+	int rc;
+	struct xrt_parent_ioctl_lookup_partition lkp = {
+		pdev, match_cb, match_arg, };
+
+	rc = xrt_subdev_parent_ioctl(pdev, XRT_PARENT_LOOKUP_PARTITION, &lkp);
+	if (rc)
+		return rc;
+	return lkp.xpilp_part_inst;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_lookup_partition);
+
+int xrt_subdev_wait_for_partition_bringup(struct platform_device *pdev)
+{
+	return xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_WAIT_PARTITION_BRINGUP, NULL);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_wait_for_partition_bringup);
+
+void *xrt_subdev_add_event_cb(struct platform_device *pdev,
+	xrt_subdev_match_t match, void *match_arg, xrt_event_cb_t cb)
+{
+	struct xrt_parent_ioctl_evt_cb c = { pdev, match, match_arg, cb };
+
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_ADD_EVENT_CB, &c);
+	return c.xevt_hdl;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_add_event_cb);
+
+void xrt_subdev_remove_event_cb(struct platform_device *pdev, void *hdl)
+{
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_REMOVE_EVENT_CB, hdl);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_remove_event_cb);
+
+static ssize_t
+xrt_subdev_get_holders(struct xrt_subdev *sdev, char *buf, size_t len)
+{
+	const struct list_head *ptr;
+	struct xrt_subdev_holder *h;
+	ssize_t n = 0;
+
+	list_for_each(ptr, &sdev->xs_holder_list) {
+		h = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
+		n += snprintf(buf + n, len - n, "%s:%d ",
+			dev_name(h->xsh_holder), h->xsh_count);
+		if (n >= len)
+			break;
+	}
+	return n;
+}
+
+void xrt_subdev_pool_init(struct device *dev, struct xrt_subdev_pool *spool)
+{
+	INIT_LIST_HEAD(&spool->xpool_dev_list);
+	spool->xpool_owner = dev;
+	mutex_init(&spool->xpool_lock);
+	spool->xpool_closing = false;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_init);
+
+static void xrt_subdev_pool_wait_for_holders(struct xrt_subdev_pool *spool,
+	struct xrt_subdev *sdev)
+{
+	const struct list_head *ptr, *next;
+	char holders[128];
+	struct xrt_subdev_holder *holder;
+	struct mutex *lk = &spool->xpool_lock;
+
+	BUG_ON(!mutex_is_locked(lk));
+
+	while (!list_empty(&sdev->xs_holder_list)) {
+		int rc;
+
+		/* It's most likely a bug if we ever enters this loop. */
+		(void) xrt_subdev_get_holders(sdev, holders, sizeof(holders));
+		xrt_err(sdev->xs_pdev, "awaits holders: %s", holders);
+		mutex_unlock(lk);
+		rc = wait_for_completion_killable(&sdev->xs_holder_comp);
+		mutex_lock(lk);
+		if (rc == -ERESTARTSYS) {
+			xrt_err(sdev->xs_pdev,
+				"give up on waiting for holders, clean up now");
+			list_for_each_safe(ptr, next, &sdev->xs_holder_list) {
+				holder = list_entry(ptr,
+					struct xrt_subdev_holder,
+					xsh_holder_list);
+				list_del(&holder->xsh_holder_list);
+				vfree(holder);
+			}
+		}
+	}
+}
+
+int xrt_subdev_pool_fini(struct xrt_subdev_pool *spool)
+{
+	int ret = 0;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct mutex *lk = &spool->xpool_lock;
+
+	mutex_lock(lk);
+
+	if (spool->xpool_closing) {
+		mutex_unlock(lk);
+		return 0;
+	}
+
+	spool->xpool_closing = true;
+	/* Remove subdev in the reverse order of added. */
+	while (!ret && !list_empty(dl)) {
+		struct xrt_subdev *sdev = list_first_entry(dl,
+			struct xrt_subdev, xs_dev_list);
+		xrt_subdev_pool_wait_for_holders(spool, sdev);
+		list_del(&sdev->xs_dev_list);
+		mutex_unlock(lk);
+		xrt_subdev_destroy(sdev);
+		mutex_lock(lk);
+	}
+
+	mutex_unlock(lk);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_fini);
+
+static int xrt_subdev_hold(struct xrt_subdev *sdev, struct device *holder_dev)
+{
+	const struct list_head *ptr;
+	struct list_head *hl = &sdev->xs_holder_list;
+	struct xrt_subdev_holder *holder;
+	bool found = false;
+
+	list_for_each(ptr, hl) {
+		holder = list_entry(ptr, struct xrt_subdev_holder,
+			xsh_holder_list);
+		if (holder->xsh_holder == holder_dev) {
+			holder->xsh_count++;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		holder = vzalloc(sizeof(*holder));
+		if (!holder)
+			return -ENOMEM;
+		holder->xsh_holder = holder_dev;
+		holder->xsh_count = 1;
+		list_add_tail(&holder->xsh_holder_list, hl);
+	}
+
+	return holder->xsh_count;
+}
+
+static int
+xrt_subdev_release(struct xrt_subdev *sdev, struct device *holder_dev)
+{
+	const struct list_head *ptr, *next;
+	struct list_head *hl = &sdev->xs_holder_list;
+	struct xrt_subdev_holder *holder;
+	int count;
+	bool found = false;
+
+	list_for_each_safe(ptr, next, hl) {
+		holder = list_entry(ptr, struct xrt_subdev_holder,
+			xsh_holder_list);
+		if (holder->xsh_holder == holder_dev) {
+			found = true;
+			holder->xsh_count--;
+
+			count = holder->xsh_count;
+			if (count == 0) {
+				list_del(&holder->xsh_holder_list);
+				vfree(holder);
+				if (list_empty(hl))
+					complete(&sdev->xs_holder_comp);
+			}
+			break;
+		}
+	}
+	if (!found) {
+		dev_err(holder_dev, "can't release, %s did not hold %s",
+			dev_name(holder_dev),
+			dev_name(DEV(sdev->xs_pdev)));
+	}
+	return found ? count : -EINVAL;
+}
+
+int xrt_subdev_pool_add(struct xrt_subdev_pool *spool, enum xrt_subdev_id id,
+	xrt_subdev_parent_cb_t pcb, void *pcb_arg, char *dtb)
+{
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev;
+	int ret = 0;
+
+	sdev = xrt_subdev_create(spool->xpool_owner, id, pcb, pcb_arg, dtb);
+	if (sdev) {
+		mutex_lock(lk);
+		if (spool->xpool_closing) {
+			/* No new subdev when pool is going away. */
+			xrt_err(sdev->xs_pdev, "pool is closing");
+			ret = -ENODEV;
+		} else {
+			list_add(&sdev->xs_dev_list, dl);
+		}
+		mutex_unlock(lk);
+		if (ret)
+			xrt_subdev_destroy(sdev);
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret ? ret : sdev->xs_pdev->id;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_add);
+
+int xrt_subdev_pool_del(struct xrt_subdev_pool *spool, enum xrt_subdev_id id,
+	int instance)
+{
+	const struct list_head *ptr;
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev;
+	int ret = -ENOENT;
+
+	mutex_lock(lk);
+	list_for_each(ptr, dl) {
+		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
+		if (sdev->xs_id != id || sdev->xs_pdev->id != instance)
+			continue;
+		xrt_subdev_pool_wait_for_holders(spool, sdev);
+		list_del(&sdev->xs_dev_list);
+		ret = 0;
+		break;
+	}
+	mutex_unlock(lk);
+	if (ret)
+		return ret;
+
+	xrt_subdev_destroy(sdev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_del);
+
+static int xrt_subdev_pool_get_impl(struct xrt_subdev_pool *spool,
+	xrt_subdev_match_t match, void *arg, struct device *holder_dev,
+	struct xrt_subdev **sdevp)
+{
+	const struct list_head *ptr;
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev = NULL;
+	int ret = -ENOENT;
+
+	mutex_lock(lk);
+
+	if (match == XRT_SUBDEV_MATCH_PREV) {
+		struct platform_device *pdev = (struct platform_device *)arg;
+		struct xrt_subdev *d = NULL;
+
+		if (!pdev) {
+			sdev = list_empty(dl) ? NULL : list_last_entry(dl,
+				struct xrt_subdev, xs_dev_list);
+		} else {
+			list_for_each(ptr, dl) {
+				d = list_entry(ptr, struct xrt_subdev,
+					xs_dev_list);
+				if (d->xs_pdev != pdev)
+					continue;
+				if (!list_is_first(ptr, dl))
+					sdev = list_prev_entry(d, xs_dev_list);
+				break;
+			}
+		}
+	} else if (match == XRT_SUBDEV_MATCH_NEXT) {
+		struct platform_device *pdev = (struct platform_device *)arg;
+		struct xrt_subdev *d = NULL;
+
+		if (!pdev) {
+			sdev = list_first_entry_or_null(dl,
+				struct xrt_subdev, xs_dev_list);
+		} else {
+			list_for_each(ptr, dl) {
+				d = list_entry(ptr, struct xrt_subdev,
+					xs_dev_list);
+				if (d->xs_pdev != pdev)
+					continue;
+				if (!list_is_last(ptr, dl))
+					sdev = list_next_entry(d, xs_dev_list);
+				break;
+			}
+		}
+	} else {
+		list_for_each(ptr, dl) {
+			struct xrt_subdev *d = NULL;
+
+			d = list_entry(ptr, struct xrt_subdev, xs_dev_list);
+			if (d && !match(d->xs_id, d->xs_pdev, arg))
+				continue;
+			sdev = d;
+			break;
+		}
+	}
+
+	if (sdev)
+		ret = xrt_subdev_hold(sdev, holder_dev);
+
+	mutex_unlock(lk);
+
+	if (ret >= 0)
+		*sdevp = sdev;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_get);
+
+int xrt_subdev_pool_get(struct xrt_subdev_pool *spool,
+	xrt_subdev_match_t match, void *arg, struct device *holder_dev,
+	struct platform_device **pdevp)
+{
+	int rc;
+	struct xrt_subdev *sdev;
+
+	rc = xrt_subdev_pool_get_impl(spool, match, arg, holder_dev, &sdev);
+	if (rc < 0) {
+		if (rc != -ENOENT)
+			dev_err(holder_dev, "failed to hold device: %d", rc);
+		return rc;
+	}
+
+	if (DEV_IS_PCI(holder_dev)) {
+#ifdef	SUBDEV_DEBUG
+		dev_info(holder_dev, "%s: %s <<==== %s, ref=%d", __func__,
+			dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)), rc);
+#endif
+	} else {
+		xrt_info(to_platform_device(holder_dev), "%s <<==== %s",
+			dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)));
+	}
+
+	*pdevp = sdev->xs_pdev;
+	return 0;
+}
+
+static int xrt_subdev_pool_put_impl(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, struct device *holder_dev)
+{
+	const struct list_head *ptr;
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev;
+	int ret = -ENOENT;
+
+	mutex_lock(lk);
+	list_for_each(ptr, dl) {
+		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
+		if (sdev->xs_pdev != pdev)
+			continue;
+		ret = xrt_subdev_release(sdev, holder_dev);
+		break;
+	}
+	mutex_unlock(lk);
+
+	if (ret < 0 && ret != -ENOENT)
+		dev_err(holder_dev, "failed to release device: %d", ret);
+	return ret;
+}
+
+int xrt_subdev_pool_put(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, struct device *holder_dev)
+{
+	int ret = xrt_subdev_pool_put_impl(spool, pdev, holder_dev);
+
+	if (ret < 0)
+		return ret;
+
+	if (DEV_IS_PCI(holder_dev)) {
+#ifdef	SUBDEV_DEBUG
+		dev_info(holder_dev, "%s: %s <<==X== %s, ref=%d", __func__,
+			dev_name(holder_dev), dev_name(DEV(spdev)), ret);
+#endif
+	} else {
+		struct platform_device *d = to_platform_device(holder_dev);
+
+		xrt_info(d, "%s <<==X== %s",
+			dev_name(holder_dev), dev_name(DEV(pdev)));
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_put);
+
+int xrt_subdev_pool_event(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, xrt_subdev_match_t match, void *arg,
+	xrt_event_cb_t xevt_cb, enum xrt_events evt)
+{
+	int rc = 0;
+	struct platform_device *tgt = NULL;
+	struct xrt_subdev *sdev = NULL;
+	struct xrt_event_arg_subdev esd;
+
+	while (!rc && xrt_subdev_pool_get_impl(spool, XRT_SUBDEV_MATCH_NEXT,
+		tgt, DEV(pdev), &sdev) != -ENOENT) {
+		tgt = sdev->xs_pdev;
+		esd.xevt_subdev_id = sdev->xs_id;
+		esd.xevt_subdev_instance = tgt->id;
+		if (match(sdev->xs_id, sdev->xs_pdev, arg))
+			rc = xevt_cb(pdev, evt, &esd);
+		(void) xrt_subdev_pool_put_impl(spool, tgt, DEV(pdev));
+	}
+	return rc;
+}
+
+ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, char *buf, size_t len)
+{
+	const struct list_head *ptr;
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev;
+	ssize_t ret = 0;
+
+	mutex_lock(lk);
+	list_for_each(ptr, dl) {
+		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
+		if (sdev->xs_pdev != pdev)
+			continue;
+		ret = xrt_subdev_get_holders(sdev, buf, len);
+		break;
+	}
+	mutex_unlock(lk);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_get_holders);
+
+int xrt_subdev_broadcast_event_async(struct platform_device *pdev,
+	enum xrt_events evt, xrt_async_broadcast_event_cb_t cb, void *arg)
+{
+	struct xrt_parent_ioctl_async_broadcast_evt e = { pdev, evt, cb, arg };
+
+	return xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_ASYNC_BOARDCAST_EVENT, &e);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_broadcast_event_async);
+
+struct xrt_broadcast_event_arg {
+	struct completion comp;
+	bool success;
+};
+
+static void xrt_broadcast_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg, bool success)
+{
+	struct xrt_broadcast_event_arg *e =
+		(struct xrt_broadcast_event_arg *)arg;
+
+	e->success = success;
+	complete(&e->comp);
+}
+
+int xrt_subdev_broadcast_event(struct platform_device *pdev,
+	enum xrt_events evt)
+{
+	int ret;
+	struct xrt_broadcast_event_arg e;
+
+	init_completion(&e.comp);
+	e.success = false;
+	ret = xrt_subdev_broadcast_event_async(pdev, evt,
+		xrt_broadcast_event_cb, &e);
+	if (ret == 0)
+		wait_for_completion(&e.comp);
+	return e.success ? 0 : -EINVAL;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_broadcast_event);
+
+void xrt_subdev_hot_reset(struct platform_device *pdev)
+{
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_HOT_RESET, NULL);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_hot_reset);
+
+void xrt_subdev_get_barres(struct platform_device *pdev,
+	struct resource **res, uint bar_idx)
+{
+	struct xrt_parent_ioctl_get_res arg = { 0 };
+
+	BUG_ON(bar_idx > PCI_STD_RESOURCE_END);
+
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_GET_RESOURCE, &arg);
+
+	*res = &arg.xpigr_res[bar_idx];
+}
+
+void xrt_subdev_get_parent_id(struct platform_device *pdev,
+	unsigned short *vendor, unsigned short *device,
+	unsigned short *subvendor, unsigned short *subdevice)
+{
+	struct xrt_parent_ioctl_get_id id = { 0 };
+
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_GET_ID, (void *)&id);
+	if (vendor)
+		*vendor = id.xpigi_vendor_id;
+	if (device)
+		*device = id.xpigi_device_id;
+	if (subvendor)
+		*subvendor = id.xpigi_sub_vendor_id;
+	if (subdevice)
+		*subdevice = id.xpigi_sub_device_id;
+}
+
+struct device *xrt_subdev_register_hwmon(struct platform_device *pdev,
+	const char *name, void *drvdata, const struct attribute_group **grps)
+{
+	struct xrt_parent_ioctl_hwmon hm = { true, name, drvdata, grps, };
+
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_HWMON, (void *)&hm);
+	return hm.xpih_hwmon_dev;
+}
+
+void xrt_subdev_unregister_hwmon(struct platform_device *pdev,
+	struct device *hwmon)
+{
+	struct xrt_parent_ioctl_hwmon hm = { false, };
+
+	hm.xpih_hwmon_dev = hwmon;
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_HWMON, (void *)&hm);
+}
-- 
2.17.1

