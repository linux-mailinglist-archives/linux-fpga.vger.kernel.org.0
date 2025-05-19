Return-Path: <linux-fpga+bounces-1212-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A0ABB3AF
	for <lists+linux-fpga@lfdr.de>; Mon, 19 May 2025 05:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F6A7A8AD2
	for <lists+linux-fpga@lfdr.de>; Mon, 19 May 2025 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE91E3787;
	Mon, 19 May 2025 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I68hyIRT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E2A2D;
	Mon, 19 May 2025 03:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747626183; cv=fail; b=VSBXP+RCGc+qbvoYPJl2dlludLJw/zyVbp4Se30XaDzXPCagq/KxqOxSG0bEINy+WxFbtfrP2yNF9hEmOEwEuj2nnoLDiBz722CaNDYuDAwn+vqHiOTDiPDn6wQlD8oG5dILubarLlzrZ/vIsVN51isc0LY7+2d5weB1Go7IO88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747626183; c=relaxed/simple;
	bh=i1LPmU5uFG1Xszsy4HhRG1xBifj71yx85nXyGuueRrc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QaO/FkmZ5DtIHkPZ1TEgPVN2LVze2s1mHWVwLZwTcXixS4xV5NqLOPwjebCJhuc/CAb1Y3RrBDWCpioONj7No8OlYQjetVBpc8lHHtkDYsp8TkeAFMKI683MtE/RRNCAF0JTYDuJyK4ISCucrHfoh0jiDeilJYVTOXHBV2xcNPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I68hyIRT; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxoFd6tdAlixhIlE27Rw4Ke/4M/6IvR/hutjqP3u47xAaRaI0RNEjyeUyiX/O5SvPsLBlZK6itp3opyE/ilNZ+qZYtug36D4bWpDLS3hqCuIDhA2LnFrzxfTck39Gb3PkpKD+EkNIfqO37QtU7uCw1VBcTiZyKgvZuqf+nY1JTG7vGQe1GKjiZsAlNcxfvkH8L6PWyBk+WpxEpwa0ssQDzSfiF9kfnOD0sIJz9bda20DaikUwSN+l1/9PQ+lOUsV02O0kX9DRk14FmCIEcmQkLmDg3x3F1usarIeZjZFZsmWvpTUmMYCds+niArzEfysilpBRxH2pxjuyXc2ROSOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dICGvBP3MlGER2C4TccgnCnQzIOlvKYOD8mLsIOqJCU=;
 b=QB6MFo1Sqoave31CaJdIh3IZJWHnFEsLHVbIgy6NzKIgAmgy4KyqnrhAgdDEWhkCKX0rquCmdme6exYLXYp+zk5s2BDTpGsaPTD+YXPs+G6IQ+qktjzDYXE5Py2lhoSQkPD6YIhe7ZeR4CTelNINAvsqjD3YRvl2RrAvkFRtXrrQieBYpNhiMsfGLU3O6TYpHUDODeElb6LIsqDZ8gSeGhUytI08X1e5NIdq5JscJ0oQu962Y7qeLevUg01CUfsF0qGK2VRAeFeO2fQBllLVTBuKXG9ssAbZt4N3P3yX20xjEEBYFLISa3vISCGtEYjTgfgxc3ac9PalIHa4hVFZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dICGvBP3MlGER2C4TccgnCnQzIOlvKYOD8mLsIOqJCU=;
 b=I68hyIRT2ALaMLj4uB1gLOTQIAb0xoHAiaJiN9Gfw9Z8R7MGZdDNpc9/WPj9ZiGcK6w5bOLhWRhJXcsm1HAZqHhIKlM24+YimGWscGf5Rapp932LfQ/1vtAh2gYWODi2B9LpFVPGjKhc2L0QdIOgHbr3+tzxday+62966Lt9pio=
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 03:42:55 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::68) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.13 via Frontend Transport; Mon,
 19 May 2025 03:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 03:42:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 18 May
 2025 22:40:01 -0500
From: Nava kishore Manne <nava.kishore.manne@amd.com>
To: <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<trix@redhat.com>, <robh@kernel.org>, <saravanak@google.com>,
	<linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <git@amd.com>
