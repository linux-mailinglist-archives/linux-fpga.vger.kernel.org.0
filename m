Return-Path: <linux-fpga+bounces-579-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4193293CE3B
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Jul 2024 08:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC44B282A9B
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Jul 2024 06:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79108176226;
	Fri, 26 Jul 2024 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z4KCQkBs"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95187208DA;
	Fri, 26 Jul 2024 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975913; cv=fail; b=ma6kTbOXYGMFjjs4BYNq72fHTaY/6ua3w0sIxTDc3Huz9TpXkJSn5fD9zBn3YNB8KD9EMErBC6pS+sn59uV1MsWaLR9VENUrjZR3DTeXGo56BqZqFthLMTI2vLzdpNhhsxojf5+XTHUxn3Hzhl980bayZgAki0OvM4fIiSb3dx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975913; c=relaxed/simple;
	bh=TT6rmYnZ2bz54K2pN1HCrBYH+dh0DR0PY01SwABjH7c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MfpAiczoAke6fQWHfEJciBIoE9Rryw6hu0JXP2Ao+Jy0KYOv6/lNljlbun/osmpVJsYEWC3sujaxTpYfg1E3HZV+EiiIDLTLevh31LdmG6Jb1Yp/odeyTHGCK+WqEVAKVrwlv2YNaciAu8spN6I+Xf1RKAU/A6Rj79aBo2Eog+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z4KCQkBs; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf+VGWqVN/v9TDazcps/nonBB0ClkpQIk85pCIvchQ4goukoNcHFWQgMqadFjaUEWVfKtsX2ydOKAxOs3bbmCPDR68IsexlYjuYq765Mll7cKmjVk3w6vpcubRZ6Rh4Wf6jKLTyRJUzMOeg5kJLaIty4W3ViW2EtGvg62GV3TXIXFCvpYt6k2atta25N6kxoInsCdV/zN2cPLBw6GCymS1Bh1tpMKeoPIhGDDDWfv7ue+kG/8ypF9+KUK6sE96K1YjTQZy+E80GJ9bWnqMZetVlMwXAHLKjGy7md/jqMLIhVvN6/NgAtq33+aHB+FrAXjQKVTRJClNV+PA79dCT0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=685BShBWpl3qz6d8NVHNDjdSlgSkpQpZ2AggbHHAcyM=;
 b=jo4uQQfnBXo/svPlfuCkwt7kEZi9SHLwjSxE8Q24avP6yh+4z21kJX0/JdfdjFKKH4SgqhRs1Qk+ndRsglceeU6swSVy2+m1aUFbysyDlFSOdun8HjdWt2S4A9gGyqSciRvGpC+MEKPfQ/fPZRD0o/SPL5UVT+r3rJtL3gkSrdC0TdAj7zhvUc3Npi1Wqxbp4xHjgA8aQSfGE8QJdXRHWWdeaqCIjLiE7NOwsO8+7+P4c3H5Gruk/FAD1Sx9cltulbomzQ2eysLMFB9hmcM44lbUdtLi45spafGLqs1pCDi+e4bq93/D1jkb7QOSqShh7fBSdT6PwCfjDmUg7TfTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=685BShBWpl3qz6d8NVHNDjdSlgSkpQpZ2AggbHHAcyM=;
 b=z4KCQkBsEnAeOsjLaHUN9EdbfSCS7EFJR8CPx5zuLhRLPVlqt2QHVHPXVDl5Ed0o6Ye30nJ/8fUAZNFt47fC5MFWDdS/7EDiI3wpSz9dmUBB7o928c+vgbx2FqTCjkyEw8iyJvys1Klu0OK2V/AqZ/q8Wf9xgtPmviYgPVhRcOQ=
