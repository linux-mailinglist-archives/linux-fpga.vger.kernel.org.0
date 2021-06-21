Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E1A3AE3C5
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFUHIz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 03:08:55 -0400
Received: from first.geanix.com ([116.203.34.67]:54084 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhFUHIq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 03:08:46 -0400
Received: from 185.17.218.86 (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 178754C3BB8;
        Mon, 21 Jun 2021 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=silicom.dk; s=first;
        t=1624259190; bh=e3h4F5C3FTTVvZujv41AeP7Sff71JQ2Cctc9Xe9XIFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=K+fM+uVUJKzZqm93n6/x114b/dsA0eaUMioKpKEdZvL0JHN4fMDBi3REyC5Zq7GqZ
         v4GylqkFXGTsKjVPImUInd66OLG2qbTp80wOIdTtp/FwMi+IMktUkLfcoy2ZIgumN4
         0pwlvxxhYnDUTeOARSOwDpeKzB1AwDtVHA2M5Oh94MR6yUPNFY8YXoGbctKqLWviHz
         JWNZtEiyBKhIYW8EPXQc/Tdn7inaHWkjeXY4usy9k4LwOd2IkBPjrmnn6taf86kp3a
         A/w/AQsb3fVLb+uDJ4Mech467WmpGANOU+JeCoGbudw6oUyF3tsLkc9/WAlZDGfS/J
         tcwOpTRQg85mQ==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
Subject: [PATCH 1/4] fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
Date:   Mon, 21 Jun 2021 09:06:18 +0200
Message-Id: <20210621070621.431482-2-mhu@silicom.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210621070621.431482-1-mhu@silicom.dk>
References: <20210621070621.431482-1-mhu@silicom.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,TVD_RCVD_IP,TVD_RCVD_IP4,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This adds the approved PCI Express Device IDs for the
Silicom PAC N5010 and N5011 cards.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---
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

