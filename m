Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA223B3DC2
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 09:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFYHpI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 03:45:08 -0400
Received: from first.geanix.com ([116.203.34.67]:34902 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhFYHpI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 03:45:08 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 3EE7A4C41BE;
        Fri, 25 Jun 2021 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1624606965; bh=I4CaXQmrIoZGKkHneB3jqMMq5ESOCyFcDhfuGZWM4N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y/AEmpr4z+Vr+2ydH0NnwaAM3m5bu8dZ0dPyx6XR2TlM+aSEfyI1m/jTyRb/TLV9E
         JXNkcyjASYvQa0oxdLBy6Kp67/tOiPSkojTZk8iAbD6/sNecLLmVtK/JyknfmCo9LN
         Tmss7MYjzRQc4Axj9P3pasi8CxZFJG1MpF1/+90d+4TWUSEMVT1xAmNdarohK2jNS0
         9aUgDbh7yBMriGRZq1UPPryLP4T0encp1yNm7tdB2V4xm0xue7qGc19iOh/3zZg4Uo
         pnp/1d57VmzNnqOTx06C9CzQJGZOfSabdzbrrqzU21YghVoUskGQZlUIwVO8bta9TJ
         S80XzdohQUbcQ==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 1/5] fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
Date:   Fri, 25 Jun 2021 09:42:09 +0200
Message-Id: <20210625074213.654274-2-martin@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210625074213.654274-1-martin@geanix.com>
References: <20210625074213.654274-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Martin Hundebøll <mhu@silicom.dk>

This adds the approved PCI Express Device IDs for the Silicom PAC N5010
and N5011 cards (aka. Silicom Lightning Creek cards).

The N5010 features an FPGA that manages/interfaces four QSFP ports, and
allows on-board custom packet processing/filtering/routing, based on
logic loaded with user-provided FPGA bitstreams.

The N5011 cards adds a PCIe switch that exposes, in addition to the FPGA
itself, two Intel E810 (aka Columbiaville) ethernet controllers. With
this, packets can be forwarded from the FPGA to the host for further
processing.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
Acked-by: Wu Hao <hao.wu@intel.com>
---

Changes since v1:
 * Commit message is updated with card description
 * Added Hao's Acked-by

 drivers/fpga/dfl-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index b44523ea8c91..4d68719e608f 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -74,6 +74,9 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_PF_DSC_1_X		0x09C4
 #define PCIE_DEVICE_ID_INTEL_PAC_N3000		0x0B30
 #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
+#define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
+#define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
+
 /* VF Device */
 #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
 #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
@@ -90,6 +93,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
+	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
+	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
-- 
2.31.0

