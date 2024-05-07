Return-Path: <linux-fpga+bounces-532-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D08BF184
	for <lists+linux-fpga@lfdr.de>; Wed,  8 May 2024 01:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640681F219CD
	for <lists+linux-fpga@lfdr.de>; Tue,  7 May 2024 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CEC13E024;
	Tue,  7 May 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGzAtnrF"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAFF13E022;
	Tue,  7 May 2024 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123322; cv=none; b=rgmjsG/S1rTMMd5o52uRkRtpwcHL5+msUr/Q9JHyH4f4iJj7YbENdj2pd/e4wcz3tEGMagznNF+zoowu4KQiTxk0aONA5a9sI1C/yvOKIEg+daA0b0h55PdX6W6cWoVGRX+c/Rgqp+x1CE5/+Kee9gE7oCqtfivfhYOl/pK+sOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123322; c=relaxed/simple;
	bh=/CV7Z6rF391rfbdBV98VvbhtFxwBt+jxT5UoV7D8kvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWHCqwt3mAlFNG6VLDMEGJ+4ImM19Vmr8Qlf7FP9MlZAOPOiiFgwOk6Ynrq571OCVdlNrIZJVvPhE6+oy2Sndf1ZlcDLCgDUzCMlFSRQem7yjoSnRiYKw+vO4EwzqEh2Ma/yuQIvqNGrhP+nFwJfjus1bC0w/5gljwTBV3rRxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGzAtnrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD13C4AF17;
	Tue,  7 May 2024 23:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123321;
	bh=/CV7Z6rF391rfbdBV98VvbhtFxwBt+jxT5UoV7D8kvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGzAtnrFp2mguCUgxZMN0CJVpSLtw/Jp3Dvnc8iabqwgz+f2+MqRHbPZYRBxPLulI
	 CekgzUKC9jNcgnZxYDYu0eBzMn49yvF6J99oEfp920rpI0CfXJhGOKjY4HFgiWowGM
	 GrjYCnw4+JtVI/d+jcZ3u13d285af3zzJLKv0L+1gNxbPzaa1SZXK/F0nR2EfdAGzE
	 6aUXr31lDKQ8g23Wani0HHOcfro93YeuEKLn3A9c+rWjIE6UeP2Gazfo1xtg9Ww4K7
	 /L50yWDishENC3KunhGcpF59LQMCkJmd+yqE9jNUtnSnIJ3nr/CBS9EpIFEwODnTKG
	 HM7RZpgm/XAxg==
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
Subject: [PATCH AUTOSEL 6.8 22/52] fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card
Date: Tue,  7 May 2024 19:06:48 -0400
Message-ID: <20240507230800.392128-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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


