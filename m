Return-Path: <linux-fpga+bounces-754-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65070993995
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Oct 2024 23:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A88F1C22284
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Oct 2024 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708818C327;
	Mon,  7 Oct 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WAz1zjs4"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64F74C08;
	Mon,  7 Oct 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338166; cv=fail; b=BiZdWMhJtxeIQV66+/iSmBPuPfRXV+bsbW/OXvwaSMunLtC5GdZBsZzG43ieQ7W+KkwQ/P9EaZDdYcGzqnYzEeUTQ+nGCAZO9nSKmhmaonvSMI7tcL1UZGtE6DJZCRqCIOSLUdce7QyOxekzb7Y5cMhiyMlhy2CV7DfYRPoxhTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338166; c=relaxed/simple;
	bh=oBoDT41jSIGfIMhN6P9kWKl8OStE8Btjk676BQ3/QR8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LGPy2PBQIlFMrAX1QoQsM33mMbFvhNYBN5t87ur+mBzhzjRxBXqGQm3qRLVW5iDAh3vUIBrCUOCFHwlRSjmFwdRZGd9icq7ONXH3DU0b5Jgp9dBoFTQ0q/Vy6/caZToeHHgrdVkX1XdOUCj7L1M+SwF3W6L9UA2Uc79t8UEflxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WAz1zjs4; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBvEto1Zs1HpcxZ2BAyC9Q6L7y7e1LJ+c0FU9+vjePl/TEvyXN1ID1GQ36HogGkU8EpTPsfjvXzsBj23GO5pEGS7uzHEUuEqTXZT3Y8nDh8tEE/fmm/Oz5SOyLboqWnUSucNjOSJYCgYL1p8fdVIwCnMoon+dWZPD47vQ2vJbVVHDZj4tt+bubiD+FoeXyPvtCEKfr7a2oQDlotkIyKKiKnZLe04FwUpDjaMXv66/BN2QHEf6VzD6XFbZ5/XWScMQaiz5UneXUo4fY0ga7Ohb39XPXdKRzRs4U691uWjrS/YUDtylva5n/oFNWtzwkU/haVmBdhCPUb8vRacZeLe6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA22WYSY2GHKbtmYrDwGIEXYqk40U7AuVH6NSg9rt1o=;
 b=Q/BeopiOKH0qBnatD8OljHOnJqL3bpJmSy1r+rXC2n+j/lGtKvzmDd8Vtz1xQTbNa/yINGdlqw6BVC9tl9uSMfKF4QXGH8OC5L0JKQY2/lsdtAev8TxXBGHrNaUk4scKbeFiaNpD04gVvFwNk9AtotI5pvs35UDXt1elujcmIik6Epm6g6fdGn/ZtcrxosCTpUl2+KcY47zrvSQj9qqGM7wNTWTlb0H0d72xa+OFA2cD71JqItzIO4qmxbtcS9ADQ9UsnqOk1Rsji5wx3g51eNl29N4PCiPjiC8eRXOVq4P4Q+T2A/FH+pFkaE6qJWTgiK/3UiqaE6KDPwnoV/p5nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA22WYSY2GHKbtmYrDwGIEXYqk40U7AuVH6NSg9rt1o=;
 b=WAz1zjs44DIvYinTHJ0vS6CusB61VfjHXz7ZBGNWczYuYfmg4HUN7J4tnVgePcssRjoUulTGj6+vU3r7kpNbPiCeuj37MSmIHF3CexGXxUnfKn1lzyZd8Hku4C/cClcUGgYBC9XXni3/pObcydcEhcsH+t5ge26wEBg6RDlTJts=
