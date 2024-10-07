Return-Path: <linux-fpga+bounces-756-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE719939C2
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Oct 2024 00:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE6828551F
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Oct 2024 22:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E2918CBE1;
	Mon,  7 Oct 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p9t1msqL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2118C93B;
	Mon,  7 Oct 2024 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338499; cv=fail; b=cctjQJCDm/OKhEDg1n7lDArp1Ajna5zxS+O3rcjHKNdEGWFtvn18KvhKKeIjP37NbLCJPzYEUgI5HVEN0RX27hzcs+2O0Ar32rAENOtWPYuUr2VWumTEkdKfCNank3OrYh8s7Nr7I6QdMP+gx+Kp0qH7GGffU1unOqFcwAEENbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338499; c=relaxed/simple;
	bh=0HihpjafPJikGUQIplfw/Y11aGqK/+GqslLNgJKgaV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGxObe1Gs7m0cTQ56svg2dVcFctFX0HlrzW9nFTErtTYFk/qG6iUx1eySlIK1hTDsJqZn/TotSZ6bkUSO/SXbGjjSK9Zw1csDDGfh1cmcuRVu8xBOif47qTZZCqzwXKmY+cJnz+VgITuApjhM4KqsT7+QmlEvSuMfi3DLEuV4XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p9t1msqL; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQcIfnZTZFZn0LMhrbHUjWCai2Den9bU9sM0JK/LoGdEvHcRTrhZ0d5Dq8Jh8eiJBKl8LOjjAusGGlvvhRIVdDvy4DEYrcWjoCcMI8Tt8aKI4KXIEo3wN5NObxYkZV35UU+Y8UOpTaLzwn0WH3pBW9IPPctwialo5+OO3LPxeXE0HS9qcF45gDoDTbwOnw9RFVJF6qFAc+3yKjm7wcyaU4fafklqgKyGnNJVJHBE7Pw2Cwrk8tUX7oe0emWscQ8CpoB4G22JBxOD/V+OXpiBRC2LLpX+KNS9dcDTmf02p4mGFHLhtpQD4mBzRomR0caRwGm5ZWTfOCL9Bzpszafl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri9NWmrgzg9r8/FzGs5wrRlTc+ijqL/Zn+1LG+tt9+w=;
 b=XquvEW1pKTTRFEZZNhrVqpfgNtjsXvtqSfGckLYwIKNxEwTiULHpOEq6u+o/KQnaLdbTjb9bb+4MP/bz3Wp+k+powSY3dPOsU5TGyiJFubl1gqD+6TxM5ejkgCQmIX3Y3tyDkxnyipnMw/Yt90R8ge0IFG5nU5kKJ8jEEk1phuBqOHO9KYClfzrYZQy+h9FmRb10bHB9RKuJDby18JwY0HupfR8XpOeFZiNOrEGDy5E90I8r40jfj/G4B12SXsoI03Bs1e9AIibCG3Ied/7WtftfQuSLAjimHVuIkIDN3cI5SG7KVhaA+SNAXzHS4rSP1ZjUhfbu6rObbPazdpAT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri9NWmrgzg9r8/FzGs5wrRlTc+ijqL/Zn+1LG+tt9+w=;
 b=p9t1msqLd/uZ7uv3j1J3LViMj4rM9qGuYdNBlUivU6E8XKg6s5/EjqwJ6o89kPwqXI+QD9TgqRg0q4aOrlv0he6umGZaWBaU7qw5vJJs5ZOS5jq2W9vrfk6GnaQoRy2+VXKVK+uK4Ehnl6h0Zhjy6GYZaq94RLwVg75iRt/mKcU=
