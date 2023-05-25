Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B608E710950
	for <lists+linux-fpga@lfdr.de>; Thu, 25 May 2023 11:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbjEYJyz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 May 2023 05:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbjEYJyr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 May 2023 05:54:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D512E;
        Thu, 25 May 2023 02:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg3NXPSEpJQWqjCz8LZyDayV3qj4UvdPh3e3itq3j0+JqBnKYlOl6JPzrmsdPxFOR9kfFfBigGHYJDh78kNyVW1G9aPheuXZ7EYCHLVrGLqkdeTJK93/1qvzK0h5xY7kpfOeWhjg7nkpM6BpibmHF4vjTiduG2wJDUcMFpwwg0xh0NIidQsR9c9A/y8tvKUO/EDvhpKvlEJgjR1NwFZvmQ54b7exIs7BRxolp9PZQHA41DqbjszlsRGN0crCApNophm6IahwMGxZXY8ShpyRYh3tXSb71XD/TtEfErHexbPYREEqGN15KCq4/sNmRfr4DrON69oH5/BwduIk/VWzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gskIlw+AYb7C5t/UCFLjfAKJwxYlwTqyvdZv0eQ09Vk=;
 b=ZDyYGuaVMFdKsoEN7EoJI+0VtMDvSw43mUEC1krVqPTDy3vk/uxoAdSwouD2QxqfGIt2NzswTLHA7Ofao5OMfGCfR9SM3M/6fIbed9s2VBab+jPxRF1hV3n0LQtRaVOdfj+8KJY8r0YvFY4mfE4S3VaPvSFElf3mr3mItIyAhrH2bhOanX1PXBDqqzbzAQkKFOUVoNELOd+jgtbhLyZ7ZSkNqaE8FhaFZpnFWhAG4a6OGcDQaL7ApoX/30yBX1YNtMqf+JaGzqOFJAgQ8eqQBDbrwYVvYd9RgrVQwJKxi8Ba+CpkbBp5KEV0mi15/sqEzwMxU0pD/184eGdhBziBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gskIlw+AYb7C5t/UCFLjfAKJwxYlwTqyvdZv0eQ09Vk=;
 b=mjfSBm5Z2sJ+iJd06z/x2aHqNfUXGbc2M8KWerbP6L1ZowebPy9pg0wA6m90EdxpF4DU14QTFolyzgbrxAWezY60Y+jdH/gRzm0MlhZoaDD3OHoNxx+ED2Al3jyX3F3zZnjZEiWzx93K2cb++6OMhZ+xNifPKwZp9wzuidxnq6Y=
