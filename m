Return-Path: <linux-fpga+bounces-978-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025D49EB96D
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4CA1631B9
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FE5195808;
	Tue, 10 Dec 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XiUogtck"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450C3C17;
	Tue, 10 Dec 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855879; cv=fail; b=rR4bBIsHgukZO+D6DoC5SNec/MXYhq3QYF7zTo1kufPh14yjKsQet98TbsGluJgQwf9c5fPLyZkIzT9wHWN1/Lr1kruV34aYs6czEtjA9Kmzreb7sPdasvRRN7fQqBtuzj+VHjkbtz25TudFiOsQd1u8C0QeMuWQerzuPUmQxsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855879; c=relaxed/simple;
	bh=qH8J3YyRP8HwiipVYl5Xd6q5f2YaIPvHQcF3aCsCvFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=teV0SmzTyoeB8hCwSvmP1XTX8JeTCPdXZ9cSC6/uxITDG1JSNsbLcA0uNgbIHBMuUKHdyzxhBVChOlJt3Pg2uae3tCBWGQ1P7vbogpTlP0BWCzLzu4xBUapQ6kZUoPo0YuntreARHUrp8w3wio10LrR+mjMWzgja2dDTjk1S4MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XiUogtck; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebxrMpSODSYP5aHmZaVS2LPcP13eLs1ZV0cVP09ikr9hxcX/OwkE0MNmZ7ygxJXBUJZFeE6KuSDfuT3bEhFRji5ZBbRghpE7z42H/ev5BBW6tuYtwmS4sjYkp/86UMJRHo6F+xXavroczE0Y5IKyfe1L092DsPpg1w1saYZL6aM+mf4GVfNxVl9dgQd5Desps3IuuHBxO4/aBwc7ryHNv3Z0xuYq5ADROaFbFYoU/YsvvIY+xhtcljzo797OTISjmlcYLexMBm9afS9NkBRaGHyBWpvxXRZCJ3Sg9fGt3G8b9HzlAKsSMAZ9r0BhCEB8zzopTRRtWxK33gYfzwlHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++RylFbDotABiGTLHui+DaUDzH0QUPUW1WCu4uD+eDc=;
 b=RuP1t937H6hmUiCoZYolc4hKZUKBzKGW/3XyN6vF/APJxY5PD3xmrCpl3QM+Tb3BcG+FWsPDDFCin9nD6Ws/gmwDts7ZfnmaZDhBQqudOyR9XB/GG3z/KJHAwu4VrrhvzlAJKZfMeMgXQlfmda7v5+/raGv6kcEgOpwwaugiKqguSVvMy/1jX9LEHRHIJzNpkwuH3c+tI5Mryt3EMAIqoacqj9RNJxVJtvRifk+IS/+/BH4GUXy7WgoTIpL9/d0zBV72dKBsrAClTSlI07By9wUNB88wZ7KlCouz48p1TAAEGOGRO7p2wdXiMNyV2VBvqElOaZ41xTQv+9HhpQ84kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++RylFbDotABiGTLHui+DaUDzH0QUPUW1WCu4uD+eDc=;
 b=XiUogtckq7nuIatGNKZaGgcB3Hj9D2ivffVq3k0QUTqiDvbXf81lKnOFiTqSiaYILE0+mrjvov73DteLjvAo+n2EYck/sg4iZdmvKCVx1QZEtuMY/QdZQcPo3fl+hdHlk1pOVxTpiFZXSvS/x2iiN1blGtjgLNhgs6Dnj3+mH3Y=
