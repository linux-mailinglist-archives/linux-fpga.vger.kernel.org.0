Return-Path: <linux-fpga+bounces-920-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EBF9B456F
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Oct 2024 10:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3707928342D
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Oct 2024 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784C1DFE29;
	Tue, 29 Oct 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RQA3QKNs"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560A2F30;
	Tue, 29 Oct 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193471; cv=fail; b=nGyjjDdDgfUwqpG6j75PtC0BfMWHEVc61sePq+JIhAiVjeDoQ7CYBnE4fO8/eWk1z44IetJcGEELl4m6trGpWEYIin0gHmamYvSN+LIG82aNFVOBdZ8+4BYi2rbSRGled8xB7tx1FHw+3QavMIWRLl2IgdEacS/2YwT+smU1foo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193471; c=relaxed/simple;
	bh=TT2BGtNTfOiqa4lVpN80YA4Ao26MzJAdZvUVadPZur4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8HW32pi4wdJJdgPqNQukMjr/CVDsfWGLtpx8XOaT2aMjTQKn6smWsfBhql6DU8TW6p7Ia1VKOyPeq+UUDnC6cfZdjDzRi62oAkrEvlbnrsiM7CsBwS7YFwdmBGd5waCpkT9jI9ehi9En42zdx9VBznwCHCjPI8fWSzm/z+xEIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RQA3QKNs; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUnjMroTwRXJOTzbXj7rUm6Awe/wlSGRAkWX9dao1s5rzgcTJcPduLtUwwPLhIonzr0T+PqApsJ0EzMbERFhCxQs3tWiukgr7xvDenSGPvtAk3XFms7w7pSucGjWUjDpdmlrKofaJpiyUCS+vQwdEXkRDAIcuXIPsndNxjjuCZw/FBLkeFJ47K1tYP0lOiuO1+bsYg3JoMlvc97W4PflNEjSKqS//f6HCvJqQRhuRXywvG+ets8VveRI07MvUNMqMvMBWM7ZqOLvHFr3Qr40CZ6mYA4lOKuo/EZwV6bx/Axl3Iam+D+ptYjFVHleur2/ZkgpitC4oH1Y8zdP7PIPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VftEONWsHMiD7swvB+PeheJs3r2V1JaRPC3mL9U1JBc=;
 b=QvkN0wansXqiF+InoZ5lYy3WXIMKVLf+buO/rwcFDgKHji8ZWYgxiQfzA/8Si8PllLLwIjzz+V3DE1qrR0psGKNOyYqQ4pmRKZuUkulAvhNV+oXshmip+FH7LtJbCPP/0YzXhngTWw2LNz5Lwyd+otzN5Fl4ZThRaMwsmhR/pvBSRfwR2Iu+1UC92MI9UqNV4q7o3J6l36ZAA8BKnF4In3s02YU/ARcJYVAZUnNOKFVUE8A50H5Xmv82thQlB/y5Ilf7Hi+7c8QZQ7/N3VrZhnrJKJLThIkt0KCpHXhFbBh4wN3+QDA6MjEZWNteMTMaj7Ge6wTCvhsyHb3LU7SAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VftEONWsHMiD7swvB+PeheJs3r2V1JaRPC3mL9U1JBc=;
 b=RQA3QKNsU5Q5aVxxEHn37vjJd0QKSmHzgnp+ZRg/Kp2ucIt0pnNu13Nse67SWVEeapu45M7kyIooZfuDUjMeji+sF8/ohII25xYznEMO2FNBWRXjdqZgXVcn9LKkGCcJxcv9deurtb4tACxseYwy/ZwWyvly3Qsco+1K4bn1GXY=
Received: from SA9PR03CA0020.namprd03.prod.outlook.com (2603:10b6:806:20::25)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 09:17:45 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::a4) by SA9PR03CA0020.outlook.office365.com
 (2603:10b6:806:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 09:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 09:17:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 04:17:37 -0500
From: Nava kishore Manne <nava.kishore.manne@amd.com>
To: <git@amd.com>, <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<trix@redhat.com>, <robh@kernel.org>, <saravanak@google.com>,
	<nava.kishore.manne@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RFC v2 0/1]Add user space interaction for FPGA programming
