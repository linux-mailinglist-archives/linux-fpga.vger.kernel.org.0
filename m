Return-Path: <linux-fpga+bounces-1247-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F7ADA9BF
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jun 2025 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B525F7A76DF
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jun 2025 07:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1350620010C;
	Mon, 16 Jun 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GwH+SCG2"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB23A8F7;
	Mon, 16 Jun 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059815; cv=fail; b=PMwitO8+qUxuFa3SUpJsjsgwZHTkwI9t1/KsowRd4VQLtZmxsHWxdmdRb65BvAM9QZcHStylAkprMJYLuWApr5BD8taGu0VZqaqfHFp5Qfe9jQiN1Gt2E18YmOV8nMgDn12lYK9ROsvgIAkWgfrqW9+EHwWvUjuWVsvA3g2Z8bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059815; c=relaxed/simple;
	bh=aSUDJTJ5jVEnviGDI/IWunw+yj5pC2nbcKtjjFUZ+mc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uk+prhsy7IxLtYaIeOWNGCw8bVZWwbQ95Nzz3WDF/xSy+uzU51QmiUkbdOkf/Y2bi+cBSR0HSCSt+7nBZ9+AGnT6qyLKXABT1yGHfuhb/6B7aSAnY7uk2mq94xbMZD6XV8PLSHvvSkuR40KjS+IP+8n+jVTaT2/pkeYN/On8z6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GwH+SCG2; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ3Dtk6zHZxQ6frnio8mBCi74y6s11u5n6sYr1i+4XJsUU1q3FVnaXbZ6HOE38aVPaZIC9ko1VVANA93TWEOfhx/YLWfBfPyULCFqjw6/XO7jubLK3VRd/f5nZn4LkDoXUzzrGxNoIRM9bHPRvcOYWcJep/sX9tMM9IOivQFRVlU/kA/nMCAJ846RkLL5fUJMLeWT4nJxcudR9xxwMIXuBqMZZ9xZcggrIzuhtmPXY8AV3tpL114DZLTILiLjCLNv68+XFhvdZWWXZ9wcyBs/g48AM51RHs+VGKKrQUDDF2UJtTmsifh7kdr+AiJlrM2OVjBXpVxLLLMRs4KeJERew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXVWFGSnK4eff7kE+Bfw7gGxmH2KFycPgFIjih9RtDM=;
 b=HKkBzfzQMflpauvq4O1d3kC5FbGQvIEuM75w4M+zywnqD1N0wLjDveQBzt2NkV3aadGZz9+GgLGfdSblGo7rhNac4wit/1bCy4LgjqxWAn7Q5ubvp90+TRcpknnB8hl9Fn59eaXqbDb5jNBLLkbZBv2bQWsw85P49tigklzIJkbcFm0KOi+JAnRWZRKUkJfhD9xeLoenWuOr4fjZGtx3lN4KlqZ5Cw5HD1ZE0A2vsNiVsr1JXaIZpgbTFWg/BY4Fdl1oGYbTqDCqEW/uEbwgSHeANhF9iYVlC9GSpVynrYKufTbZeKjXroHV4ULR7oMU3SRU5wLRFt2jAYsvjyMJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXVWFGSnK4eff7kE+Bfw7gGxmH2KFycPgFIjih9RtDM=;
 b=GwH+SCG2NUoOUyM2Cf2WP+9Ov+XbjV1t9jnx5/2FayPfnfVKZtmKq8xDPKYtlIP9U0/p6c3WeClnOgEtm1A/XxcBz0C3woP7G+udmkDM81Nnu4mqY2SZBLuYFlr1vErx188e5fzwS2zeYAuL4jHoMCH36WQe/eyZiH8krxa4t18=
