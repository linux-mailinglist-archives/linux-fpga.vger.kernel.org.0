Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8957F6AF692
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Mar 2023 21:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjCGUTu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Mar 2023 15:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjCGUTq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Mar 2023 15:19:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9606FA335F;
        Tue,  7 Mar 2023 12:19:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25E5F6150F;
        Tue,  7 Mar 2023 20:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407A4C433EF;
        Tue,  7 Mar 2023 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220383;
        bh=JhW+CKgprn/5vnbwF0QA+NnQDPTQhLj/c4UBg/8yxPk=;
        h=From:To:Cc:Subject:Date:From;
        b=YFxNGlyn4QVoU6HXZqH7YyAEouQy/MFc6lZ7P7+na9ABVqOtL9vDfeDSMnUxCfPTy
         6PiC6yQIry+/VbX5cYlhfsY8h3R3L7HcSAhkCTg7wqGh/K6hPwc/fAm875+NWTKCMU
         j0IWChWorooJths53e7XTjhXcltUl3wxGtXEeYQI2JY+F/jUVMMpbLhERSFQm4tR6s
         iV4UlAmgEy4pef9vILeluh0z8Syb9SMeiQ5C6jF4enPbJzGfpcLk3Kw9sjhbCdxcxO
         qxgYnyVoIgtJ21OiJxPkuE+bEQzmxhWUwcqzjt7HnROkn7+Qv0tDv93hEekdv9CPAp
         S9hB2i0dFCVTA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] fpga: dfl-pci: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 14:19:37 -0600
Message-Id: <20230307201937.880084-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() enables the device to send ERR_*
Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core does this for all devices during enumeration, so the
driver doesn't need to do it itself.

Remove the redundant pci_enable_pcie_error_reporting() call from the
driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
from the driver .remove() path.

Note that this only controls ERR_* Messages from the device.  An ERR_*
Message may cause the Root Port to generate an interrupt, depending on the
AER Root Error Command register managed by the AER service driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/fpga/dfl-pci.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 0914e7328b1a..1bc04378118c 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -21,7 +21,6 @@
 #include <linux/module.h>
 #include <linux/stddef.h>
 #include <linux/errno.h>
-#include <linux/aer.h>
 
 #include "dfl.h"
 
@@ -376,10 +375,6 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 		return ret;
 	}
 
-	ret = pci_enable_pcie_error_reporting(pcidev);
-	if (ret && ret != -EINVAL)
-		dev_info(&pcidev->dev, "PCIE AER unavailable %d.\n", ret);
-
 	pci_set_master(pcidev);
 
 	ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
@@ -387,24 +382,22 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 		ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
-		goto disable_error_report_exit;
+		return ret;
 	}
 
 	ret = cci_init_drvdata(pcidev);
 	if (ret) {
 		dev_err(&pcidev->dev, "Fail to init drvdata %d.\n", ret);
-		goto disable_error_report_exit;
+		return ret;
 	}
 
 	ret = cci_enumerate_feature_devs(pcidev);
-	if (!ret)
+	if (ret) {
+		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
 		return ret;
+	}
 
-	dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
-
-disable_error_report_exit:
-	pci_disable_pcie_error_reporting(pcidev);
-	return ret;
+	return 0;
 }
 
 static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
@@ -448,7 +441,6 @@ static void cci_pci_remove(struct pci_dev *pcidev)
 		cci_pci_sriov_configure(pcidev, 0);
 
 	cci_remove_feature_devs(pcidev);
-	pci_disable_pcie_error_reporting(pcidev);
 }
 
 static struct pci_driver cci_pci_driver = {
-- 
2.25.1