Received: from BN8PR15CA0067.namprd15.prod.outlook.com (2603:10b6:408:80::44)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Mon, 7 Oct
 2024 22:01:33 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:80:cafe::8a) by BN8PR15CA0067.outlook.office365.com
 (2603:10b6:408:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 22:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Mon, 7 Oct 2024 22:01:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 17:01:33 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 17:01:32 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>, Nishad Saraf
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>
Subject: [PATCH V1 3/3] drivers/fpga/amd: Add remote queue service APIs
Date: Mon, 7 Oct 2024 15:01:28 -0700
Message-ID: <20241007220128.3023169-3-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007220128.3023169-1-yidong.zhang@amd.com>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb2fb01-93cc-4c6f-a5ef-08dce71b9b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?le5kTdSa7EwYOi4X87U2R+z08O8ya+vwGDGvgiTqD1jW18EZtxH7iye60HNX?=
 =?us-ascii?Q?C1oWYeJaec92TZlxWL7tjORiZQjDMNnSPjobblNQuLx7UgaQyuQdKt8Z87+V?=
 =?us-ascii?Q?0F4I8CqwdNusi/bBn9VrlasSEYkJKKK/pcPj17/8oaYZC2D1+zbqgwAbehKU?=
 =?us-ascii?Q?QD+LPI/3aaW2fboRozsjxAxCPUF/1/ONU3g0vn+3kDaKTKO2QEtmRdFJo/LB?=
 =?us-ascii?Q?ix/nmYhSGzH5tlI2NyQMGxOcq/ljaUjwQdCpOj6k/BQaQTSP2EaMk1Raw68N?=
 =?us-ascii?Q?XycOMwbs4EPuN7tx0tHUqp04ahps0Ee3uIBBxAqtfC2N6K2sc23N/V3jYLBs?=
 =?us-ascii?Q?mcF5I/Xb8QyLk2zPoXv0iqtF9Yf/4p9TD/+UQ36+Vf7p2xZKIwnNRMEyZ5Wx?=
 =?us-ascii?Q?HBYsXZBWAyOChS8MYvfleIfzfQTYxOdH17YMD8bqw6IzESjJAYmNUQmsefpA?=
 =?us-ascii?Q?Zi/la7r8SSTSKpKhUrh5XWKQIZQaAe84x+L99GjK+A+ksNnUWnQqJDSt5Ipp?=
 =?us-ascii?Q?3ynOjNF/idIcMpOnnFnEvmKLeb1nfOEnosXsGlMzOXvTmTRVWgZnrlFM2YJx?=
 =?us-ascii?Q?sw6PFcQOH1qJuNygZGqfbnHczsu/dTXTwQE377AmPHpG//OCiezr9EFI0b4d?=
 =?us-ascii?Q?rNqz1rzfOFHn+++/v73RQ1lWpZwCdGJ4+1mLaZ93hkH1qdDWojGmm6oGNf2h?=
 =?us-ascii?Q?DR1vlmLbA1FeqbAW/s7SuHj/AW/JpagbzVP3NBT6HhZH6Zq1MqBiBKZ86HE5?=
 =?us-ascii?Q?Y8waE9LVaBiFi0IPDchh1DwlVDx1tFLvzARd5F4NqNCGKPAcccdHV9CO16GZ?=
 =?us-ascii?Q?/ilB3LEG+MfNWaXCIXMIRhYnsWtMNt/LFe8fbWuGzM3AQzbO9QnPMuYtajxv?=
 =?us-ascii?Q?v8jrWPQVY5UkiEOezTerYsrODzKFGxmyHhPuWOaNq+Jfuj80FaG2AtXp9Nc7?=
 =?us-ascii?Q?BqpH0lvpFxYMORKnWdyuv+ujCkJFPhseXCGFCLJnCAaiFkwZNgKsk+bgFG1s?=
 =?us-ascii?Q?OgZ6tKOpItYBfpU5sJZawAi35q/CuGii4Oam3K/p8jXJGuoi528AaPZFpIId?=
 =?us-ascii?Q?GS3Oaz7CZ9h/W/sJC4Ye4+6ZnEZ3dB2kt59yC1xIWo1H9vTzZPJXjys3Ygjp?=
 =?us-ascii?Q?3vw/+FVc5SQkmkgUtIk/+lQjU/6cu351GFqDTChmK0rVGbUQptC5N6egT+Se?=
 =?us-ascii?Q?NLeg8Y0VXbH5aF85h9UImZc3UjLSozyf2Vkvq8xTIGt7npQkChR96zUNT8Ql?=
 =?us-ascii?Q?fa/2lpcpvRu0+yZTRdXfeH8Tlmrzo8pgucZh7NAJ814e3cR9NLIdrPozxaqK?=
 =?us-ascii?Q?KE6fvZZdEp+BZphOzZZPMFMEZ/F87Y3SrDH4sekoM111BP7h7YhtY6i6a4hS?=
 =?us-ascii?Q?HAxIY/EZg/PU2rL6RiRZOCCU9vUb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 22:01:33.3719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb2fb01-93cc-4c6f-a5ef-08dce71b9b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814

From: Yidong Zhang <yidong.zhang@amd.com>

Adds remote queue services inlcuding init, fini, and send command.

Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Co-developed-by: Prapul Krishnamurthy <prapulk@amd.com>
Signed-off-by: Prapul Krishnamurthy <prapulk@amd.com>
Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
---
 drivers/fpga/amd/vmgmt-rm-queue.c | 342 +++++++++++++++++++++++++++++-
 1 file changed, 341 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/amd/vmgmt-rm-queue.c b/drivers/fpga/amd/vmgmt-rm-queue.c
index fe805373ea32..f68439833d51 100644
--- a/drivers/fpga/amd/vmgmt-rm-queue.c
+++ b/drivers/fpga/amd/vmgmt-rm-queue.c
@@ -23,16 +23,356 @@
 #include "vmgmt-rm.h"
 #include "vmgmt-rm-queue.h"
 
+static inline struct rm_device *to_rdev_msg_monitor(struct work_struct *w)
+{
+	return container_of(w, struct rm_device, msg_monitor);
+}
+
+static inline struct rm_device *to_rdev_msg_timer(struct timer_list *t)
+{
+	return container_of(t, struct rm_device, msg_timer);
+}
+
+static inline int rm_queue_write(struct rm_device *rdev, u32 offset, u32 value)
+{
+	return regmap_write(rdev->shmem_regmap, rdev->queue_base + offset, value);
+}
+
+static inline int rm_queue_read(struct rm_device *rdev, u32 offset, u32 *value)
+{
+	return regmap_read(rdev->shmem_regmap, rdev->queue_base + offset, value);
+}
+
+static inline int rm_queue_bulk_read(struct rm_device *rdev, u32 offset,
+				     u32 *value, u32 size)
+{
+	if (size & 0x3) {
+		vmgmt_err(rdev->vdev, "size %d is not 4 Bytes aligned", size);
+		return -EINVAL;
+	}
+
+	return regmap_bulk_read(rdev->shmem_regmap, rdev->queue_base + offset,
+				value, DIV_ROUND_UP(size, 4));
+}
+
+static inline int rm_queue_bulk_write(struct rm_device *rdev, u32 offset,
+				      u32 *value, u32 size)
+{
+	if (size & 0x3) {
+		vmgmt_err(rdev->vdev, "size %d is not 4 Bytes aligned", size);
+		return -EINVAL;
+	}
+
+	return regmap_bulk_write(rdev->shmem_regmap, rdev->queue_base + offset,
+				 value, DIV_ROUND_UP(size, 4));
+}
+
+static inline int rm_queue_get_cidx(struct rm_device *rdev,
+				    enum rm_queue_type type, u32 *value)
+{
+	u32 off;
+
+	if (type == RM_QUEUE_SQ)
+		off = offsetof(struct rm_queue_header, sq_cidx);
+	else
+		off = offsetof(struct rm_queue_header, cq_cidx);
+
+	return rm_queue_read(rdev, off, value);
+}
+
+static inline int rm_queue_set_cidx(struct rm_device *rdev,
+				    enum rm_queue_type type, u32 value)
+{
+	u32 off;
+
+	if (type == RM_QUEUE_SQ)
+		off = offsetof(struct rm_queue_header, sq_cidx);
+	else
+		off = offsetof(struct rm_queue_header, cq_cidx);
+
+	return rm_queue_write(rdev, off, value);
+}
+
+static inline int rm_queue_get_pidx(struct rm_device *rdev,
+				    enum rm_queue_type type, u32 *value)
+{
+	if (type == RM_QUEUE_SQ)
+		return regmap_read(rdev->io_regmap, RM_IO_SQ_PIDX_OFF, value);
+	else
+		return regmap_read(rdev->io_regmap, RM_IO_CQ_PIDX_OFF, value);
+}
+
+static inline int rm_queue_set_pidx(struct rm_device *rdev,
+				    enum rm_queue_type type, u32 value)
+{
+	if (type == RM_QUEUE_SQ)
+		return regmap_write(rdev->io_regmap, RM_IO_SQ_PIDX_OFF, value);
+	else
+		return regmap_write(rdev->io_regmap, RM_IO_CQ_PIDX_OFF, value);
+}
+
+static inline u32 rm_queue_get_sq_slot_offset(struct rm_device *rdev)
+{
+	u32 index;
+
+	if ((rdev->sq.pidx - rdev->sq.cidx) >= rdev->queue_size)
+		return RM_INVALID_SLOT;
+
+	index = rdev->sq.pidx & (rdev->queue_size - 1);
+	return rdev->sq.offset + RM_CMD_SQ_SLOT_SIZE * index;
+}
+
+static inline u32 rm_queue_get_cq_slot_offset(struct rm_device *rdev)
+{
+	u32 index;
+
+	index = rdev->cq.cidx & (rdev->queue_size - 1);
+	return rdev->cq.offset + RM_CMD_CQ_SLOT_SIZE * index;
+}
+
+static int rm_queue_submit_cmd(struct rm_cmd *cmd)
+{
+	struct vmgmt_device *vdev = cmd->rdev->vdev;
+	struct rm_device *rdev = cmd->rdev;
+	u32 offset;
+	int ret;
+
+	mutex_lock(&rdev->queue);
+
+	offset = rm_queue_get_sq_slot_offset(rdev);
+	if (!offset) {
+		vmgmt_err(vdev, "No SQ slot available");
+		ret = -ENOSPC;
+		goto exit;
+	}
+
+	ret = rm_queue_bulk_write(rdev, offset, (u32 *)&cmd->sq_msg,
+				  sizeof(cmd->sq_msg));
+	if (ret) {
+		vmgmt_err(vdev, "Failed to write msg to ring, ret %d", ret);
+		goto exit;
+	}
+
+	ret = rm_queue_set_pidx(rdev, RM_QUEUE_SQ, ++rdev->sq.pidx);
+	if (ret) {
+		vmgmt_err(vdev, "Failed to update PIDX, ret %d", ret);
+		goto exit;
+	}
+
+	list_add_tail(&cmd->list, &rdev->submitted_cmds);
+exit:
+	mutex_unlock(&rdev->queue);
+	return ret;
+}
+
+static void rm_queue_withdraw_cmd(struct rm_cmd *cmd)
+{
+	mutex_lock(&cmd->rdev->queue);
+	list_del(&cmd->list);
+	mutex_unlock(&cmd->rdev->queue);
+}
+
+static int rm_queue_wait_cmd_timeout(struct rm_cmd *cmd, unsigned long timeout)
+{
+	struct vmgmt_device *vdev = cmd->rdev->vdev;
+	int ret;
+
+	if (wait_for_completion_timeout(&cmd->executed, timeout)) {
+		ret = cmd->cq_msg.data.rcode;
+		if (!ret)
+			return 0;
+
+		vmgmt_err(vdev, "CMD returned with a failure: %d", ret);
+		return ret;
+	}
+
+	/*
+	 * each cmds will be cleaned up by complete before it times out.
+	 * if we reach here, the cmd should be cleared and hot reset should
+	 * be issued.
+	 */
+	vmgmt_err(vdev, "cmd is timedout after, please reset the card");
+	rm_queue_withdraw_cmd(cmd);
+	return -ETIME;
+}
+
 int rm_queue_send_cmd(struct rm_cmd *cmd, unsigned long timeout)
 {
-	return 0;
+	int ret;
+
+	ret = rm_queue_submit_cmd(cmd);
+	if (ret)
+		return ret;
+
+	return rm_queue_wait_cmd_timeout(cmd, timeout);
+}
+
+static int rm_process_msg(struct rm_device *rdev)
+{
+	struct rm_cmd *cmd, *next;
+	struct vmgmt_device *vdev = rdev->vdev;
+	struct rm_cmd_cq_hdr header;
+	u32 offset;
+	int ret;
+
+	offset = rm_queue_get_cq_slot_offset(rdev);
+	if (!offset) {
+		vmgmt_err(vdev, "Invalid CQ offset");
+		return -EINVAL;
+	}
+
+	ret = rm_queue_bulk_read(rdev, offset, (u32 *)&header, sizeof(header));
+	if (ret) {
+		vmgmt_err(vdev, "Failed to read queue msg, %d", ret);
+		return ret;
+	}
+
+	list_for_each_entry_safe(cmd, next, &rdev->submitted_cmds, list) {
+		u32 value = 0;
+
+		if (cmd->sq_msg.hdr.id != header.id)
+			continue;
+
+		ret = rm_queue_bulk_read(rdev, offset + sizeof(cmd->cq_msg.hdr),
+					 (u32 *)&cmd->cq_msg.data,
+					 sizeof(cmd->cq_msg.data));
+		if (ret)
+			vmgmt_warn(vdev, "Failed to read queue msg, %d", ret);
+
+		ret = rm_queue_write(rdev, offset, value);
+		if (ret)
+			vmgmt_warn(vdev, "Failed to write queue msg, %d", ret);
+
+		list_del(&cmd->list);
+		complete(&cmd->executed);
+		return 0;
+	}
+
+	vmgmt_err(vdev, "Unknown cmd ID %d found in CQ", header.id);
+	return -EFAULT;
+}
+
+static void rm_check_msg(struct work_struct *w)
+{
+	struct rm_device *rdev = to_rdev_msg_monitor(w);
+	int ret;
+
+	mutex_lock(&rdev->queue);
+
+	ret = rm_queue_get_cidx(rdev, RM_QUEUE_SQ, &rdev->sq.cidx);
+	if (ret)
+		goto error;
+
+	ret = rm_queue_get_pidx(rdev, RM_QUEUE_CQ, &rdev->cq.pidx);
+	if (ret)
+		goto error;
+
+	while (rdev->cq.cidx < rdev->cq.pidx) {
+		ret = rm_process_msg(rdev);
+		if (ret)
+			break;
+
+		rdev->cq.cidx++;
+
+		ret = rm_queue_set_cidx(rdev, RM_QUEUE_CQ, rdev->cq.cidx);
+		if (ret)
+			break;
+	};
+
+error:
+	mutex_unlock(&rdev->queue);
+}
+
+static void rm_sched_work(struct timer_list *t)
+{
+	struct rm_device *rdev = to_rdev_msg_timer(t);
+
+	/* Schedule a work in the general workqueue */
+	schedule_work(&rdev->msg_monitor);
+	/* Periodic timer */
+	mod_timer(&rdev->msg_timer, jiffies + RM_COMPLETION_TIMER);
 }
 
 void rm_queue_fini(struct rm_device *rdev)
 {
+	del_timer_sync(&rdev->msg_timer);
+	cancel_work_sync(&rdev->msg_monitor);
+	mutex_destroy(&rdev->queue);
 }
 
 int rm_queue_init(struct rm_device *rdev)
 {
+	struct vmgmt_device *vdev = rdev->vdev;
+	struct rm_queue_header header = {0};
+	int ret;
+
+	INIT_LIST_HEAD(&rdev->submitted_cmds);
+	mutex_init(&rdev->queue);
+
+	ret = rm_queue_bulk_read(rdev, RM_HDR_OFF, (u32 *)&header,
+				 sizeof(header));
+	if (ret) {
+		vmgmt_err(vdev, "Failed to read RM shared mem, ret %d", ret);
+		goto error;
+	}
+
+	if (header.magic != RM_QUEUE_HDR_MAGIC_NUM) {
+		vmgmt_err(vdev, "Invalid RM queue header");
+		ret = -ENODEV;
+		goto error;
+	}
+
+	if (!header.version) {
+		vmgmt_err(vdev, "Invalid RM queue header");
+		ret = -ENODEV;
+		goto error;
+	}
+
+	sema_init(&rdev->sq.data_lock, 1);
+	sema_init(&rdev->cq.data_lock, 1);
+	rdev->queue_size = header.size;
+	rdev->sq.offset = header.sq_off;
+	rdev->cq.offset = header.cq_off;
+	rdev->sq.type = RM_QUEUE_SQ;
+	rdev->cq.type = RM_QUEUE_CQ;
+	rdev->sq.data_size = rdev->queue_buffer_size - RM_CMD_CQ_BUFFER_SIZE;
+	rdev->cq.data_size = RM_CMD_CQ_BUFFER_SIZE;
+	rdev->sq.data_offset = rdev->queue_buffer_start +
+			       RM_CMD_CQ_BUFFER_OFFSET + RM_CMD_CQ_BUFFER_SIZE;
+	rdev->cq.data_offset = rdev->queue_buffer_start +
+			       RM_CMD_CQ_BUFFER_OFFSET;
+	rdev->sq.cidx = header.sq_cidx;
+	rdev->cq.cidx = header.cq_cidx;
+
+	ret = rm_queue_get_pidx(rdev, RM_QUEUE_SQ, &rdev->sq.pidx);
+	if (ret) {
+		vmgmt_err(vdev, "Failed to read sq.pidx, ret %d", ret);
+		goto error;
+	}
+
+	ret = rm_queue_get_pidx(rdev, RM_QUEUE_CQ, &rdev->cq.pidx);
+	if (ret) {
+		vmgmt_err(vdev, "Failed to read cq.pidx, ret %d", ret);
+		goto error;
+	}
+
+	if (rdev->cq.cidx != rdev->cq.pidx) {
+		vmgmt_warn(vdev, "Clearing stale completions");
+		rdev->cq.cidx = rdev->cq.pidx;
+		ret = rm_queue_set_cidx(rdev, RM_QUEUE_CQ, rdev->cq.cidx);
+		if (ret) {
+			vmgmt_err(vdev, "Failed to cleanup CQ, ret %d", ret);
+			goto error;
+		}
+	}
+
+	/* Create and schedule timer to do recurring work */
+	INIT_WORK(&rdev->msg_monitor, &rm_check_msg);
+	timer_setup(&rdev->msg_timer, &rm_sched_work, 0);
+	mod_timer(&rdev->msg_timer, jiffies + RM_COMPLETION_TIMER);
+
 	return 0;
+error:
+	mutex_destroy(&rdev->queue);
+	return ret;
 }
-- 
2.34.1