Date: Tue, 29 Oct 2024 14:47:33 +0530
Message-ID: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 8528ab4f-5da0-478d-2a91-08dcf7fa8bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3JPZ3BYWDVBallZcWRyZlZCUko5T09WU3JnOHgzZlM3QTNxeVdHSUIwbk1s?=
 =?utf-8?B?WDlJdGc5bGtFY1hVTGE1aldkRksrdWp0ZURCMkhweDhqVStHOE9FeEVTdFI4?=
 =?utf-8?B?YytYc0p5ZE9aUTZ2Z3g5K2N0RnhkQkF0NDB2N0lybGdYQmd1MDR5TFRCRDVT?=
 =?utf-8?B?d2hFOEZ0OVNiK3drZUlrK1ZESmFVR0FUN2duQTQ2cFlzZUYwWkYxL2xnR2xt?=
 =?utf-8?B?OUVKV3ZkRDArbVhlcVhZbVFPYmN3a2VsWStpQ2pka1kxcncxWEZmVm5GYXc2?=
 =?utf-8?B?akpTVjd2eU9SRzVmYkZuUHdsYVVBc0ZhOTU4MTcySEpienJTQkFraHZEZXFx?=
 =?utf-8?B?MWpLUGFsZXJTeU9weU9jQ0QzWmRlZ2pobkZtMmNxcXFFWW5QL1dvZ0hTamVq?=
 =?utf-8?B?L29ySUNkR3NTZUVybmhxdEwycEZQN0F6QUZ0b1NqRHQyVHdkRkFzNzJRQVpG?=
 =?utf-8?B?R3AzYXBIVUczeW5BVHlDZGhjT0FYd0dBNXhUb2JlcHc3QmJNTklGbExseTBT?=
 =?utf-8?B?NCs0L1RBNDdSV0dsYk13UFloTTA3VElwc090R0s3S0lnSG43ZEtmd3VqR3RN?=
 =?utf-8?B?Y1FTbEwrb0g4UjBJSTJ6WXhZL3lXZXpLNEQvNmpvK0U1dmxYZ09ydVVTcWtn?=
 =?utf-8?B?SFpxNkk0enJnRkg2QnRQZ2Q1TDV2NUcyVmhDN3IyNms5ZmxIZ0VCaVJxUEJX?=
 =?utf-8?B?bUZubjJwNUk3MHc0YVF0ZkF0TXR2ZkR5TEFVbytDV0ExbEhwMnlNM3F6QVl2?=
 =?utf-8?B?TUVJenVlcnM0Q1B6YzMzYittY2lnWmo5QjRsK2Y0Yk5JUlB6bWwwWWk4WkNI?=
 =?utf-8?B?YVVuUFBNUHVvMHhseGNsTG0wbUFjblFEZHNzcDJZZTdCMzlRRmpJVVpjdGFl?=
 =?utf-8?B?c243eXRyVkVVbzJLRVpmdVlVOXdLNWsyWGM3RzE2aDBneDltU01sVGI1MXRi?=
 =?utf-8?B?SzQ4S2N6RkdPdUpGZngrSGI3d0FWYjRWRUdoZytwSTlHcy82MDVYZHlYMUVG?=
 =?utf-8?B?TGdDTEJQVUloNWxZL2Y3dHRCb3NZeHBSdEQ1QjlySkV2c1FQTVdpckRHWUlx?=
 =?utf-8?B?NDgzZkxsYTBqQ3Q5dHc3Y3drTi9FejJrNkZockNtRTNra3VOMUZ3VzJtRWhq?=
 =?utf-8?B?NzlMREtvSXpOTUhNYUd4c200WUlpNG9Dei9vRkxjT2NzMkVacGplMTQ3NFBs?=
 =?utf-8?B?WEtCL2NUK0hXUFIzU0RNNHpDZzBPZzZZQVZ5SEJtOXZOZUU0TlM4MEpDVjJW?=
 =?utf-8?B?ZEFxZ3lTZlVPaFU4VklvNWdaNEROcnJ2QjNwNUtMSWFyWVVYaVFYdXRUNzNr?=
 =?utf-8?B?Q0QwbHRjZFVuYmNtOHFaSFZEYXpGZ2lQcStkNWRqOGx2KzZQUGE1RnkwY2kw?=
 =?utf-8?B?bVoyeDUzVFBZTlNoYUZRZmpkWlZOajI5OERvS0MxOXpzK3dTUWR5MHRmUTFN?=
 =?utf-8?B?RFZkTVhzNU5Vb3p3RHNXNFRab0Y0QU9pR1JQY25tdE15SnY4T1VhMVpvZjg2?=
 =?utf-8?B?NWk1amo2WkczSndtNGx4S1I0L0E2UjE0RGZjT1k4dGlQRlRab0t0MjZDd3ov?=
 =?utf-8?B?V1Jub2RNQ25IdU1qZmJ1OFhBTUxOTlVLSWRXSUVQMXAxYVJoMWtuM0NoNnph?=
 =?utf-8?B?eDR3cWlBUk1xWGNIbHRWMUpRODRYTEc0dVdkbkhzRzUrdG1JTm1xTmNWUlUw?=
 =?utf-8?B?ZEJ3ZXlCNFNzNUZXTUc4REFCYnZUZ3hhTUZBbG4vLzdJRzlhM2ZDaksrd0VI?=
 =?utf-8?B?VjVWdnByRGtFMEJuNkhuR0pGVFdkYTRma0J1NmgxY1YvTUNXQ01mTzNPMjlQ?=
 =?utf-8?B?dnk4WkwyK0RaZVF2TmZCSENMMkNRWDJrVlBQdDdSNXhScytBZ0dnMWxFMmJn?=
 =?utf-8?B?bHZ6ME9HSzJCZEdqSEVlR1hUSi91M3NzNWJ1d2M3cUlpVklzWVpaT29JZ0hr?=
 =?utf-8?Q?x+YTRaoZvb0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 09:17:44.0250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8528ab4f-5da0-478d-2a91-08dcf7fa8bea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727

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
a new IOCTL interface to the user.

The newly introduced IOCTL interface offers a generic and standardized
mechanism for configuring or reprogramming FPGAs at runtime. It supports
both Open Firmware (OF) and non-OF devices, utilizing vendor-specific
callbacks—such as configuration+enumeration, removal, and status checks.
To accommodate diverse device-specific configurations.

This solution enhances FPGA runtime management, supporting various device
types and vendors, while ensuring compatibility with the current FPGA
configuration flow.

Nava kishore Manne (1):
  fpga-region: Add generic IOCTL interface for runtime FPGA programming

 drivers/fpga/fpga-region.c       | 110 +++++++++++++++++++++++++++++++
 drivers/fpga/of-fpga-region.c    |  91 ++++++++++++++++++++++++-
 include/linux/fpga/fpga-region.h |  32 +++++++++
 include/uapi/linux/fpga-region.h |  51 ++++++++++++++
 4 files changed, 283 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/fpga-region.h

-- 
2.34.1