Received: from BN9PR03CA0806.namprd03.prod.outlook.com (2603:10b6:408:13f::31)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 09:54:42 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::3b) by BN9PR03CA0806.outlook.office365.com
 (2603:10b6:408:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 09:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.32 via Frontend Transport; Thu, 25 May 2023 09:54:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 04:54:41 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <nava.kishore.manne@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [RFC PATCH] fpga: fpga-bridge: Add manual set option via sysfs
Date:   Thu, 25 May 2023 15:24:38 +0530
Message-ID: <20230525095438.2766625-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: b82dac1e-0163-4e4f-9ba5-08db5d060ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuEDtTcArVFBb3NZy+LKSNEhpbig5/SuLO6G+Zem5MYSTfGt9QaUDzAHCqxXwG0GaiggMeKws2IfC2pc+e4GCd1Ap/lnFfrEcVWUmAB5Ns3pUpr/2wvSqz54iagMrOK1jlSdFnpuCtZ6BflTQ4J+I9i3KvNJ9wU8Eh2YVgQZdFmpXSVABbZwQANmsK5VBCyrmII/C51LGR32As5VgWF6lUKCdRsI4qRs6KYCrIhLbDWFPZoF7pC1F2PXamQulFCfGth/5MWZ4Yr0YlMVxMitXLTZrn8nzt+7lMxLgzxuCJgEjHsSphtMPwtEjSq3+D6UTxSh0CNt/ahTh/Hzp2QkSqfLWe+MSVDNxW/tbfpNMDN6cgoWVsHhg3LgzMSLchGFISLFOp3DYk6dvIEJI1IEcFaglUNMT8kAlJHEuXQFO2ics7rxqEXd9kZihU4c17UsOOTL5igpJYe4hy9Mheq3Oe0N+lcs3jHEMEfyALE9PgIXbdOWdMcsHU5UJfLH7Znk58YaNmKfFQHXZYx8XBDwLHPXhp173JuHJj+iMUvXBs/qF/itck2QIo2jjI7nmJiuh2SxA7SnH75owtZXV7A4+RxJJTK+OSLqj1lLKYgKVhJRXBPtVjm75xx9dnjRjW4AhsUYMwi5NG0uOtsEO8bUa0e8JgJfvU+axnBvbvebu57WA7X9plLm7+yGMKLs6Sj+KrSHzKGe8QaEgA1SYMV6otCtnqhsdom0XBpiIXI6zjZieyN9I53Kl7dkEk72boYC4qi5vuPGE8QhSbRauXf+QhVzcB+DBkus9oC0tXnKiY0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(426003)(6666004)(40460700003)(41300700001)(81166007)(26005)(1076003)(8676002)(8936002)(36756003)(36860700001)(5660300002)(2616005)(82310400005)(83380400001)(47076005)(336012)(2906002)(103116003)(186003)(86362001)(16526019)(356005)(40480700001)(82740400003)(70206006)(70586007)(478600001)(110136005)(316002)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 09:54:42.1988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b82dac1e-0163-4e4f-9ba5-08db5d060ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201
X-Spam-Status: No, score=-0.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch is intended for manual testing only.
It is provide an option to manually test bridges.

Enabling bridge (!0 values are handled)
br1# echo 1 > /sys/class/fpga_bridge/<bridge>/set

Disable bridge
br1# echo 0 > /sys/class/fpga_bridge/<bridge>/set

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 .../ABI/testing/sysfs-class-fpga-bridge       |  9 ++++++
 drivers/fpga/fpga-bridge.c                    | 30 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-bridge b/Documentation/ABI/testing/sysfs-class-fpga-bridge
index 312ae2c579d8..e157eb737bfb 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-bridge
+++ b/Documentation/ABI/testing/sysfs-class-fpga-bridge
@@ -9,3 +9,12 @@ Date:		January 2016
 KernelVersion:	4.5
 Contact:	Alan Tull <atull@opensource.altera.com>
 Description:	Show bridge state as "enabled" or "disabled"
+
+What:		/sys/class/fpga_bridge/<bridge>/set
+Date:		May 2023
+KernelVersion:	6.4
+Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
+Description:	Manual set bridge state (0-disable, !0 enable).
+		Enabling this option requires that the module is
+		compiled with #define DEBUG which is enabled by default
+		when CONFIG_DEBUG_KERNEL is setup.
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a6c25dee9cc1..54d15b709b10 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -13,6 +13,12 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+/* For enabling manual bridge set(enable/disable) function */
+#ifdef CONFIG_DEBUG_KERNEL
+#undef DEBUG
+#define DEBUG
+#endif
+
 static DEFINE_IDA(fpga_bridge_ida);
 static struct class *fpga_bridge_class;
 
@@ -307,9 +313,33 @@ static ssize_t state_show(struct device *dev,
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(state);
 
+#ifdef DEBUG
+static ssize_t set_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct fpga_bridge *bridge = to_fpga_bridge(dev);
+	long enable;
+	int ret;
+
+	ret = kstrtol(buf, 16, &enable);
+	if (ret)
+		return ret;
+
+	if (bridge->br_ops && bridge->br_ops->enable_set)
+		enable = bridge->br_ops->enable_set(bridge, !!enable);
+
+	return count;
+}
+static DEVICE_ATTR_WO(set);
+#endif
+
 static struct attribute *fpga_bridge_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_state.attr,
+#ifdef DEBUG
+	&dev_attr_set.attr,
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(fpga_bridge);
-- 
2.25.1

