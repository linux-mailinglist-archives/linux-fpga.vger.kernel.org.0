Return-Path: <linux-fpga+bounces-1241-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C335FAD88FD
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 12:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93C4188D3EF
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4952D1F72;
	Fri, 13 Jun 2025 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eXCEqNn5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F82DA77C;
	Fri, 13 Jun 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809608; cv=fail; b=Ym6EywyFKqedaFQFiUD+Am0cURkFt3xUfnnlZukt5J3NAeEn3hnA/k/yBPhuBlJIE0LV9rAmSQV81OpbZW6tVPWqi+2dz+pr9dWr38A5YVjU6TUo6Ba9LETsh465Sy1AhnKVMp+vx/ulQp11z/QrkDtHQ3nKPV+Q+VeZcWzqYHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809608; c=relaxed/simple;
	bh=MINoeN3gco06z/TC2JzXyFutduygy7Uu5d0HBGxK8hE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E+fGHmHVPDbOpuBW/IAa3VwWGnnqkgPQJWbMaoJmy9Nu9iQsA6kRTvc92W/V9wGzQyQ/7DLa59i8QjkY/SD2c3kEl36vkkxZv8dA2N6FKTiUtAAeF8jHK6xH55EFKKBXMH5r98/mIPuZyVJ1yMSk7DX9/FZqTkkM8xKZzKiyK4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eXCEqNn5; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDvue4un+Vv8zZ2n3TJLrKpzHg8gXRdMqBSaBAkto4kPc6XLtI7nUuVcoKA/P78QYH1vkPBm2lukaKn9Rc8b/y87Ka0G8HgAPifbfm7hwavthn6WIW8/hxHH5LIdpZyTtLVHNKpdt0C4mVAhNJ5UJwCjDV0ptaWJISXB9k3Ub28p0OoJtrNZZhhlnpDx1L+ibE8FKc+skMY41XawhiSmteDhbyVj5ZbmjyRVgvNF/MLYfPgVYUjGZwfWAufSWt/dZwejmmxMZrqtRgze1CIEgMiXwFDSle7xcvka5Xrjt4fhOKc//Ow7SQ/rlw1SntAOtn8yJFwvqHTAAQbc6elfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiQi8+sD1p7rM2Eo+gWGgMw0t0SflrtVITcZWQo7kOM=;
 b=pBf3jqDhhk67ScjP63ItlQbfx03K2I1Csj1hc0eVsIqVr6tmmEt5NBD/RdMQAc6Dijpb7phvjb5X7XvWnhr2RfEwbG8EqdNzrUqPSoDkgROPBTEog7S+5fzVcaNXXPfp32Z0O4Aie3evHytBI2TJ+g91jc1DPqAWTK6Gbv0xLdYeeUOvQgxbjSGnLEZ6Z8++i3TOT6XR3/gIliNWSPo3wfoHMX9kvNO5M5GkVGTgz7K8o/Hyqshw0OGZWTICbyce25zaOZKA1nqASla9m82dbincSailLmqO4fMI2aG4Kr/M+f+vtjM9dvI2mcdcXtQ+2yMILC2ikV32UllSweef2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiQi8+sD1p7rM2Eo+gWGgMw0t0SflrtVITcZWQo7kOM=;
 b=eXCEqNn5r09sDXdn39bfU3OWiwRZb2SghBzMcl4pESBrYLpK4QgH83xXTDert5w8NJa3XF2prxEGP48AT1+jgz+UYWzKwQJI3LuGNXESfAWkrx1EvSIKg1zRNNlojd4EwlnVGrV/Q5SyHlpineuZ+o+jCc3iEkVWFxEeZlMsTug=