Received: from CH0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::23)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 21:56:00 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::b) by CH0P220CA0009.outlook.office365.com
 (2603:10b6:610:ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 21:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 21:56:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 16:56:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 16:55:59 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 16:55:59 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>
Subject: [PATCH V1 0/3] Add new driver for AMD Versal PCIe Card
Date: Mon, 7 Oct 2024 14:55:53 -0700
Message-ID: <20241007215556.3023089-1-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e37315-b857-438e-73fe-08dce71ad4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uY6k1uAuXR9tSObArMepYSslAYhyQNWJOcG0FMVbbtGy4gYmYT6q9kvKz9CY?=
 =?us-ascii?Q?9A2GgAwHdMYlPlrXMrW537/O276K6nFrL1kTR6q7mUq6l3lBB8XMPyoTdN5U?=
 =?us-ascii?Q?83ov0nmuSeS0dw3xHc6W65SWF/rMRgQG0bCNbeyoFRzy8eih//b/J4z/rjSL?=
 =?us-ascii?Q?fFce/J6EeDPy8Zf2LcNPyh1722cm8DpJK+Br7LQsdkN+iRgZCjvmNYMZOMmV?=
 =?us-ascii?Q?jIGqbwYwqzQFhZ3O0L/sCMsB4Co8JC4ZE3tGI0mH+Bk/ypNq7lnHQ22fNXQI?=
 =?us-ascii?Q?mFPLcpvzkzMysMD1dHfFk+chpAOoDpyx0ZEbcxa/2Z3+BRc2eLD94/f7XLeY?=
 =?us-ascii?Q?7rT0I0fC3O5iVDcODyWXfjjMrGNhzi/hchK9AdVBYjRzcIIGT/Y8c5QoHgtA?=
 =?us-ascii?Q?pgeDTzG9QaZ6PChlD4ilCOKYhfFvwZ/haKa32W0/a4+p070ya6BiNgJslo2f?=
 =?us-ascii?Q?mBch41bjrQpGIWEwHkd/IM/+OTTq0NaWFo3xKf6l3nXho86Wo+MdB8Z47eML?=
 =?us-ascii?Q?ROvIW+Gpua/LRXR4VRYNgl4epMQNEiLeJjAjNwRXuwhMfpkSc/F4yBi4BabR?=
 =?us-ascii?Q?enZprI/714zxBw9s4ptoD9XPm1BTBT5E8H2EiluGq1KMyxgERW2dBkrKUiLS?=
 =?us-ascii?Q?mqqFMAc//ylk2A1G5kBmDX7rD8EJnUEbZasm4EKCbUFq/ySQiF24tC4lA+TA?=
 =?us-ascii?Q?If3rkKrF9s+Wd99A6MaSIfYzDxsQG0lAdZ7J4FFGJJ/0bLl6YE6CXpqmMdzi?=
 =?us-ascii?Q?GWptXh3yAlqIqbWcs5OXYDMioZiO5g68bCIvs7+9GmZFtEnluNK/HqxfJxEj?=
 =?us-ascii?Q?AtZF5s9LTgfm5vmODCPiPqYAE/45DTzhDAn5Bk2F77KCC0ruGx2w5wCrXrVW?=
 =?us-ascii?Q?0z4U4os7dPbNtn3zQjmVssSMHgZSRARVh0ymooPYHi3oVcZdAeyH05lu8zIy?=
 =?us-ascii?Q?+OxY5VMQTxp4FGg/kAcoT/hlSo2KOnGQA72fc6CFfdBOWmODqoj0TiNKA0D7?=
 =?us-ascii?Q?dSnYJkLYw/v3QWqXJOkqT6vcuFiH6YLilsFUSPFgc8to8ZZ/mY7Of9mfJt6Y?=
 =?us-ascii?Q?qRU95i+iXOynhEmyydDZR8fS5ViXmvt4WgtIpfDNc8R7iJSUTr/Hh2UeRX9R?=
 =?us-ascii?Q?gy80j4kAD82p8+JCL7oiLqt8o7VLWqbT8sxE3F/+hZc6PTDZNhY79TLxLnPR?=
 =?us-ascii?Q?3P3mPq5PI0JRTPGgT8TtMLCPk5Xre6Xn1K1tAfczXHVSHhmCfcAwyLvaOvEx?=
 =?us-ascii?Q?aVPEj50hLMc6SWMLF2xvvURfVM8dY48K9KxwqXJ0TdYmHwxMF+Wpgv4p2omk?=
 =?us-ascii?Q?8rawcL5XIAISh87AvOqroIf/0pFt1bLlzxJjosbEFz9yLt+Joohs8QTgg1J9?=
 =?us-ascii?Q?C0lAwDiKVL1cgAgdRt6ovNO+dEKC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 21:56:00.5541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e37315-b857-438e-73fe-08dce71ad4e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034

From: Yidong Zhang <yidong.zhang@amd.com>

This patchset introduces a new Linux Kernel Driver, amd-vmgmt for AMD Alevo
Versal based PCIe Card. The driver is based on Linux fpga driver framework.

The AMD Alevo Versal based PCIe Card, including V70, is the first Alevo
production card leveraging AMD XDNA architecture with AI Engines. It is
designed for AI inference efficiency and is tuned for video analytics and
natural language processing applications [1].

This amd-vmgmt driver provides services, including:
  - leveraging linux firmware and FPGA framework to download management
    firmware
  - program additional bit-streams for AMD Xilinx specific hardware
  - communicate with PCIe user function
  - communicate with firmware running on the PCIe Card
  - monitor device health

The driver is licensed under GPL-2.0 except for UAPI header which is
licensed GPL-2.0 WITH Linux-syscall-note.

The firmware and bit-streams are distributed as a closed binary, delivered
by AMD. Please see [1] for more information.

[1] https://www.amd.com/en/products/accelerators/alveo/v70.html

Yidong Zhang (3):
  drivers/fpga/amd: Add new driver for AMD Versal PCIe card
  drivers/fpga/amd: Add communication with firmware
  drivers/fpga/amd: Add remote queue service APIs

 MAINTAINERS                       |   7 +
 drivers/fpga/Kconfig              |   3 +
 drivers/fpga/Makefile             |   3 +
 drivers/fpga/amd/Kconfig          |  17 +
 drivers/fpga/amd/Makefile         |   8 +
 drivers/fpga/amd/vmgmt-comms.c    | 344 +++++++++++++++
 drivers/fpga/amd/vmgmt-comms.h    |  14 +
 drivers/fpga/amd/vmgmt-rm-queue.c | 378 ++++++++++++++++
 drivers/fpga/amd/vmgmt-rm-queue.h |  15 +
 drivers/fpga/amd/vmgmt-rm.c       | 543 +++++++++++++++++++++++
 drivers/fpga/amd/vmgmt-rm.h       | 222 ++++++++++
 drivers/fpga/amd/vmgmt.c          | 696 ++++++++++++++++++++++++++++++
 drivers/fpga/amd/vmgmt.h          | 103 +++++
 include/uapi/linux/vmgmt.h        |  25 ++
 14 files changed, 2378 insertions(+)
 create mode 100644 drivers/fpga/amd/Kconfig
 create mode 100644 drivers/fpga/amd/Makefile
 create mode 100644 drivers/fpga/amd/vmgmt-comms.c
 create mode 100644 drivers/fpga/amd/vmgmt-comms.h
 create mode 100644 drivers/fpga/amd/vmgmt-rm-queue.c
 create mode 100644 drivers/fpga/amd/vmgmt-rm-queue.h
 create mode 100644 drivers/fpga/amd/vmgmt-rm.c
 create mode 100644 drivers/fpga/amd/vmgmt-rm.h
 create mode 100644 drivers/fpga/amd/vmgmt.c
 create mode 100644 drivers/fpga/amd/vmgmt.h
 create mode 100644 include/uapi/linux/vmgmt.h

-- 
2.34.1