Received: from BN1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:408:e2::13)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 06:38:29 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::c5) by BN1PR13CA0008.outlook.office365.com
 (2603:10b6:408:e2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 26 Jul 2024 06:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 06:38:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 01:38:21 -0500
From: Nava kishore Manne <nava.kishore.manne@amd.com>
To: <git@amd.com>, <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<trix@redhat.com>, <robh@kernel.org>, <saravanak@google.com>,
	<linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [RFC 0/1]Add user space interaction for FPGA programming
Date: Fri, 26 Jul 2024 12:08:18 +0530
Message-ID: <20240726063819.2274324-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 217018b3-bbfe-4e83-0d44-08dcad3d8f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8RlPwIxqhNYDB/xZTu+jmFBh2kEpJTMJWDFRhgS7NFOe/iP345kpta4PqrW?=
 =?us-ascii?Q?hBsz+nMcr55HwsKr76sGCZ/Re7MT3E7MK/5f4PYN8m7NRLq3qSydr/yhPmeK?=
 =?us-ascii?Q?NoeGtlvJliWfcHCDGWRVMQx0vMhXtmeLRvvlJPU8dtFgJuSc50ZIgTLhSOsA?=
 =?us-ascii?Q?HVb0mMvy5RFGge1O0VXljsgjUrcfzyJJvzoT7ofo5aF4lnvjh5zdLt1s9lSX?=
 =?us-ascii?Q?5fvOKwh7ntMhCRDe4gkM340Z63sAT1NPJnvNsJ6/Lh65m2Q52eWfgponQ4VR?=
 =?us-ascii?Q?sgW7NDnKM14ZniH0OsDJKKFskzb5J98x50wZgX8z8IwCQ7nx0OnR2TeXkH1K?=
 =?us-ascii?Q?nL2AngH+iHvP8xuYrKiot9UglLVlUTLo14wDPrFgv1BOSCE7c15/pmlBleil?=
 =?us-ascii?Q?NVTlzBzUXqihXreTj8IpzpTOZ/IXR1SC/3GWn7jbMsSMRgh7uC925IviNHGC?=
 =?us-ascii?Q?0P5CU8wXGMcwwzfa9xM8PYRTAx3Ctl2H26V/RsbRQHCLw94LtniXaL2EJ0BU?=
 =?us-ascii?Q?qG7HMNglP8s7iN/4vSHGRdtf/oToHO2QB29O0rJWWf6Z1CT91J2uRmOVl4cy?=
 =?us-ascii?Q?rEcHduJpEuzra8h/bqby5pzZEDfSLks0bndy1O4UuzN54WllgL10SUNyJ7mF?=
 =?us-ascii?Q?+dlITkEmpvk53a06Aelzzkgh3P/LrZ/fDZiiYttos2KOpJnJyfFVn2TSifXQ?=
 =?us-ascii?Q?fZ8tJpqb/5JSfrSvRB+SqyvIyHCpXNP8fhHtJ2FbGZgaTRPzyzWkVM8q73VB?=
 =?us-ascii?Q?+ScpMKuXAI1PguqyM8cbkRqh0U4z/qq958mzPZuTqaBaOQItP7V4BxR/y3yA?=
 =?us-ascii?Q?OM5BF1w3OWPL62MYn1zR8gha/W/Q2S+HBsjIp+as27Wdj8xHIoHI2Qe5bkqX?=
 =?us-ascii?Q?YGUuoTTUkXC4JtGfhOFwA+Nw068E7Nr9d/lYMyHEq60UmB345iypqk4QvUcs?=
 =?us-ascii?Q?gzKXVIAYJWh7ZEI2wVk9u3h9LXBQpm1ztgGWAtV0wXunhyjKiDBTMtKPs0Y4?=
 =?us-ascii?Q?qMpG1Gcyg8UN2gpCmD7wiokoMl3VST1/Pv44uSqJtW+5MYrp2ptApJSeyl6q?=
 =?us-ascii?Q?I1CsKLqZQHXJbyQ71eMynL1WdUUUJlGDee29wharyOnuq37ZcGxElc0M+Aet?=
 =?us-ascii?Q?+5JLBZVdVyk9vNLBZl//k/OHhTvZ5ds8U2TO3EEliklwx2n6vhgRI8fAHDq/?=
 =?us-ascii?Q?1HUOZ67WLHyedb0AaHunaWzMk9RIN44IX3b0O0C5NBB0AwXq++GTWUzAx+HM?=
 =?us-ascii?Q?lw2kSZw7mF1qrtEKy6a38TG17DLAKAt5A78Fs7pFZ8ewDyW8C0S6LPfCehJS?=
 =?us-ascii?Q?wWAfac8NkC3dzxV8mdovGCPCZgEXzAmR85WkIoo2cGiulxulftOJsO4lc8nP?=
 =?us-ascii?Q?FjvB/kL7LrNQ/489xWGpKzcbtz8Nr8WQS46dBnQ6+CjtC4unSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 06:38:28.3513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 217018b3-bbfe-4e83-0d44-08dcad3d8f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

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
a new sysfs interface to the user.

This newly added sysfs interface uses Device Tree Overlay (DTO) files to
configure/reprogram an FPGA while an operating system is running and it
restrict the overlay's subsystem usage only to FPGA regions in order to
mitigate the major security concern with configfs.This proposed solution
will not change the existing sequence when a DT overlay that
targets an FPGA Region is applied.
	- Disable appropriate FPGA bridges.
	- Program the FPGA using the FPGA manager.
	- Enable the FPGA bridges.
	- The Device Tree overlay is accepted into the live tree.
	- Child devices are populated.

When the overlay is removed, the child nodes will be removed, and the FPGA
Region will disable the bridges.

Usage:
To configure/reprogram an FPGA region:
echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/load

To remove an FPGA region:
echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/remove

To get an FPGA region status:
cat /sys/class/fpga_region/<region>/device/status

Nava kishore Manne (1):
  of-fpga-region: Add sysfs interface support for FPGA configuration

 .../ABI/testing/sysfs-class-of-fpga-region    | 30 ++++++
 MAINTAINERS                                   |  1 +
 drivers/fpga/fpga-region.c                    |  4 +-
 drivers/fpga/of-fpga-region.c                 | 92 +++++++++++++++++++
 include/linux/fpga/fpga-region.h              | 15 +++
 5 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-of-fpga-region

-- 
2.34.1