Received: from MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 13 Jun
 2025 10:13:23 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::bf) by MW4PR04CA0103.outlook.office365.com
 (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 10:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.0 via Frontend Transport; Fri, 13 Jun 2025 10:13:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 05:13:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 05:13:05 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Jun 2025 05:13:04 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring
	<robh@kernel.org>, Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>, "Xu
 Yilun" <yilun.xu@intel.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:FPGA MANAGER
 FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: fpga: Also describe clock for gpio
Date: Fri, 13 Jun 2025 12:12:52 +0200
Message-ID: <8407ef56b11632c1a7abfce8a4534ed8a8ed56cc.1749809570.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=michal.simek@amd.com; h=from:subject:message-id; bh=MINoeN3gco06z/TC2JzXyFutduygy7Uu5d0HBGxK8hE=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR4/1x6zzJyjXfpOj5W2dtdRqeW7WKb7hmipn3TQ1zxy cop4evdO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAi7z8yMny2kPi9nXuj09Vo nZTMC3kK5zYVVD754D/bvjxkdoNQozMjw9S+yCttzQfPhav84n7T5ZKW8Vz04keOlXrvmnxD7U2 nMgAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: ac410a9a-bfd8-447f-c39c-08ddaa62ee24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vfGnOVs/o87YOLS1ilHsgY+Ox95EGg1JLh6Y+NM3PtrqcAAYQF9vtGBCN+1p?=
 =?us-ascii?Q?nWej7hTV6mA7QDc9LM8//8iKIobrFO6FQoSvwcAtmEWxHQGzcDGY6Ptsbyfi?=
 =?us-ascii?Q?+4KLCHd5wjRDKDoVGkVApvFkCHyJB0ADL4IbF3CRSbUe2EHpMP9UbtGFSd3O?=
 =?us-ascii?Q?Qm7qG4PkeR6Rmk9cU3ifM3boVvU8Bx2UcBDAxSiElViFtlXONVunrUDc8rOP?=
 =?us-ascii?Q?5g7KolkZggBqiPg2roJRCiHX5KeSrzr6UeZbrfY3DhXuCTE+nKACyE7ocUsG?=
 =?us-ascii?Q?DnJ50TbHAsuGctXw9MrX0c8QFub7fXW0s5gcA9DMnjvc4t1GVApGedWcE67i?=
 =?us-ascii?Q?sisgMpDdHayQ+dFp0sqVVr8lv4UsBXR74gnSDQxFb5+L1XVSl1EgkUpGKCPl?=
 =?us-ascii?Q?kYTQoJLy5G+Yz8faz51FBJOhW3SiBoo41g4cvTYjtP8PiXQ6sW1gv6fTKGmv?=
 =?us-ascii?Q?5OgavMAzO2FnZBuBs95l3bWTk+31f4n4zxnDEow37r6+tNQdjBBJzRSWrz+B?=
 =?us-ascii?Q?wnxfyIb9IVwiNJgco9rWMBQIUNUqxswL/1VN1h52LF/CV+QD4fGoDKSEsyll?=
 =?us-ascii?Q?hwBKebvm8WIfXb+S9LWO0/+5KL8vC0ES22Aw6sFKWTV1ZHNhLI0eQsvmwQTM?=
 =?us-ascii?Q?d6WM6fO7peiUy1QFg16B/0bR0si5MldA2Wwmq0v7PlDk3ulIf3bR0v9MiSmb?=
 =?us-ascii?Q?Q7ENpf3Ko/QffL5TJs1yuIdRfq5EGnk8FRMExJv8U+Enr3YOeah2p0UVZj+F?=
 =?us-ascii?Q?emxuOsHdkRGwYhyhVY4qifhI+GzjAGLnKdcX4t8GUefuWQxuchmAqkajAlIB?=
 =?us-ascii?Q?f0txOqpR/FygHo1ea7wHaeSqJfl4BlJELEGxRy1VOpDg4Zl07XA46RuVUArZ?=
 =?us-ascii?Q?Q3tsVigZfDHdQPEKO2jIrUnVpJ+Y846odUvfBOmc03h8UauJM8JoQlw/bnnv?=
 =?us-ascii?Q?soAtd/Wz5gcuq9t4GMRT0vE7DF3PcBdV67VTsxC/Wf4hpHV5Sg1GMtXR2bby?=
 =?us-ascii?Q?YawTz+5BDQ9tY5vhCNrShFOKyKTINBQAanuoiQeldIW9ZJTafYilZ6RgZcbk?=
 =?us-ascii?Q?zTmbZ0vbLOWZB7X9XTlwggGwSPNeufrWKZE31eO43YTM5ZwM55RHqoGIWbH3?=
 =?us-ascii?Q?oFhAfQWxp1PKRPtlpsnTYsOqJFhdX9yBLtrNHrLy0pKG8OEpHuTfFc+oKcNw?=
 =?us-ascii?Q?Es2QnZPHt5zeJRWComGbax8NByNL7GD78Zw5c5aYAkFwzObHOSSoNc7/YHw0?=
 =?us-ascii?Q?Ldmmi61Ck5t+D/Q5w/fX8ep4C7f67QW8QvymxXsoIydRpwPOUFHh7ovrR9FO?=
 =?us-ascii?Q?nZXt6hPnz4B5DHVkhmnzVeCoCytzU/vP9PzgmABYS7QZs5VfNhXrZZuHC9+g?=
 =?us-ascii?Q?2X/Svw1w9nNUdIsI/AFR1NTISODFv6DikmCokCJavQS+r6kCgT9RmCIJGcit?=
 =?us-ascii?Q?YH+ZCU8amsQOCgX6Be5k7qqca0qroAVe9RKjZZyYSiYWLp5fKKdQY9VFAoqY?=
 =?us-ascii?Q?olcV23pbts9RW+EfQnm85VXwq4lOLE28gWjmNOqvkXfZB7puxkZR+gxuVw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:13:23.3913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac410a9a-bfd8-447f-c39c-08ddaa62ee24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895

Axi gpio is going to have clocks as required property that's why it should
be also described in bindings which are using axi gpio node.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- New patch to fix reported as issue by the second patch
- https://lore.kernel.org/r/174954437576.4177094.15371626866789542129.robh@kernel.org

 Documentation/devicetree/bindings/fpga/fpga-region.yaml | 1 +
 1 file changed, 1 insertion(+)

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
 
-- 
2.43.0


