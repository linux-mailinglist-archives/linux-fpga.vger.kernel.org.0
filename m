Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A6537B3C0
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 03:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhELB7J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 21:59:09 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:21121
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229848AbhELB7I (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 21:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnSS+jh54CBukW4EiIUjKLQE/4WDzvNu4qdVk68TcS9c6sddua111KoXfVPnQy8zvZgeguDzcI1PaqDkzge/6XxYL5RohyUpXOLMufI2moM9cTq/KnBIU5UfYBYEFIGt0WSKTjwA05JIP2tvQfixCdrcHaUW9Ps/vRYdYN+PHR2RLzP3CeDoEZlCvLmL8A9uiN3vyMdnInH62qvm4P9MEBmipDWNCMsKBY7wGSvSB1CdPNmGD0nYd7kiwwAmURlI+GZKF4l0Fy65Favv68xah4SFk/DF7hR1fNej+yT72OcdNALrHliY/u0wNzd+cwekOFQzpyQS1XJXf0Aofr2t6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLdFWc7SWuTvxPoUlriAjJNZF00EnAOFl3aIVpbeeSs=;
 b=nlOyfFG1HxXRnboFb7zaB11Ak3nVdUSRhvWJTkIbGDWZW7n2kkhtB2ZimrPf/qVnZRgN7Ei3Jtq8WeKljTsPh+x492bNbd52J+fjdoutg79fzNn1XnRHRIx632UTLvWJUBHazZQ5KEytDdvRVt3zq8WfhkZyojqt3Vo7n4sGJPoZzHW7M/Mmvutyf8UqAwhw3hgelkFU5b9+TubjYJoMnLtl95/5EFuPlA3crx4+6G+8UIhLd+HMrdeuvo56kpvVhmqo4EUqNCtGxsPcfu0JzB/DHNbkHYzisGok8zgXe9tXRKpyMGY4cbnFJnzG/l6yzNa4ERUI4i+/4BzbBIVX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLdFWc7SWuTvxPoUlriAjJNZF00EnAOFl3aIVpbeeSs=;
 b=MtpUUdWuyUmjfEds6MNDO7m6OKc6b7ungMs9BudwYBRs4unHRBCypRUtNmqIxZ+xKOdzkRndMCtdfGDm1/FAoP03jR3578ssDioniy6q9plnJJjkfUU6EaUrxcT9BCECJ99A6RXsm5RBRxkT0aabyYz5N1gc/CyQoklAhsqamM8=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by PH0PR02MB7447.namprd02.prod.outlook.com (2603:10b6:510:15::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 01:57:59 +0000
Received: from BN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::c2) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 01:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT016.mail.protection.outlook.com (10.13.2.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 01:57:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 18:57:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 18:57:42 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35714 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lge86-0005NE-Rm; Tue, 11 May 2021 18:57:42 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id DB199600127; Tue, 11 May 2021 18:53:44 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 02/20] fpga: xrt: driver metadata helper functions
Date:   Tue, 11 May 2021 18:53:21 -0700
Message-ID: <20210512015339.5649-3-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a036a8e-01e8-42de-22b8-08d914e95e09
X-MS-TrafficTypeDiagnostic: PH0PR02MB7447:
X-Microsoft-Antispam-PRVS: <PH0PR02MB744756A2C64C909CFB37B95AA1529@PH0PR02MB7447.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: do5sSIUHkVUGFLaAU5z8ls0WFnfhAtn70PcazicgfeJ2YFqJ37HMtnId2voi6eJwMPNsZ+L7UhqmUNf5TuV5mrb5QF0N4csKtvXhq9Rgx01advAaH8YzN6qgN4Nt6+UGr8zB2+l+dJPG763Ai20LeD4fQsjuT2FU8ctiDsOhGObYTQ6UYfOfuCqBVcgpFNNTOUSgw3prfnm5ZZ1zv9n+3ZjWvL9dV6hbhAZ8WVS6Pm89dVbgmQI9VM2G5PX6/N/lHqRe1EOnsVQ5TQg4cIEMBDqeE0mepYAX5WAyAt83+n9NoWEvjEMfifUeLLqkBloPu4QgsosCrHNPLW8NBApdvA990JHN0gW2pwWfHR0yzSihn989FSK0NQreDdhbDYXbypb2svf+6G20GXDLW9r0T1PKK+By4NfTmzcAm4dv1pskpm5XUpTMv5LwFbMavkgKUAdHA8FK8du0Gr4oFyzoWaXDu6HrIXSV9DTmS5nfN+LyaOGkscS1cSLx69jyu4fcIxciizmjiwUi1tztofU1IEB8LS4Jj02EMf+JtSowWuOyjqcF9tZSmq+zjWH23AEa0VUD4sBoMjBlAhnKGZmlqMfnDAppALIQ0/77K4ZyPqK7ufkT+nray6GRELbVRGsCvHshOvC145TAA73VwEqrRnXHHttQffuHHoxAutMYmKM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39850400004)(36840700001)(46966006)(6666004)(47076005)(4326008)(54906003)(478600001)(26005)(70586007)(2906002)(7636003)(70206006)(8676002)(5660300002)(83380400001)(36860700001)(36906005)(6916009)(2616005)(44832011)(30864003)(36756003)(82310400003)(426003)(6266002)(1076003)(356005)(42186006)(8936002)(82740400003)(316002)(186003)(107886003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 01:57:58.5808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a036a8e-01e8-42de-22b8-08d914e95e09
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7447
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

XRT drivers use device tree as metadata format to discover HW subsystems
behind PCIe BAR. Thus libfdt functions are called for the driver to parse
the device tree blob.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/include/metadata.h  | 236 +++++++++++
 drivers/fpga/xrt/metadata/metadata.c | 578 +++++++++++++++++++++++++++
 2 files changed, 814 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/metadata.h
 create mode 100644 drivers/fpga/xrt/metadata/metadata.c

diff --git a/drivers/fpga/xrt/include/metadata.h b/drivers/fpga/xrt/include/metadata.h
new file mode 100644
index 000000000000..c4df88262f8a
--- /dev/null
+++ b/drivers/fpga/xrt/include/metadata.h
@@ -0,0 +1,236 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
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
+#define XRT_MD_INVALID_LENGTH (~0U)
+
+/* metadata properties */
+#define XRT_MD_PROP_BAR_IDX "pcie_bar_mapping"
+#define XRT_MD_PROP_COMPATIBLE "compatible"
+#define XRT_MD_PROP_HWICAP "axi_hwicap"
+#define XRT_MD_PROP_INTERFACE_UUID "interface_uuid"
+#define XRT_MD_PROP_INTERRUPTS "interrupts"
+#define XRT_MD_PROP_IO_OFFSET "reg"
+#define XRT_MD_PROP_LOGIC_UUID "logic_uuid"
+#define XRT_MD_PROP_PDI_CONFIG "pdi_config_mem"
+#define XRT_MD_PROP_PF_NUM "pcie_physical_function"
+#define XRT_MD_PROP_VERSION_MAJOR "firmware_version_major"
+
+/* non IP nodes */
+#define XRT_MD_NODE_ENDPOINTS "addressable_endpoints"
+#define XRT_MD_NODE_FIRMWARE "firmware"
+#define XRT_MD_NODE_INTERFACES "interfaces"
+#define XRT_MD_NODE_PARTITION_INFO "partition_info"
+
+/*
+ * IP nodes
+ * AF:  AXI Firewall
+ * CMC: Card Management Controller
+ * ERT: Embedded Runtime
+ * EP:  End Point
+ * PLP: Provider Reconfigurable Partition
+ * ULP: User Reconfigurable Partition
+ */
+#define XRT_MD_NODE_ADDR_TRANSLATOR "ep_remap_data_c2h_00"
+#define XRT_MD_NODE_AF_BLP_CTRL_MGMT "ep_firewall_blp_ctrl_mgmt_00"
+#define XRT_MD_NODE_AF_BLP_CTRL_USER "ep_firewall_blp_ctrl_user_00"
+#define XRT_MD_NODE_AF_CTRL_DEBUG "ep_firewall_ctrl_debug_00"
+#define XRT_MD_NODE_AF_CTRL_MGMT "ep_firewall_ctrl_mgmt_00"
+#define XRT_MD_NODE_AF_CTRL_USER "ep_firewall_ctrl_user_00"
+#define XRT_MD_NODE_AF_DATA_C2H "ep_firewall_data_c2h_00" /* c2h: card to host */
+#define XRT_MD_NODE_AF_DATA_H2C "ep_firewall_data_h2c_00" /* h2c: host to card */
+#define XRT_MD_NODE_AF_DATA_M2M "ep_firewall_data_m2m_00"
+#define XRT_MD_NODE_AF_DATA_P2P "ep_firewall_data_p2p_00"
+#define XRT_MD_NODE_CLKFREQ_HBM "ep_freq_cnt_aclk_hbm_00" /* hbm: High Bandwidth Memory */
+#define XRT_MD_NODE_CLKFREQ_K1 "ep_freq_cnt_aclk_kernel_00"
+#define XRT_MD_NODE_CLKFREQ_K2 "ep_freq_cnt_aclk_kernel_01"
+#define XRT_MD_NODE_CLK_KERNEL1 "ep_aclk_kernel_00"
+#define XRT_MD_NODE_CLK_KERNEL2 "ep_aclk_kernel_01"
+#define XRT_MD_NODE_CLK_KERNEL3 "ep_aclk_hbm_00"
+#define XRT_MD_NODE_CLK_SHUTDOWN "ep_aclk_shutdown_00"
+#define XRT_MD_NODE_CMC_FW_MEM "ep_cmc_firmware_mem_00"
+#define XRT_MD_NODE_CMC_MUTEX "ep_cmc_mutex_00"
+#define XRT_MD_NODE_CMC_REG "ep_cmc_regmap_00"
+#define XRT_MD_NODE_CMC_RESET "ep_cmc_reset_00"
+#define XRT_MD_NODE_DDR_CALIB "ep_ddr_mem_calib_00"
+#define XRT_MD_NODE_DDR4_RESET_GATE "ep_ddr_mem_srsr_gate_00"
+#define XRT_MD_NODE_ERT_BASE "ep_ert_base_address_00"
+#define XRT_MD_NODE_ERT_CQ_MGMT "ep_ert_command_queue_mgmt_00"
+#define XRT_MD_NODE_ERT_CQ_USER "ep_ert_command_queue_user_00"
+#define XRT_MD_NODE_ERT_FW_MEM "ep_ert_firmware_mem_00"
+#define XRT_MD_NODE_ERT_RESET "ep_ert_reset_00"
+#define XRT_MD_NODE_ERT_SCHED "ep_ert_sched_00"
+#define XRT_MD_NODE_FLASH "ep_card_flash_program_00"
+#define XRT_MD_NODE_FPGA_CONFIG "ep_fpga_configuration_00"
+#define XRT_MD_NODE_GAPPING "ep_gapping_demand_00"
+#define XRT_MD_NODE_GATE_PLP "ep_pr_isolate_plp_00"
+#define XRT_MD_NODE_GATE_ULP "ep_pr_isolate_ulp_00"
+#define XRT_MD_NODE_KDMA_CTRL "ep_kdma_ctrl_00"
+#define XRT_MD_NODE_MAILBOX_MGMT "ep_mailbox_mgmt_00"
+#define XRT_MD_NODE_MAILBOX_USER "ep_mailbox_user_00"
+#define XRT_MD_NODE_MAILBOX_XRT "ep_mailbox_user_to_ert_00"
+#define XRT_MD_NODE_MSIX "ep_msix_00"
+#define XRT_MD_NODE_P2P "ep_p2p_00"
+#define XRT_MD_NODE_PCIE_MON "ep_pcie_link_mon_00"
+#define XRT_MD_NODE_PMC_INTR   "ep_pmc_intr_00"
+#define XRT_MD_NODE_PMC_MUX    "ep_pmc_mux_00"
+#define XRT_MD_NODE_QDMA "ep_qdma_00"
+#define XRT_MD_NODE_QDMA4 "ep_qdma4_00"
+#define XRT_MD_NODE_REMAP_P2P "ep_remap_p2p_00"
+#define XRT_MD_NODE_STM "ep_stream_traffic_manager_00"
+#define XRT_MD_NODE_STM4 "ep_stream_traffic_manager4_00"
+#define XRT_MD_NODE_SYSMON "ep_cmp_sysmon_00"
+#define XRT_MD_NODE_XDMA "ep_xdma_00"
+#define XRT_MD_NODE_XVC_PUB "ep_debug_bscan_user_00"
+#define XRT_MD_NODE_XVC_PRI "ep_debug_bscan_mgmt_00"
+#define XRT_MD_NODE_UCS_CONTROL_STATUS "ep_ucs_control_status_00"
+
+/* endpoint compatible string */
+#define XRT_MD_COMPAT_DDR_SRSR "drv_ddr_srsr"
+#define XRT_MD_COMPAT_CLKFREQ "freq_cnt"
+
+/* driver defined endpoints */
+#define XRT_MD_NODE_BLP_ROM "drv_ep_blp_rom_00"
+#define XRT_MD_NODE_DDR_SRSR "drv_ep_ddr_srsr"
+#define XRT_MD_NODE_FLASH_VSEC "drv_ep_card_flash_program_00"
+#define XRT_MD_NODE_GOLDEN_VER "drv_ep_golden_ver_00"
+#define XRT_MD_NODE_MAILBOX_VSEC "drv_ep_mailbox_vsec_00"
+#define XRT_MD_NODE_MGMT_MAIN "drv_ep_mgmt_main_00"
+#define XRT_MD_NODE_PLAT_INFO "drv_ep_platform_info_mgmt_00"
+#define XRT_MD_NODE_PARTITION_INFO_BLP "partition_info_0"
+#define XRT_MD_NODE_PARTITION_INFO_PLP "partition_info_1"
+#define XRT_MD_NODE_TEST "drv_ep_test_00"
+#define XRT_MD_NODE_VSEC "drv_ep_vsec_00"
+#define XRT_MD_NODE_VSEC_GOLDEN "drv_ep_vsec_golden_00"
+
+/* driver defined properties */
+#define XRT_MD_PROP_OFFSET "drv_offset"
+#define XRT_MD_PROP_CLK_FREQ "drv_clock_frequency"
+#define XRT_MD_PROP_CLK_CNT "drv_clock_frequency_counter"
+#define XRT_MD_PROP_VBNV "vbnv"
+#define XRT_MD_PROP_VROM "vrom"
+#define XRT_MD_PROP_PARTITION_LEVEL "partition_level"
+
+struct xrt_md_endpoint {
+	const char	*ep_name;
+	u32		bar_index;
+	u64		bar_off;
+	u64		size;
+	char		*compat;
+	char		*compat_ver;
+};
+
+/* Note: res_id is defined by leaf driver and must start with 0. */
+struct xrt_iores_map {
+	char		*res_name;
+	int		res_id;
+};
+
+static inline int xrt_md_res_name2id(const struct xrt_iores_map *res_map,
+				     int entry_num, const char *res_name)
+{
+	int i;
+
+	for (i = 0; i < entry_num; i++) {
+		if (!strncmp(res_name, res_map->res_name, strlen(res_map->res_name) + 1))
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
+	for (i = 0; i < entry_num; i++) {
+		if (res_map->res_id == id)
+			return res_map->res_name;
+		res_map++;
+	}
+	return NULL;
+}
+
+u32 xrt_md_size(struct device *dev, const char *blob);
+int xrt_md_create(struct device *dev, char **blob);
+char *xrt_md_dup(struct device *dev, const char *blob);
+int xrt_md_add_endpoint(struct device *dev, char *blob,
+			struct xrt_md_endpoint *ep);
+int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
+			const char *compat);
+int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
+		    const char *compat, const char *prop,
+		    const void **val, int *size);
+int xrt_md_set_prop(struct device *dev, char *blob, const char *ep_name,
+		    const char *compat, const char *prop,
+		    const void *val, int size);
+int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
+			 const char *ep_name, const char *compat,
+			 const char *new_ep_name);
+int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
+			     const char *ep_name,  const char *compat,
+			     char **next_ep, char **next_compat);
+int xrt_md_get_compatible_endpoint(struct device *dev, const char *blob,
+				   const char *compat, const char **ep_name);
+int xrt_md_find_endpoint(struct device *dev, const char *blob,
+			 const char *ep_name, const char *compat,
+			 const char **epname);
+int xrt_md_pack(struct device *dev, char *blob);
+int xrt_md_get_interface_uuids(struct device *dev, const char *blob,
+			       u32 num_uuids, uuid_t *intf_uuids);
+
+/*
+ * The firmware provides a 128 bit hash string as a unique id to the
+ * partition/interface.
+ * Existing hw does not yet use the cononical form, so it is necessary to
+ * use a translation function.
+ */
+static inline void xrt_md_trans_uuid2str(const uuid_t *uuid, char *uuidstr)
+{
+	int i, p;
+	u8 tmp[UUID_SIZE];
+
+	BUILD_BUG_ON(UUID_SIZE != 16);
+	export_uuid(tmp, uuid);
+	for (p = 0, i = UUID_SIZE - 1; i >= 0; p++, i--)
+		snprintf(&uuidstr[p * 2], 3, "%02x", tmp[i]);
+}
+
+static inline int xrt_md_trans_str2uuid(struct device *dev, const char *uuidstr, uuid_t *p_uuid)
+{
+	u8 p[UUID_SIZE];
+	const char *str;
+	char tmp[3] = { 0 };
+	int i, ret;
+
+	if (strlen(uuidstr) != UUID_SIZE * 2)
+		return -EINVAL;
+
+	str = uuidstr + strlen(uuidstr) - 2;
+
+	for (i = 0; i < sizeof(*p_uuid) && str >= uuidstr; i++) {
+		tmp[0] = *str;
+		tmp[1] = *(str + 1);
+		ret = kstrtou8(tmp, 16, &p[i]);
+		if (ret)
+			return -EINVAL;
+		str -= 2;
+	}
+	import_uuid(p_uuid, p);
+
+	return 0;
+}
+
+#endif
diff --git a/drivers/fpga/xrt/metadata/metadata.c b/drivers/fpga/xrt/metadata/metadata.c
new file mode 100644
index 000000000000..6f67490a3ab1
--- /dev/null
+++ b/drivers/fpga/xrt/metadata/metadata.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Metadata parse APIs
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/libfdt_env.h>
+#include "libfdt.h"
+#include "metadata.h"
+
+#define XRT_MAX_BLOB_SIZE	(4096 * 25)
+#define XRT_MAX_DEPTH 5
+
+static int xrt_md_setprop(struct device *dev, char *blob, int offset,
+			  const char *prop, const void *val, int size)
+{
+	int ret;
+
+	ret = fdt_setprop(blob, offset, prop, val, size);
+	if (ret) {
+		ret = -EINVAL;
+		dev_err(dev, "failed to set prop %d", ret);
+	}
+
+	return ret;
+}
+
+static int xrt_md_add_node(struct device *dev, char *blob, int parent_offset,
+			   const char *ep_name)
+{
+	int ret;
+
+	ret = fdt_add_subnode(blob, parent_offset, ep_name);
+	if (ret < 0 && ret != -FDT_ERR_EXISTS) {
+		ret = -EINVAL;
+		dev_err(dev, "failed to add node %s. %d", ep_name, ret);
+	}
+
+	return ret;
+}
+
+static int xrt_md_get_endpoint(struct device *dev, const char *blob,
+			       const char *ep_name, const char *compat,
+			       int *ep_offset)
+{
+	const char *name;
+	int offset;
+
+	if (compat) {
+		for (offset = fdt_next_node((blob), -1, NULL);
+		     offset >= 0;
+		     offset = fdt_next_node((blob), offset, NULL)) {
+			name = fdt_get_name(blob, offset, NULL);
+			if (!name || strncmp(name, ep_name, strlen(ep_name) + 1))
+				continue;
+			if (!fdt_node_check_compatible(blob, offset, compat))
+				break;
+		}
+	} else {
+		for (offset = fdt_next_node((blob), -1, NULL);
+		     offset >= 0;
+		     offset = fdt_next_node((blob), offset, NULL)) {
+			name = fdt_get_name(blob, offset, NULL);
+			if (name && !strncmp(name, ep_name, strlen(ep_name) + 1))
+				break;
+		}
+	}
+
+	if (offset < 0)
+		return -ENODEV;
+
+	*ep_offset = offset;
+
+	return 0;
+}
+
+static inline int xrt_md_get_node(struct device *dev, const char *blob,
+				  const char *name, const char *compat,
+				  int *offset)
+{
+	int ret = 0;
+
+	if (name) {
+		ret = xrt_md_get_endpoint(dev, blob, name, compat,
+					  offset);
+		if (ret) {
+			if (compat) {
+				dev_err(dev, "cannot get node %s compat %s, ret %d",
+					name, compat, ret);
+			} else {
+				dev_err(dev, "cannot get node %s, ret %d", name, ret);
+			}
+			return -EINVAL;
+		}
+	} else {
+		ret = fdt_next_node(blob, -1, NULL);
+		if (ret < 0) {
+			dev_err(dev, "internal error, ret = %d", ret);
+			return -EINVAL;
+		}
+		*offset = ret;
+	}
+
+	return 0;
+}
+
+static int xrt_md_overlay(struct device *dev, char *blob, int target,
+			  const char *overlay_blob, int overlay_offset,
+			  int depth)
+{
+	int property, subnode;
+	int ret;
+
+	if (!blob || !overlay_blob) {
+		dev_err(dev, "blob is NULL");
+		return -EINVAL;
+	}
+
+	if (depth > XRT_MAX_DEPTH) {
+		dev_err(dev, "meta data depth beyond %d", XRT_MAX_DEPTH);
+		return -EINVAL;
+	}
+
+	if (target < 0) {
+		target = fdt_next_node(blob, -1, NULL);
+		if (target < 0) {
+			dev_err(dev, "invalid target");
+			return -EINVAL;
+		}
+	}
+	if (overlay_offset < 0) {
+		overlay_offset = fdt_next_node(overlay_blob, -1, NULL);
+		if (overlay_offset < 0) {
+			dev_err(dev, "invalid overlay");
+			return -EINVAL;
+		}
+	}
+
+	fdt_for_each_property_offset(property, overlay_blob, overlay_offset) {
+		const char *name;
+		const void *prop;
+		int prop_len;
+
+		prop = fdt_getprop_by_offset(overlay_blob, property, &name,
+					     &prop_len);
+		if (!prop || prop_len >= XRT_MAX_BLOB_SIZE || prop_len < 0) {
+			dev_err(dev, "internal error");
+			return -EINVAL;
+		}
+
+		ret = xrt_md_setprop(dev, blob, target, name, prop,
+				     prop_len);
+		if (ret) {
+			dev_err(dev, "setprop failed, ret = %d", ret);
+			return ret;
+		}
+	}
+
+	fdt_for_each_subnode(subnode, overlay_blob, overlay_offset) {
+		const char *name = fdt_get_name(overlay_blob, subnode, NULL);
+		int nnode;
+
+		nnode = xrt_md_add_node(dev, blob, target, name);
+		if (nnode == -FDT_ERR_EXISTS)
+			nnode = fdt_subnode_offset(blob, target, name);
+		if (nnode < 0) {
+			dev_err(dev, "add node failed, ret = %d", nnode);
+			return -EINVAL;
+		}
+
+		ret = xrt_md_overlay(dev, blob, nnode, overlay_blob, subnode, depth + 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+u32 xrt_md_size(struct device *dev, const char *blob)
+{
+	u32 len = fdt_totalsize(blob);
+
+	if (len > XRT_MAX_BLOB_SIZE)
+		return XRT_MD_INVALID_LENGTH;
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(xrt_md_size);
+
+int xrt_md_create(struct device *dev, char **blob)
+{
+	int ret = 0;
+
+	if (!blob) {
+		dev_err(dev, "blob is NULL");
+		return -EINVAL;
+	}
+
+	*blob = vzalloc(XRT_MAX_BLOB_SIZE);
+	if (!*blob)
+		return -ENOMEM;
+
+	ret = fdt_create_empty_tree(*blob, XRT_MAX_BLOB_SIZE);
+	if (ret) {
+		ret = -EINVAL;
+		dev_err(dev, "format blob failed, ret = %d", ret);
+		goto failed;
+	}
+
+	ret = fdt_next_node(*blob, -1, NULL);
+	if (ret < 0) {
+		ret = -EINVAL;
+		dev_err(dev, "No Node, ret = %d", ret);
+		goto failed;
+	}
+
+	ret = fdt_add_subnode(*blob, 0, XRT_MD_NODE_ENDPOINTS);
+	if (ret < 0) {
+		ret = -EINVAL;
+		dev_err(dev, "add node failed, ret = %d", ret);
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	vfree(*blob);
+	*blob = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_md_create);
+
+char *xrt_md_dup(struct device *dev, const char *blob)
+{
+	char *dup_blob;
+	int ret;
+
+	ret = xrt_md_create(dev, &dup_blob);
+	if (ret)
+		return NULL;
+	ret = xrt_md_overlay(dev, dup_blob, -1, blob, -1, 0);
+	if (ret) {
+		vfree(dup_blob);
+		return NULL;
+	}
+
+	return dup_blob;
+}
+EXPORT_SYMBOL_GPL(xrt_md_dup);
+
+int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
+			const char *compat)
+{
+	int ep_offset;
+	int ret;
+
+	ret = xrt_md_get_endpoint(dev, blob, ep_name, compat, &ep_offset);
+	if (ret) {
+		dev_err(dev, "can not find ep %s", ep_name);
+		return -EINVAL;
+	}
+
+	ret = fdt_del_node(blob, ep_offset);
+	if (ret) {
+		ret = -EINVAL;
+		dev_err(dev, "delete node %s failed, ret %d", ep_name, ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_md_del_endpoint);
+
+static int __xrt_md_add_endpoint(struct device *dev, char *blob,
+				 struct xrt_md_endpoint *ep, int *offset,
+				 const char *parent)
+{
+	int parent_offset = 0;
+	u32 val, count = 0;
+	int ep_offset = 0;
+	u64 io_range[2];
+	char comp[128];
+	int ret = 0;
+
+	if (!ep->ep_name) {
+		dev_err(dev, "empty name");
+		return -EINVAL;
+	}
+
+	if (parent) {
+		ret = xrt_md_get_endpoint(dev, blob, parent, NULL, &parent_offset);
+		if (ret) {
+			dev_err(dev, "invalid blob, ret = %d", ret);
+			return -EINVAL;
+		}
+	}
+
+	ep_offset = xrt_md_add_node(dev, blob, parent_offset, ep->ep_name);
+	if (ep_offset < 0) {
+		dev_err(dev, "add endpoint failed, ret = %d", ret);
+		return -EINVAL;
+	}
+	if (offset)
+		*offset = ep_offset;
+
+	if (ep->size != 0) {
+		val = cpu_to_be32(ep->bar_index);
+		ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_BAR_IDX,
+				     &val, sizeof(u32));
+		if (ret) {
+			dev_err(dev, "set %s failed, ret %d",
+				XRT_MD_PROP_BAR_IDX, ret);
+			goto failed;
+		}
+		io_range[0] = cpu_to_be64((u64)ep->bar_off);
+		io_range[1] = cpu_to_be64((u64)ep->size);
+		ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_IO_OFFSET,
+				     io_range, sizeof(io_range));
+		if (ret) {
+			dev_err(dev, "set %s failed, ret %d",
+				XRT_MD_PROP_IO_OFFSET, ret);
+			goto failed;
+		}
+	}
+
+	if (ep->compat) {
+		if (ep->compat_ver) {
+			count = snprintf(comp, sizeof(comp) - 1,
+					 "%s-%s", ep->compat, ep->compat_ver);
+			count++;
+		}
+		if (count >= sizeof(comp)) {
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		count += snprintf(comp + count, sizeof(comp) - count - 1,
+				  "%s", ep->compat);
+		count++;
+		if (count >= sizeof(comp)) {
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_COMPATIBLE,
+				     comp, count);
+		if (ret) {
+			dev_err(dev, "set %s failed, ret %d",
+				XRT_MD_PROP_COMPATIBLE, ret);
+			goto failed;
+		}
+	}
+
+failed:
+	if (ret)
+		xrt_md_del_endpoint(dev, blob, ep->ep_name, NULL);
+
+	return ret;
+}
+
+int xrt_md_add_endpoint(struct device *dev, char *blob,
+			struct xrt_md_endpoint *ep)
+{
+	return __xrt_md_add_endpoint(dev, blob, ep, NULL, XRT_MD_NODE_ENDPOINTS);
+}
+EXPORT_SYMBOL_GPL(xrt_md_add_endpoint);
+
+int xrt_md_find_endpoint(struct device *dev, const char *blob,
+			 const char *ep_name, const char *compat,
+			 const char **epname)
+{
+	int offset;
+	int ret;
+
+	ret = xrt_md_get_endpoint(dev, blob, ep_name, compat,
+				  &offset);
+	if (ret)
+		return ret;
+
+	if (epname) {
+		*epname = fdt_get_name(blob, offset, NULL);
+		if (!*epname)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_md_find_endpoint);
+
+int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
+		    const char *compat, const char *prop,
+		    const void **val, int *size)
+{
+	int offset;
+	int ret;
+
+	if (!val) {
+		dev_err(dev, "val is null");
+		return -EINVAL;
+	}
+
+	*val = NULL;
+	ret = xrt_md_get_node(dev, blob, ep_name, compat, &offset);
+	if (ret)
+		return ret;
+
+	*val = fdt_getprop(blob, offset, prop, size);
+	if (!*val) {
+		dev_dbg(dev, "get ep %s, prop %s failed", ep_name, prop);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_md_get_prop);
+
+int xrt_md_set_prop(struct device *dev, char *blob,
+		    const char *ep_name, const char *compat,
+		    const char *prop, const void *val, int size)
+{
+	int offset;
+	int ret;
+
+	ret = xrt_md_get_node(dev, blob, ep_name, compat, &offset);
+	if (ret)
+		return ret;
+
+	ret = xrt_md_setprop(dev, blob, offset, prop, val, size);
+	if (ret)
+		dev_err(dev, "set prop %s failed, ret = %d", prop, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_md_set_prop);
+
+int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
+			 const char *ep_name, const char *compat,
+			 const char *new_ep_name)
+{
+	const char *newepnm = new_ep_name ? new_ep_name : ep_name;
+	struct xrt_md_endpoint ep = {0};
+	int offset, target;
+	const char *parent;
+	int ret;
+
+	ret = xrt_md_get_endpoint(dev, src_blob, ep_name, compat,
+				  &offset);
+	if (ret)
+		return -EINVAL;
+
+	ret = xrt_md_get_endpoint(dev, blob, newepnm, compat, &target);
+	if (ret) {
+		ep.ep_name = newepnm;
+		parent = fdt_parent_offset(src_blob, offset) == 0 ? NULL : XRT_MD_NODE_ENDPOINTS;
+		ret = __xrt_md_add_endpoint(dev, blob, &ep, &target, parent);
+		if (ret)
+			return -EINVAL;
+	}
+
+	ret = xrt_md_overlay(dev, blob, target, src_blob, offset, 0);
+	if (ret)
+		dev_err(dev, "overlay failed, ret = %d", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_md_copy_endpoint);
+
+int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
+			     const char *ep_name, const char *compat,
+			     char **next_ep, char **next_compat)
+{
+	int offset, ret;
+
+	*next_ep = NULL;
+	*next_compat = NULL;
+	if (!ep_name) {
+		ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_ENDPOINTS, NULL,
+					  &offset);
+	} else {
+		ret = xrt_md_get_endpoint(dev, blob, ep_name, compat,
+					  &offset);
+	}
+
+	if (ret)
+		return -EINVAL;
+
+	if (ep_name)
+		offset = fdt_next_subnode(blob, offset);
+	else
+		offset = fdt_first_subnode(blob, offset);
+	if (offset < 0)
+		return -EINVAL;
+
+	*next_ep = (char *)fdt_get_name(blob, offset, NULL);
+	*next_compat = (char *)fdt_stringlist_get(blob, offset, XRT_MD_PROP_COMPATIBLE,
+						  0, NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_md_get_next_endpoint);
+
+int xrt_md_get_compatible_endpoint(struct device *dev, const char *blob,
+				   const char *compat, const char **ep_name)
+{
+	int ep_offset;
+
+	ep_offset = fdt_node_offset_by_compatible(blob, -1, compat);
+	if (ep_offset < 0) {
+		*ep_name = NULL;
+		return -ENOENT;
+	}
+
+	*ep_name = fdt_get_name(blob, ep_offset, NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_md_get_compatible_endpoint);
+
+int xrt_md_pack(struct device *dev, char *blob)
+{
+	int ret;
+
+	ret = fdt_pack(blob);
+	if (ret) {
+		ret = -EINVAL;
+		dev_err(dev, "pack failed %d", ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_md_pack);
+
+int xrt_md_get_interface_uuids(struct device *dev, const char *blob,
+			       u32 num_uuids, uuid_t *interface_uuids)
+{
+	int offset, count = 0;
+	const char *uuid_str;
+	int ret;
+
+	ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_INTERFACES, NULL, &offset);
+	if (ret)
+		return -ENOENT;
+
+	for (offset = fdt_first_subnode(blob, offset);
+	    offset >= 0;
+	    offset = fdt_next_subnode(blob, offset), count++) {
+		uuid_str = fdt_getprop(blob, offset, XRT_MD_PROP_INTERFACE_UUID,
+				       NULL);
+		if (!uuid_str) {
+			dev_err(dev, "empty interface uuid node");
+			return -EINVAL;
+		}
+
+		if (!num_uuids)
+			continue;
+
+		if (count == num_uuids) {
+			dev_err(dev, "too many interface uuid in blob");
+			return -EINVAL;
+		}
+
+		if (interface_uuids && count < num_uuids) {
+			ret = xrt_md_trans_str2uuid(dev, uuid_str,
+						    &interface_uuids[count]);
+			if (ret)
+				return -EINVAL;
+		}
+	}
+	if (!count)
+		count = -ENOENT;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(xrt_md_get_interface_uuids);
-- 
2.27.0