Received: from BY5PR17CA0031.namprd17.prod.outlook.com (2603:10b6:a03:1b8::44)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 07:43:27 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::db) by BY5PR17CA0031.outlook.office365.com
 (2603:10b6:a03:1b8::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 07:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 07:43:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 02:43:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 02:43:25 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Jun 2025 02:43:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Xu Yilun <yilun.xu@intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, "Conor
 Dooley" <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Moritz Fischer <mdf@kernel.org>,
	Rob Herring <robh@kernel.org>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, "Tom
 Rix" <trix@redhat.com>, Wu Hao <hao.wu@intel.com>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open
 list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>, "open list:GPIO
 SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: [PATCH v3] dt-bindings: gpio: gpio-xilinx: Mark clocks as required property
Date: Mon, 16 Jun 2025 09:43:18 +0200
Message-ID: <94151cfbcff5e4ae05894981c7e398b605d4b00a.1750059796.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2586; i=michal.simek@amd.com; h=from:subject:message-id; bh=aSUDJTJ5jVEnviGDI/IWunw+yj5pC2nbcKtjjFUZ+mc=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT4nxY/r6q+RycncI9tsEz1/JOuVu1hbbUsS06unZ7B0 XFlo9X3jlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiI/BtGholVG2Qk2DaFTv2/ 99LhrCe+bp+U+87ZrmnY2bPEdSH7z1iG/9FOLcbKxpwJDyWF+Foif774sf52Q42jOtuE/8nX1tg u4wYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: baa66390-5dbb-4d38-f85a-08ddaca97b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4cIfQQmFvXGxkNfuqorVUkQhMcnIFAnH0rWvFOELw4L/2tMiXYt+uNw6ZSht?=
 =?us-ascii?Q?BckdHgUxH9NSGk07v5rRMBFx8j2YsIC75zozU0x0e+dIxbKvMocUvLo0VPbP?=
 =?us-ascii?Q?ZlEO01qY78uP4sPsBgnKQZ+2dc19805jSnz9mOIRN5X5WVncowJrrNzTBh2r?=
 =?us-ascii?Q?5r3kIwtUVWMU0Iy4rmHM5/E9kCDzCYjDhmV0KA5PDaTxPEiwSbjPfauiGHcV?=
 =?us-ascii?Q?kbYldwS/bVQCSbXPcT6+YYEFXyRu7mKMCjyD/oJkxKv237xeFc9PsBeygJ2Z?=
 =?us-ascii?Q?iLMrCoaTXiYcDOJo2Qx3L+F9TalQBLM2gX6ndc4P2tVnPdSOO4mIN3257nWq?=
 =?us-ascii?Q?Ta02buNscBmvsW/lgelG6hU3gf8ceN3TVA/voznXHEV5pwmMzxW6Gjz1Gh+m?=
 =?us-ascii?Q?bkzgyIHOezjT6NRWS0XQs2HJ/4hEYuZCTQmBL5I+kkx9lDrC5sW8ScPAltu7?=
 =?us-ascii?Q?P7tcuyO8rviUgKnPD2EABHZgtGfmWBYm/cv8WXPgBFPpCmAUcbRw/q3OACjA?=
 =?us-ascii?Q?W/24WoZzzsDsZufKM9PZ6i3vIVeLc2JNgqcv3+lbErJsUA1A9fgo320JnIEc?=
 =?us-ascii?Q?EcxnECiFzS267u3gYJDQk+yMW4x0iKOmPNOH2qWZdc3Dc5dWJ5GeYBFZNI8x?=
 =?us-ascii?Q?r/O5qwQHNVx7xweT79N4VCWLyVMVxu9P2nJKmwFfKujJwHh786cC4H4isqnh?=
 =?us-ascii?Q?PznG8gPW1IjgnpZyqXbQP8j/DtQYmPQSZufMw4pfJjRhBFsTG3+LpqoxQa2u?=
 =?us-ascii?Q?ZighdOEEN61HYEOTrK8ep0iu7MfXgR4ikMaeg6OZipqlcHb0NP+rQ70/tLQR?=
 =?us-ascii?Q?FNKCuKmjRiHBY02NcjXhOw756HMeHNjaCBJHBP6IJhWqv84/BBLXQrkaX6sx?=
 =?us-ascii?Q?iu6qjvynunMSlgS5WryPMWdckEn2+55fE4vTDeehctsl3OWzcUQ4B29dK4Fs?=
 =?us-ascii?Q?OyUY8hgIb4Ru7sTZawby3728rG1g9MueJs28Vbs6FgWm7a7q7ru+Wr4PD5ju?=
 =?us-ascii?Q?bcEhrRfbT39+/SDhpSCcLHjyYyEaF/eaPIvhYFOVcN8HvznRxEyN/UdBdn1i?=
 =?us-ascii?Q?A9XKiFvgfpFI+tDulpl+K20EoFAgL5XbfVlAlUEGt0Erk/tGyfCR8Xk1MnfH?=
 =?us-ascii?Q?At8Z+jbSMnIeufM5jzPL3WHKpkouPjdlaYdal/PJxNlMemBzrIOMxLur2gIT?=
 =?us-ascii?Q?gE2u3wSRUP5BGj5Ohl2SoAqtm4vkF/G3D0Qtht6XgWZVOpiwKvs3oSqQLfGL?=
 =?us-ascii?Q?78wstthVeghtEq/d7UQY0GRmcCnRY3bRTgiZ5F+xlDZlzotfmv/2bhk3pZ3V?=
 =?us-ascii?Q?mWUTi3a/Lt7l3i2OKtNLx04o3mbCdIJzNnDMiUsUFbY5WqYSBBALKp3i1at2?=
 =?us-ascii?Q?zOtzU544HFkfc06nUnBh0Lmo8gCAzhb7quZFnxCLrdvKLAT5poK1+mTt4lDU?=
 =?us-ascii?Q?ZgheVwTCpWNTkm8IfHUZguvsqP9ea2pBRcKDgoSc5Pdl4luRaaih8nPvopN2?=
 =?us-ascii?Q?VDyZMkjKohT5ZIrZiI1U6Eo0ulVbgjtJNE1El7Sf9nDNtN/3r2L7AkxNHA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:43:27.4166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa66390-5dbb-4d38-f85a-08ddaca97b59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

On Microblaze platforms there is no need to handle clocks because the
system is starting with clocks enabled (can be described via fixed clock
node or clock-frequency property or not described at all).
With using soft IPs with SOC platforms there is mandatory to handle clocks
as is explained in commit 60dbdc6e08d6 ("dt-bindings: net: emaclite: Add
clock support").
That's why make clock as required in dt binding because it is present in
both configurations and should be described even there is no way how to
handle it on Microblaze systems.

There is also need to describe missing axi gpio clock in fpga-region.yaml
not to introduce new error when make dt_binding_check runs.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com> # fpga
---

Changes in v3:
- Squash 2 patches from series 2 together and update commit to cover it.

Changes in v2:
- Add fpga region patch to fix issue which was introduces by this change
- New patch to fix reported as issue by the second patch
- https://lore.kernel.org/r/174954437576.4177094.15371626866789542129.robh@kernel.org

Based on discussion at
https://lore.kernel.org/lkml/20241002-revivable-crummy-f780adec538c@spud/

Actually this shouldn't be only targetting GPIO but also for example
xlnx,xps-timebase-wdt-1.00.a but I would like to check it first on gpio
before starting to check other bindings.

---
 Documentation/devicetree/bindings/fpga/fpga-region.yaml      | 1 +
 Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
index 77554885a6c4..7d2d3b7aa4b7 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.yaml
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
@@ -316,6 +316,7 @@ examples:
         reg = <0x40000000 0x10000>;
         gpio-controller;
         #gpio-cells = <2>;
+        clocks = <&clk>;
       };
     };
 
diff --git a/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml b/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
index 8fbf12ca067e..7af4eb2d1858 100644
--- a/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
+++ b/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
@@ -117,6 +117,7 @@ properties:
 required:
   - reg
   - compatible
+  - clocks
   - gpio-controller
   - "#gpio-cells"
 
-- 
2.43.0

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