Received: from SN7PR04CA0232.namprd04.prod.outlook.com (2603:10b6:806:127::27)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.22; Tue, 10 Dec
 2024 18:37:52 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::17) by SN7PR04CA0232.outlook.office365.com
 (2603:10b6:806:127::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.20 via Frontend Transport; Tue,
 10 Dec 2024 18:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 18:37:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:37:52 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:37:51 -0600
Received: from xsjyliu51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Dec 2024 12:37:51 -0600
From: Yidong Zhang <yidong.zhang@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>
Subject: [PATCH V2 0/4] Add versal-pci driver
Date: Tue, 10 Dec 2024 10:37:29 -0800
Message-ID: <20241210183734.30803-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 47983b06-3803-49c6-70e3-08dd1949c19b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NPBa+ToSEuCCTaAH6rOydUtTHhjY7TJbhzL1Br1LDrxG2Vuz1vp7SoJp4tDw?=
 =?us-ascii?Q?Vte0+eVyUmPgWFyZ5lvsw8LCRk6A4g+ivJX5xKAV++bSUBWzm23J0NxJzLBb?=
 =?us-ascii?Q?jVdgLgGL9sEWeU3z0fj6blXt2+7LO5YHAej6NyO2yGbSrW0SHV2naFJb4+vC?=
 =?us-ascii?Q?rphxCGo5YmV5yOcl7RWRPJ+gd/1IvN7oIFUKO0wvLB9Myg3MQ3x7ci+XU105?=
 =?us-ascii?Q?cNEJ3J8RkntB6Cc0bIvncesowd8R6r9ytGC+nVDDKap5BRSG8dKwlgohVf5A?=
 =?us-ascii?Q?67cDDcAQoYX+AK5nvj8z/2hjiM+yF9mWPQ6jtgre8ppMcsNLo/VAHHcLsY6G?=
 =?us-ascii?Q?SBVDqtzk3VqhbZ2o397BqAd65dexj6l82eL8Pon6R8sFuVjSvM4kTA4bUGqt?=
 =?us-ascii?Q?gazxovQGlbHTHvilB+dGsobedZsvmXmf78m2FdSm2uLvVt3ZgVl/tZHG2vCT?=
 =?us-ascii?Q?W9FVG4AiTgdLJChiwdi3DKkInWIwjMCNSyeLuYwTeAQBOe0PKpaj2iXAByus?=
 =?us-ascii?Q?t9ATrkKK7/Lw77R1hulT2bdwlB0P2W3xZwuJktQViHQGi8smE7IvNtNCvAZq?=
 =?us-ascii?Q?FWLcrtZj00V5SSbh6SPTjLjdGI5fq+poWRdJ8n1odLZRH3BIPJQ5Bi+4K1Na?=
 =?us-ascii?Q?BCS5rKQ4HQxPziSR6fAMq5pZgw3DLjgqq119lUSepREyqmX60AS34xxdBdC1?=
 =?us-ascii?Q?eIKx3xTYIMbBQu2F28qV/+nW2QLOl+JQZM9HXci2eWuhFZa5WKrD7xvNahY6?=
 =?us-ascii?Q?cdvl8MRxIwCW7VSWcpDUGi6z/hzaYlWG9a/ecUQlEIkIk5Rrasu+UXBiM4PQ?=
 =?us-ascii?Q?HVVzqsQdU/qBt5VKeB+K+lGH+4ZAldHgWMIbs1+JxLkjhOG3TCArOEyXC6KC?=
 =?us-ascii?Q?O98Duv3PJxdzofTTf2LZU5kHNSCaOrA2kyjiEHwG+kHGeJOn8RhGY5UIJxPN?=
 =?us-ascii?Q?CvnPR69/pDp8s2LE1AhMqCqtXvxQDNlGanbACxpMpxbJTyJJdnGjoj8l1ru9?=
 =?us-ascii?Q?pjYcDejGZvLIq3Q1PexEBSAj3kvKU7VadkBEWorfJullPGASFc0Y3N8e9X+9?=
 =?us-ascii?Q?0kYzFp992sDdBbssMSJfqj3u5Us4YcvS9NUmCfOTtDJVkHnroOSO81XDl6fP?=
 =?us-ascii?Q?P4E4DOA5jwJ7a9SCRyPuo/KYGNewTwJjCJDYWAlgjAXpKw59D6WSfgODCN2z?=
 =?us-ascii?Q?qYgZaqwox0Yg/hD2m+Sai+wfXshb6U7bTyyY24H4JVMhvRaigtzrk7xk9yTt?=
 =?us-ascii?Q?vAAERNtoh30szEnlbjBfCTsmZ8ocKM5XD6KkSqN0ZivDB+Kh0rt0bP7yFnRi?=
 =?us-ascii?Q?jXd+Fd6viloJWQvHoRQZtNNJq8QsNVhMsgl1RZTcMp1vcaTCuQ7hth3C0iXc?=
 =?us-ascii?Q?R8mAJmfOthakNX5d1h/lFz55+tWt+L0btpRpW3Yq+/8Kl34MU8i1TQbNdrnl?=
 =?us-ascii?Q?f3FkH+u6PplwtSniNb+bWxDpoSi4MDBg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:37:52.6412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47983b06-3803-49c6-70e3-08dd1949c19b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809

This patchset introduces a new Linux Kernel Driver, versal-pci for AMD
Alevo Versal based PCIe Card. The driver is based on Linux fpga driver
framework.

The AMD Alevo Versal based PCIe Card, including V70, is the first Alevo
production card leveraging AMD XDNA architecture with AI Engines. It is
designed for AI inference efficiency and is tuned for video analytics and
natural language processing applications [1].

This versal-pci driver provides services, including:
  - leveraging linux firmware and FPGA framework to download management
    firmware
  - program additional bit-streams for AMD Xilinx specific hardware
  - communicate with PCIe user function
  - communicate with firmware running on the PCIe Card
  - monitor device health

The driver is licensed under GPL-2.0.

The firmware and bit-streams are distributed as a closed binary, delivered
by AMD. Please see [1] for more information.

[1] https://www.amd.com/en/products/accelerators/alveo/v70.html

Refactor driver to address all comments from v1.
Changes since v1:
- Add driver architecture description.
- Change the driver name to versal-pci 
- Remove unnecessary memcpy in versal-pci-comm-chan.c
- Keep mod_timer because we need single_threaded_queue with delayed_work.
- Change the "comms" to "comm_chan".
- Remove regmap, use base+offset directly.
- Add skeleton ops with on implementation (TODO) for fpga_manager in early
  patch (0001) and add implementation in later patch(0004).
- Remove br_ops and FPGA region, no need.
- Add load_xclbin request from user PF driver via comm_chan service, and
  read firmware from local cached data. 
- Remove pcim_iomap_table and pcim_iomap_regions. Use pcim_iomap_region.
- Redo patches, remove no-used definitions for each patch itself. Use
  /* TODO */ to mark dependencies that will be addressed in later patch.
- Fix memory leak in rm_check_health.
- Fix cmd with error status in rm_check_health.
- Change to vzalloc in all places.
- Add rm_queue_withdraw_cmd in fw_cancel.

Yidong Zhang (4):
  drivers/fpga/amd: Add new driver amd versal-pci
  drivers/fpga/amd: Add communication channel
  drivers/fpga/amd: Add remote queue
  drivers/fpga/amd: Add load xclbin and load firmware

 MAINTAINERS                              |   6 +
 drivers/fpga/Kconfig                     |   3 +
 drivers/fpga/Makefile                    |   3 +
 drivers/fpga/amd/Kconfig                 |  15 +
 drivers/fpga/amd/Makefile                |   8 +
 drivers/fpga/amd/versal-pci-comm-chan.c  | 271 ++++++++++++
 drivers/fpga/amd/versal-pci-comm-chan.h  |  14 +
 drivers/fpga/amd/versal-pci-main.c       | 445 ++++++++++++++++++++
 drivers/fpga/amd/versal-pci-rm-queue.c   | 324 +++++++++++++++
 drivers/fpga/amd/versal-pci-rm-queue.h   |  21 +
 drivers/fpga/amd/versal-pci-rm-service.c | 497 +++++++++++++++++++++++
 drivers/fpga/amd/versal-pci-rm-service.h | 229 +++++++++++
 drivers/fpga/amd/versal-pci.h            |  90 ++++
 13 files changed, 1926 insertions(+)
 create mode 100644 drivers/fpga/amd/Kconfig
 create mode 100644 drivers/fpga/amd/Makefile
 create mode 100644 drivers/fpga/amd/versal-pci-comm-chan.c
 create mode 100644 drivers/fpga/amd/versal-pci-comm-chan.h
 create mode 100644 drivers/fpga/amd/versal-pci-main.c
 create mode 100644 drivers/fpga/amd/versal-pci-rm-queue.c
 create mode 100644 drivers/fpga/amd/versal-pci-rm-queue.h
 create mode 100644 drivers/fpga/amd/versal-pci-rm-service.c
 create mode 100644 drivers/fpga/amd/versal-pci-rm-service.h
 create mode 100644 drivers/fpga/amd/versal-pci.h

-- 
2.34.1


