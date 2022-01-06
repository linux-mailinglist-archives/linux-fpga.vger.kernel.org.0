Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF4486CAE
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Jan 2022 22:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbiAFVtX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Jan 2022 16:49:23 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:54943 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiAFVtX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Jan 2022 16:49:23 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5adNntUw72lVY5adNnSlIt; Thu, 06 Jan 2022 22:49:22 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 22:49:22 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 03/16] fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Thu,  6 Jan 2022 22:49:20 +0100
Message-Id: <4a0a48fb682d13e6861f604d3cad3424672bee1f.1641500561.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In [1], Christoph Hellwig has proposed to remove the wrappers in
include/linux/pci-dma-compat.h.

Some reasons why this API should be removed have been given by Julia
Lawall in [2].

A coccinelle script has been used to perform the needed transformation.
It can be found in [3].


It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
This is less verbose.

The explicit 'ret = -EIO;' has been removed because
'dma_set_mask_and_coherent()' returns 0 or -EIO, so its return code can be
used directly.


[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
[3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
Reviewed in: https://lore.kernel.org/kernel-janitors/20210823025635.GA620145@yilunxu-OptiPlex-7050/
---
 drivers/fpga/dfl-pci.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4d68719e608f..96a11084bef4 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -354,16 +355,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 
 	pci_set_master(pcidev);
 
-	if (!pci_set_dma_mask(pcidev, DMA_BIT_MASK(64))) {
-		ret = pci_set_consistent_dma_mask(pcidev, DMA_BIT_MASK(64));
-		if (ret)
-			goto disable_error_report_exit;
-	} else if (!pci_set_dma_mask(pcidev, DMA_BIT_MASK(32))) {
-		ret = pci_set_consistent_dma_mask(pcidev, DMA_BIT_MASK(32));
-		if (ret)
-			goto disable_error_report_exit;
-	} else {
-		ret = -EIO;
+	ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
+	if (ret) {
 		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
 		goto disable_error_report_exit;
 	}
-- 
2.32.0