Subject: [RFC v3 0/1]Add user space interaction for FPGA programming
Date: Mon, 19 May 2025 09:09:36 +0530
Message-ID: <20250519033950.2669858-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="N"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: ef490fb7-98b2-4480-7800-08dd96873d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e0vD4WUWioqp3ny3Jhv4WL8ezaBbb22OE8C8YjIicsJkm2p3cX2Pf3B62A7G?=
 =?us-ascii?Q?BNCtzgYoOTDdwvlzU62cShinBLiYFQKf8TjB9znpFoVz3KGZm/PcfpzfiNG9?=
 =?us-ascii?Q?h6Tv4I3F7B+bOgrzTnuII+1hrUMqVYSOA9rWf6NZkUpdbC6GbjbOXLvgLfub?=
 =?us-ascii?Q?b2quQfvdI1OcgY1jXsBtxIQczvQ+31/h06CcCfzMDgPVJSK7n9GKPQ2ImMFV?=
 =?us-ascii?Q?xt+sOKRuHdj79ie0vbdXZX53WV05CK5SpALxhA7GUJRaJO0XS3yvsoGRrQ9P?=
 =?us-ascii?Q?f1HptOSz6AkCU7t9IXgfZJ7uoab0Cbxz977isyJgTcfm+FxC6M1njn8Hu8eg?=
 =?us-ascii?Q?F60wYAidV3xcQNoPSdCB5YKuXj3pOObfDu2Kg4cPwaQoyhAx65dYABapiNlT?=
 =?us-ascii?Q?ajKIHh/fBds1VIoELy9+fRN5uhg38ac6mx0Jm7kPafSlUZpgz+LH38tSfocI?=
 =?us-ascii?Q?CGRXlD9ZuiEGyxy2ftS8fENqs1zSsWVVCekQDzLwt+adT/Jez552XsYK42S5?=
 =?us-ascii?Q?8dIdlp56zYaO1ETFNmGlKhttwimGKvWSyYVGF/Io1nOx4j+nT18nvPAnHEwB?=
 =?us-ascii?Q?Ojo5j+Ry7iGWxqKKIjuOmttjjEoUlEcf563FbnCpSoLDnlTMziETb2eIdtY4?=
 =?us-ascii?Q?ek7tfGDffYJcnLA9YBYuuiIiwajy2Csr5DPvN156Y3+TdJWZaxnqaEUwV5G3?=
 =?us-ascii?Q?h2YoSJQ5hATFbgCyIFVszT0WEVmodUEBUbse/hgXZkA6H/gI/lxYuZb4O3Vm?=
 =?us-ascii?Q?eN0Rgywqakh/MX3WcvM4s8w7uYLUTe+RwU8T0vE/4QkFXPFi+c6zKFoCG1TA?=
 =?us-ascii?Q?ijXrP4cN4w6UHi+XM+aJQ16ZSVNgBZ3Se1rRM9Ydxof2iwiVt5UK8+DllbXW?=
 =?us-ascii?Q?tFq5pd9IWSN5pBCkN0f77IKZqKKQB44uob+FMoSH4Qb6mSG3UqKwbf/Y7jby?=
 =?us-ascii?Q?LOEFbvrpu5Y61mq+Vp1nk8svMnB7F1XeZIyGCJKVVYEhP3SwMEhtB+XM3MqP?=
 =?us-ascii?Q?y5WAHmVC4lI1/XNhPStEMrdK/X2JKVwenZ4pvjad/Z1bdTLSckmcR87TAf1d?=
 =?us-ascii?Q?ew0dvL6SKkc8ngOQKxnVz0rHtxETWR58S022tipnWRa7Od3l+829nZ8eB1Lh?=
 =?us-ascii?Q?TD9JiMMwxi2uXF+rTzYm3u0y/woquI4N978L31uTjy1K+QsabdBzV1igx4hJ?=
 =?us-ascii?Q?aW8r4G7PvKNpzkLtN+aWLohzmgrlbaBdn2qxKmWrL064OkermgTuvi7Jff2D?=
 =?us-ascii?Q?ujwqgyG35MofGowlqVWCd1ZRhVHU8xqEzAVNIvYfZkv32Q87iD6vFG50BWyo?=
 =?us-ascii?Q?uxkPn3cjXGtZ/sWVrjleL1PqJ1EAnegxvTJsT5M39WDaqoTNKlEpHX8hPopz?=
 =?us-ascii?Q?ZcujpoJ7q4jkIkCDkIEjskIahBb01eGUCy04oxfBfc8/m3rCFYYs0bJ1izQG?=
 =?us-ascii?Q?/etgtNs7QDzwrFlREdZFqQB1+lmunDXjzlRUekjKk9YI73B5vGUVr40ijfxe?=
 =?us-ascii?Q?RJybxns0u4RzEP4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 03:42:54.5936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef490fb7-98b2-4480-7800-08dd96873d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722

The existing FPGA manager subsystem didn't have any user space interface
(other than the status/state in sysfs) in Kernel. Basically, FPGAs are
semiconductor devices that can be reprogrammed for desired hardware
functionality.

FPGAs can be reprogrammed at runtime with different types of logic and IPs
as per user need and hence there is a need to use device tree overlays for
removing/updating/adding the devices at runtime for the IPs/controllers
that are present in FPGA. But we don't have any user interface in kernel
for updating the device tree at runtime.

Sometime back there was a series sent by Pantelis Antoniou
(https://lore.kernel.org/lkml/1414528565-10907-4-git-send-email-pantelis.antoniou@konsulko.com/).

This patch introduced a user interface configfs for Device Tree overlays,
a method of dynamically altering the kernel's live Device Tree. However,
this patch series was not accepted in mainline due to various concerns.
For more details refer to this link:
https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts#issues_and_what_needs_to_be_completed_--_Not_an_exhaustive_list

One of the major valid concerns that were raised with this configfs
interface was security. It provides a generic interface (Not specific
to the use cases) for modifying the live device tree.

In order to configure/program the FPGA devices, All the major vendors of
FPGA are using this configfs series as out-of-tree patch for configuring
the FPGAs and there was never an attempt to introduce a generic interface
to configure/program the FPGA in upstream and hence upstream kernel ended
up in not having proper support for FPGAs configure/program.
This series tries to address this gap of FPGA programmability by providing
a new ConfigFS-based interface to the user.

The newly introduced ConfigFS interface offers a generic and standardized
mechanism for configuring or reprogramming FPGAs at runtime. It supports
both Open Firmware (OF) and non-OF devices, utilizing vendor-specific
callbacks—such as pre_config, post_config, removal, and status checks.
To accommodate diverse device-specific configurations.

This solution enhances FPGA runtime management, supporting various device
types and vendors, while ensuring compatibility with the current FPGA
configuration flow.

Nava kishore Manne (1):
  fpga-region: Introduce ConfigFS interface for runtime FPGA
    configuration

 drivers/fpga/fpga-region.c       | 196 +++++++++++++
 drivers/fpga/of-fpga-region.c    | 474 +++++++++++++++++--------------
 include/linux/fpga/fpga-region.h |  34 +++
 3 files changed, 493 insertions(+), 211 deletions(-)

-- 
2.43.0


