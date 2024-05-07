Return-Path: <linux-fpga+bounces-533-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FDB8BF1F3
	for <lists+linux-fpga@lfdr.de>; Wed,  8 May 2024 01:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41991C22F40
	for <lists+linux-fpga@lfdr.de>; Tue,  7 May 2024 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110EC14AD14;
	Tue,  7 May 2024 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaNUWpLK"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1214AD0A;
	Tue,  7 May 2024 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123466; cv=none; b=CNYUTxNZicjsip61lysYQZRU5vU+4xGG5XkDJBDIXazq1WjPCriOtEyRRr2StUuSIFe2pi7O+e/65Nj5t1G6bnIUY+RxJwBKvSX99A0J6YmCkpYmqnZ0VQ1WldK5UAf9qQq7VB/THzwv2pyDEFcWKASWhPj2OJtR2WTMAWJwDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123466; c=relaxed/simple;
	bh=/CV7Z6rF391rfbdBV98VvbhtFxwBt+jxT5UoV7D8kvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1G4p+zec+sM35WIPk5r5B/2TobqOlMdx8wMEULZcJBXeYaKRoc95TiHw9+zaMHKbwYmDL8VodTBKwy5KXl7ND1LrQooXV0xT+TgVolul5ZeGxXsoIYL80gajnTI8s0n5Rioz0JxZMNZ/3ryf0z1HfK71HcmnBtO7xguFYhmOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaNUWpLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AF8C4AF63;
	Tue,  7 May 2024 23:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123465;
	bh=/CV7Z6rF391rfbdBV98VvbhtFxwBt+jxT5UoV7D8kvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaNUWpLKwphTOQzIkLOZ0HTSTophQWs0GY9qTQlKopR8FTi9K+JkYqaUtmOfFNSsz
	 vN+dwwbWubOFPqPPXx87v6YLklGmuGSmMOPD64ZtY/ImeZmMJoJP6qfoSUQpdjxjQ1
	 qFjS5ufq0WhqH9tjlhqccAIXuFvQ2VjMqcEsa0QhChOwskEeMXr/hMeOdxbb/DhGrt
	 lqqHKx7La+x/t/C0KKJZqWBOQBPB5qFEaCghxOEXrNJBx8/Mq/YydGJ7AI17oeTrfb
	 +BXJ22JKF2Jf+XSQliyd8BNTTmwf8AQrTfRYP6BgwyHO4rh7XpyG6Z5RnmJADOn8AP
	 lI5oJ+pMI7O1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Colberg <peter.colberg@intel.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hao.wu@intel.com,
	mdf@kernel.org,
	linux-fpga@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/43] fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card
Date: Tue,  7 May 2024 19:09:38 -0400
Message-ID: <20240507231033.393285-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Peter Colberg <peter.colberg@intel.com>

[ Upstream commit bb1dbeceb1c20cfd81271e1bd69892ebd1ee38e0 ]

Add PCI subdevice ID for the Intel D5005 Stratix 10 FPGA card as
used with the Open FPGA Stack (OFS) FPGA Interface Manager (FIM).

Unlike the Intel D5005 PAC FIM which exposed a separate PCI device ID,
the OFS FIM reuses the same device ID for all DFL-based FPGA cards
and differentiates on the subdevice ID. The subdevice ID values were
chosen as the numeric part of the FPGA card names in hexadecimal.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20240422230257.1959-1-peter.colberg@intel.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/dfl-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 98b8fd16183e4..80cac3a5f9767 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -78,6 +78,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
 #define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
 /* PCI Subdevice ID for PCIE_DEVICE_ID_INTEL_DFL */
+#define PCIE_SUBDEVICE_ID_INTEL_D5005		0x138d
 #define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
 #define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
 #define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4
@@ -101,6 +102,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_D5005),},
 	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
 			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
 	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
-- 
2.43.0


